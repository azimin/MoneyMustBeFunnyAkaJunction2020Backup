import ARKit
import SceneKit
import UIKit
import Vision

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    /// The view controller that displays the status and "restart experience" UI.
    lazy var statusViewController: StatusViewController = {
        return children.lazy.compactMap({ $0 as? StatusViewController }).first!
    }()
    
    /// A serial queue for thread safety when modifying the SceneKit node graph.
    let updateQueue = DispatchQueue(label: Bundle.main.bundleIdentifier! +
        ".serialSceneKitQueue")
    
    /// Convenience accessor for the session owned by ARSCNView.
    var session: ARSession {
        return sceneView.session
    }
    
    let thumbView = UIView()
    var velocities: [Float] = []
    var lastRotation: Float? = nil
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.session.delegate = self

        // Hook up status view controller callback(s).
        statusViewController.restartExperienceHandler = { [unowned self] in
            self.restartExperience()
        }
        
        thumbView.backgroundColor = .red
        thumbView.frame.size = .init(width: 16, height: 16)
        self.sceneView.addSubview(thumbView)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Prevent the screen from being dimmed to avoid interuppting the AR experience.
        UIApplication.shared.isIdleTimerDisabled = true

        // Start the AR experience
        resetTracking()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        session.pause()
    }

    // MARK: - Session management (Image detection setup)
    
    /// Prevents restarting the session while a restart is in progress.
    var isRestartAvailable = true

    /// Creates a new AR configuration to run on the `session`.
    /// - Tag: ARReferenceImage-Loading
    func resetTracking() {
        
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
            fatalError("Missing expected asset catalog resources.")
        }
        
        let configuration = ARImageTrackingConfiguration()
        configuration.trackingImages = referenceImages
        session.run(configuration, options: [.resetTracking, .removeExistingAnchors])

        statusViewController.scheduleMessage("Look around to detect images", inSeconds: 7.5, messageType: .contentPlacement)
    }

    // MARK: - ARSCNViewDelegate (Image detection results)
    /// - Tag: ARImageAnchor-Visualizing
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        let referenceImage = imageAnchor.referenceImage
        updateQueue.async {
            
            // Create a plane to visualize the initial position of the detected image.
            let plane = SCNPlane(width: referenceImage.physicalSize.width,
                                 height: referenceImage.physicalSize.height)
            let planeNode = SCNNode(geometry: plane)
            planeNode.opacity = 0.25
            
            /*
             `SCNPlane` is vertically oriented in its local coordinate space, but
             `ARImageAnchor` assumes the image is horizontal in its local space, so
             rotate the plane to match.
             */
            planeNode.eulerAngles.x = -.pi / 2
            
            /*
             Image anchors are not tracked after initial detection, so create an
             animation that limits the duration for which the plane visualization appears.
             */
            planeNode.runAction(self.imageHighlightAction)
            
            // Add the plane visualization to the scene.
            node.addChildNode(planeNode)
            
            let tabNode = TabNode()
            tabNode.opacity = 0
            tabNode.scale = .init(0.6, 0.6, 0.6)
            tabNode.rotation.x = .pi / 3
            tabNode.position.z = -0.15
            tabNode.position.x = -0.20
            tabNode.runAction(self.tabPresentationAction)
            node.addChildNode(tabNode)
        }

        DispatchQueue.main.async {
            let imageName = referenceImage.name ?? ""
            self.statusViewController.cancelAllScheduledMessages()
            self.statusViewController.showMessage("Detected image “\(imageName)”")
        }
    }

    var imageHighlightAction: SCNAction {
        return .sequence([
            .wait(duration: 0.25),
            .fadeOpacity(to: 0.85, duration: 0.25),
            .fadeOpacity(to: 0.15, duration: 0.25),
            .fadeOpacity(to: 0.85, duration: 0.25),
            .fadeOut(duration: 0.5),
            .removeFromParentNode()
        ])
    }
    
    var tabPresentationAction: SCNAction {
        return .sequence([
            .wait(duration: 0.15),
            .group([
                .move(by: SCNVector3(0, 0, 0.05), duration: 0.3),
                .fadeIn(duration: 0.3),
                .scale(to: 1.2, duration: 0.3),
                .rotateTo(x: .pi/6, y: 0, z: 0, duration: 0.3)
            ]),
            .group([
                .scale(to: 1.0, duration: 0.3),
                .rotateTo(x: 0, y: 0, z: 0, duration: 0.3)
            ]),
        ])
    }
    
    var tabChangeAction: SCNAction {
        return .sequence([
                .rotateTo(x: .pi / 3, y: 0, z: 0, duration: 0.1),
                .rotateTo(x: 0, y: 0, z: 0, duration: 0.3)
        ])
    }
}


