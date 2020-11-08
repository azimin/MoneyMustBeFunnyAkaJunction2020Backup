import SceneKit

class TabNode: SCNNode {
    var currentIndex = 0
    
    var tabNodes: [SCNNode] = []
    var contentNodes: [SCNNode] = []
    var navigationNode: SCNNode!

    override init() {
        super.init()
        let icons = [UIImage(named: "balance-icon"), UIImage(named: "stats-icon"), UIImage(named: "renew-icon")]
        for i in 0..<3 {
            let box = SCNPlane(width: 0.01, height: 0.01)
            
            let boxNode = SCNNode(geometry: box)
            
            boxNode.pivot = SCNMatrix4MakeTranslation(-Float(box.width) / 2, 0, 0)
            boxNode.position.x = Float(i) * Float(box.width) * 2
            boxNode.eulerAngles.x = -.pi / 2
            boxNode.geometry?.firstMaterial?.diffuse.contents = icons[i]
            boxNode.opacity = i == 0 ? 0.9 : 0.5
            self.tabNodes.append(boxNode)
            self.addChildNode(boxNode)
        }

        let box = SCNPlane(width: 0.014, height: 0.014)
        let boxNode = SCNNode(geometry: box)
        boxNode.pivot = SCNMatrix4MakeTranslation(-Float(box.width) / 2, 0, 0)
        let x = (0.01 * Float(0) * 2) - 0.004 / 2
        boxNode.position.x = x
        boxNode.position.y = -0.0001
        boxNode.eulerAngles.x = -.pi / 2
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "tab_selection")
        self.addChildNode(boxNode)
        self.navigationNode = boxNode

        let image = ARImageStoreService.shared.healthImage!
        let aspect = image.size.width / image.size.height
        let fakeBalance = SCNPlane(width: 0.1, height: 0.1 / aspect)
        fakeBalance.firstMaterial?.diffuse.contents = image
        let fakeBalanceNode = SCNNode(geometry: fakeBalance)
        fakeBalanceNode.eulerAngles.x = -.pi / 2
        fakeBalanceNode.position.z = Float(fakeBalance.height / 2) + 0.012
        fakeBalanceNode.position.x = 0.05
        
        self.addChildNode(fakeBalanceNode)
        
        let chartNode = ChartNode()
        chartNode.position.z = 0.08
        //chartNode.isHidden = true
        chartNode.opacity = 0
        chartNode.eulerAngles.x = .pi / 18
        self.addChildNode(chartNode)
        
        let fakeBalance1 = SCNPlane(width: 0.08, height: 0.08 * 1.2)
        fakeBalance1.firstMaterial?.diffuse.contents = UIImage(named: "subscription")
        let fakeBalanceNode1 = SCNNode(geometry: fakeBalance1)
        fakeBalanceNode1.eulerAngles.x = -.pi / 2
        fakeBalanceNode1.opacity = 0
        fakeBalanceNode1.position.z = Float(fakeBalance1.height / 2) + 0.01
        fakeBalanceNode1.position.x = Float(fakeBalance1.width / 2)
        
        self.addChildNode(fakeBalanceNode1)
        
        self.contentNodes = [fakeBalanceNode, chartNode, fakeBalanceNode1]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func next() {
        self.contentNodes[self.currentIndex].runAction(self.goOutAction)
        self.currentIndex = (currentIndex + 1) % self.tabNodes.count
        
        for node in self.tabNodes {
            node.opacity = 0.5
        }
        self.tabNodes[self.currentIndex].opacity = 0.9
        self.contentNodes[self.currentIndex].position.z -= 0.2
        self.contentNodes[self.currentIndex].scale = .init(0.8, 0.8, 0.8)
        self.contentNodes[self.currentIndex].opacity = 0.01
        (self.contentNodes[self.currentIndex] as? Transitionable)?.prepareForTransitionIn()
        self.contentNodes[self.currentIndex].runAction(.sequence([self.tabPresentationAction, .run({ (node) in
            (node as? Transitionable)?.onTransitionIn(duration: 0.1)
        })]) )

//        self.navigationNode.position.x = (0.01 * Float(self.currentIndex) * 2) - 0.004 / 2
        self.navigationNode.runAction(self.moveCoursorAction)
    }
    
    var tabPresentationAction: SCNAction {
        return .sequence([
            .group([
                .move(by: SCNVector3(0, 0, 0.16), duration: 0.2),
                .fadeIn(duration: 0.2),
                .scale(to: 1.2, duration: 0.2),
            ]),
            .group([
                .move(by: SCNVector3(0, 0, 0.04), duration: 0.2),
                .scale(to: 1.0, duration: 0.2)
            ]),
        ])
    }

    var moveCoursorAction: SCNAction {
        let x = (0.01 * Float(self.currentIndex) * 2) - 0.004 / 2
        let action = SCNAction.move(to: .init(x, self.navigationNode.position.y, self.navigationNode.position.z), duration: 0.3)
        action.timingMode = .easeOut
        return action
    }
    
    var goOutAction: SCNAction {
        return .sequence([
            .group([
                .move(by: SCNVector3(0, 0, -0.1), duration: 0.2),
                .fadeOut(duration: 0.2),
                .scale(to: 0.5, duration: 0.2),
            ]),
            .run({ node in
                node.position.z += 0.1
                node.scale = .init(1, 1, 1)
            })
        ])
    }
}
