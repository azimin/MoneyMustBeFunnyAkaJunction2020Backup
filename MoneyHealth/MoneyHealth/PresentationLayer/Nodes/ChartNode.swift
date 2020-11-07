import SceneKit
import Foundation

class ChartNode: SCNNode, Transitionable {
    var boxes: [SCNNode] = []
    var spends: [SCNNode] = []
    
    override init() {
        super.init()
        
        let containerNode = SCNNode()
        containerNode.eulerAngles.x = .pi
        let size: CGFloat = 0.01 * 6 + 0.01 * 7 / 2
        let imageNode = SCNPlane(width: size, height: size)
        imageNode.firstMaterial?.diffuse.contents = UIImage(named: "axes")
        imageNode.firstMaterial?.isDoubleSided = true
        let coordinateSpaceNode = SCNNode(geometry: imageNode)
        coordinateSpaceNode.position.x = Float(size) / 2 - 0.01 / 2
        containerNode.addChildNode(coordinateSpaceNode)
        coordinateSpaceNode.position.y = -Float(imageNode.width) * 0.15
        
        let heights: [CGFloat] = [0.022, 0.011, 0.049, 0.04, 0.08, 0.017].map { 0.8 * $0}
        for i in 0..<6 {
            let boxGeometry = SCNCylinder(radius: 0.005, height: heights[i])
            boxGeometry.materials.forEach  { $0.transparency = 0.5 }
            let boxNode = SCNNode(geometry: boxGeometry)
            boxNode.pivot = SCNMatrix4MakeTranslation(0, Float(boxGeometry.height / 2), 0)
            boxNode.eulerAngles.x = -.pi / 2
            boxNode.position.x = Float(i + 1) * Float(0.005) + Float(i) * Float(0.005 * 2)
            
            let extraMaterial = SCNMaterial()
            extraMaterial.diffuse.contents = UIImage(named: "circle")
            extraMaterial.isDoubleSided = true
            boxNode.geometry?.materials.append(extraMaterial)
            
            let extraMaterial2 = SCNMaterial()
            extraMaterial2.diffuse.contents = UIImage(named: "circle")
            extraMaterial2.isDoubleSided = true
            boxNode.geometry?.materials.append(extraMaterial2)
            containerNode.addChildNode(boxNode)
            
            let spendImage = SCNPlane(width: 0.02, height: 0.01)
            
            spendImage.firstMaterial?.diffuse.contents = UIImage(named: "spend\(i + 1)")
            spendImage.firstMaterial?.isDoubleSided = true
            let spendNode = SCNNode(geometry: spendImage)
            spendNode.eulerAngles.x = -.pi / 2
            spendNode.position.x = boxNode.position.x
            spendNode.position.z = Float(-heights[i] - 0.001 - spendImage.height / 2)
            self.addChildNode(spendNode)
            self.boxes.append(boxNode)
            self.spends.append(spendNode)
        }
        
        self.addChildNode(containerNode)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareForTransitionIn() {
        self.boxes.forEach {
            $0.scale.y = 0.01
        }
        self.spends.forEach {
            $0.opacity = 0.01
        }
    }
    
    func onTransitionIn(duration: TimeInterval) {
        
        (0..<self.boxes.count).forEach {
            self.boxes[$0].runAction(
                .sequence([.wait(duration: TimeInterval($0) * 0.06),
                           
                           .customAction(duration: duration, action: { (node, progress) in
                            let fraction = progress / CGFloat(duration)
                            node.scale.y = Float(fraction)
                           })]))
        }
        self.spends.forEach {
            $0.runAction(.fadeIn(duration: duration))
        }
    }
    
    func onTransitionOut() {
        
    }
}