extension ViewController: ARSessionDelegate {
    
    // MARK: - ARSessionDelegate
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        let capturedFrame = frame.capturedImage
        
        guard let cardAnchor = frame.anchors.first,
              let node = self.sceneView.node(for: cardAnchor) else {
            return
        }
        
        guard let lastRotation = self.lastRotation else {
            self.lastRotation = node.rotation.z
            return
        }
        
        let velocity = node.rotation.z - lastRotation
        
        self.lastRotation = node.rotation.z
        
        self.velocities.append(-velocity)
        
        if velocities.count > 5 {
            self.velocities.remove(at: 0)
        }
        
        if velocities.count > 3 {
            if sign(velocities[velocities.count - 1]) != sign(velocities[velocities.count - 2]) && velocities[0..<velocities.count - 1].map { abs($0) }.reduce(0, +) / Float(velocities.count - 1) > 0.025 {
                print("shake!!!")
                self.velocities.removeAll()
                self.lastRotation = nil
                
                let tabNode = (node.childNodes.first { $0 as? TabNode != nil } as! TabNode)
                tabNode.next()
                tabNode.runAction(self.tabChangeAction)
            }
        }
        
        
        
        
//        let handler = VNImageRequestHandler(cvPixelBuffer: capturedFrame, orientation: .left, options: [:])
//        do {
//            // Perform VNDetectHumanHandPoseRequest
//            try handler.perform([handPoseRequest])
//            // Continue only when a hand was detected in the frame.
//            // Since we set the maximumHandCount property of the request to 1, there will be at most one observation.
//            guard let observation = handPoseRequest.results?.first else {
//                return
//            }
//            // Get points for thumb and index finger.
//            let thumbPoints = try observation.recognizedPoints(.thumb)
//            // Look for tip points.
//            guard let thumbTipPoint = thumbPoints[.thumbTip] else {
//                return
//            }
//            // Ignore low confidence points.
//            guard thumbTipPoint.confidence > 0.3 else {
//                return
//            }
//            // Convert points from Vision coordinates to AVFoundation coordinates.
//            let thumbTip = CGPoint(x: 1 - thumbTipPoint.location.x, y: thumbTipPoint.location.y)
//            print(thumbTip)
//
//            self.thumbView.center = CGPoint(x: self.sceneView.bounds.width * thumbTip.x,
//                                            y: self.sceneView.bounds.height * thumbTip.y)
//
//        } catch {
//            print("error")
//        }
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        statusViewController.showTrackingQualityInfo(for: camera.trackingState, autoHide: true)
        
        switch camera.trackingState {
        case .notAvailable, .limited:
            statusViewController.escalateFeedback(for: camera.trackingState, inSeconds: 3.0)
        case .normal:
            statusViewController.cancelScheduledMessage(for: .trackingStateEscalation)
        }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        guard error is ARError else { return }
        
        let errorWithInfo = error as NSError
        let messages = [
            errorWithInfo.localizedDescription,
            errorWithInfo.localizedFailureReason,
            errorWithInfo.localizedRecoverySuggestion
        ]
        
        // Use `flatMap(_:)` to remove optional error messages.
        let errorMessage = messages.compactMap({ $0 }).joined(separator: "\n")
        
        DispatchQueue.main.async {
            self.displayErrorMessage(title: "The AR session failed.", message: errorMessage)
        }
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        blurView.isHidden = false
        statusViewController.showMessage("""
        SESSION INTERRUPTED
        The session will be reset after the interruption has ended.
        """, autoHide: false)
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        blurView.isHidden = true
        statusViewController.showMessage("RESETTING SESSION")
        
        restartExperience()
    }
    
    func sessionShouldAttemptRelocalization(_ session: ARSession) -> Bool {
        return true
    }
    
    // MARK: - Error handling
    
    func displayErrorMessage(title: String, message: String) {
        // Blur the background.
        blurView.isHidden = false
        
        // Present an alert informing about the error that has occurred.
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Restart Session", style: .default) { _ in
            alertController.dismiss(animated: true, completion: nil)
            self.blurView.isHidden = true
            self.resetTracking()
        }
        alertController.addAction(restartAction)
        present(alertController, animated: true, completion: nil)
    }

    // MARK: - Interface Actions
    
    func restartExperience() {
        guard isRestartAvailable else { return }
        isRestartAvailable = false
        
        statusViewController.cancelAllScheduledMessages()
        
        resetTracking()
        
        // Disable restart for a while in order to give the session time to restart.
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.isRestartAvailable = true
        }
    }
    
}
