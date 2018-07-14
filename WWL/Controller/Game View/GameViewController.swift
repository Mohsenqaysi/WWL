//
//  GameViewController.swift
//  WWL
//
//  Created by Mohsen Qaysi on 7/14/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import UIKit
import ARKit

enum BoxBodyType : Int {
    case bullet = 1
    case barrier = 2
}

class GameViewController: UIViewController, ARSCNViewDelegate,SCNPhysicsContactDelegate {
    /// Source for audio playback
    var audioSource: SCNAudioSource!
    
    var parnatNode: SCNNode! = nil {
        didSet{
            print("Node was assinged")
        }
    }
    var currentPossion: SCNVector3? = nil {
        didSet {
//            print("new postions was set: \(currentPossion.debugDescription)")
        }
    }
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    
    let itemsArray: [String] = ["blueCounter","greenCounter"]
    let configuration = ARWorldTrackingConfiguration()
    var selectedItem: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemsCollectionView.isHidden = true
        self.itemsCollectionView.isScrollEnabled = false
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        self.configuration.planeDetection = .horizontal
        self.sceneView.session.run(configuration)
        // Runs the Function to configure cell in a Collection View
        self.itemsCollectionView.dataSource = self
        // Runs the function to turn the selected cell to Green
        self.itemsCollectionView.delegate = self
        self.sceneView.delegate = self
        // Add Omnidirectional Light
        self.sceneView.autoenablesDefaultLighting = true
        // MARK: - enable physicsWorld contact
        self.sceneView.scene.physicsWorld.contactDelegate = self
        
        self.registerGestureRecognizers()
    }
    // MARK: registerGestureRecognizers
    func registerGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panned))
        self.sceneView.addGestureRecognizer(panGestureRecognizer)
    }
    
    // Function to Detect Tap
    @objc func tapped(sender: UITapGestureRecognizer){
        // Find out the tap only on the horizontal surface found in Scene View
        let sceneView = sender.view as! ARSCNView
        let tapLocation = sender.location(in: sceneView)
        // Match the location of tap with the location of the Horizontal Plane
        // Checks that the location of tap "tapLocation" matches the location of plane "existingPlaneUsingExtent"
        // If the tap is on plane, the hitTest array will have result values or else it'll be empty
        let hitTest = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
        if !hitTest.isEmpty {
            // print("Touched a Horizontal Surface !!")
            self.addItem(hitTestResult: hitTest.first!)
        }
        // else{
        //  print("Tapped somewhere else in the Scene !!")
        // }
    }
    
    @objc func panned(recognizer: UIPanGestureRecognizer) {
        recognizer.maximumNumberOfTouches = 1
        let location = recognizer.location(in: sceneView)
        let arHitResult = sceneView.hitTest(location, types: .existingPlane)
        if recognizer.state == .began {
            virtualObject(at: location)
        }
        if recognizer.state == .changed {
            if !arHitResult.isEmpty {
                guard let hit = arHitResult.first else {return}
                let transform = hit.worldTransform.columns.3
                // call the setCurrentObjectPostion on the plane
                if let node = parnatNode {
                    if !doesNotEqualToStaticNodes(nodeName: node.name) {
//                        currentPossion = SCNVector3(transform.x,transform.y,transform.z)
                        currentPossion = SCNVector3(transform.x,(transform.y + yChildNodePosition),transform.z)
//                        print("node.name: \(String(describing: node.name))")
                        setCurrentObjectPostion(for: node, at: currentPossion!)
                    } else {
                        print("\(StaticNodes.farmPlanefinal.rawValue) was found")
                    }
                }
            }
//            setUpAudio()
        }
        if recognizer.state == .ended {
            if  let node = parnatNode {
                if !doesNotEqualToStaticNodes(nodeName: node.name) {
                } else {
                    print("\(StaticNodes.farmPlanefinal.rawValue) was found")
                    print("node is set to nil")
                }
//                playSound(for: parnatNode!)
            }
        }
    }
    
    // MARK: - StaticNodes
    fileprivate enum StaticNodes: String {
        case farmPlanefinal = "farmPlanefinal"
        case counterBaseOneNode = "counterBaseOneNode"
        case counterBaseTwoNode = "counterBaseTwoNode"
    }
    
    fileprivate func doesNotEqualToStaticNodes(nodeName: String?) -> Bool {
        switch nodeName {
        case StaticNodes.farmPlanefinal.rawValue:
            return true
        case StaticNodes.counterBaseOneNode.rawValue:
            return true
        case StaticNodes.counterBaseTwoNode.rawValue:
            return true
        default:
            return false
        }
    }
    
    /// Hit tests against the `sceneView` to find an object at the provided point.
    fileprivate func virtualObject(at point: CGPoint) {
        let hitTestOptions: [SCNHitTestOption : Any] = [SCNHitTestOption.searchMode : true]
        let hitTestResults = sceneView.hitTest(point, options: hitTestOptions)
        if !hitTestResults.isEmpty {
            let allNodes = hitTestResults
            print("virtualObject nodes: \(allNodes.enumerated())")
            let hitNode = hitTestResults.first!
            guard let nodeName = hitNode.node.name else {return}
            print("nodeName: \(nodeName)")
            parnatNode = hitNode.node
            print("virtualObject was found")
        }
    }
    
    fileprivate func setCurrentObjectPostion(for node: SCNNode, at location: SCNVector3){
        DispatchQueue.main.async {
            SCNTransaction.begin()
            node.worldPosition = location
            SCNTransaction.commit()
        }
    }
    
    // Function to Place items on a Horizontal Surface
    func addItem(hitTestResult: ARHitTestResult){
        if let selectedItem = self.selectedItem {
            // When Plane is detected, place the object on that
            let scene = SCNScene(named: "Models.scnassets/\(selectedItem).scn")
            let node = (scene?.rootNode.childNode(withName: selectedItem,recursively:false))!
            // Get transform matrix to get the values to place objects right on top of horzontal surface detected
            let transform = hitTestResult.worldTransform
            // Position of detected surface is in 3rd column of transform matrix
            let thirdColumn = transform.columns.3
            // Position the Object node right where the detected surface is
            
            node.position = SCNVector3(thirdColumn.x,thirdColumn.y + yChildNodePosition,thirdColumn.z)
            print("added node location: \(node.position)")
            
            // MARK: add SCNPhysicsBody and BitMask to add Nodes
            node.name = "Bullet"
            node.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
            node.physicsBody?.categoryBitMask = BoxBodyType.bullet.rawValue
            node.physicsBody?.contactTestBitMask = BoxBodyType.barrier.rawValue
            node.physicsBody?.isAffectedByGravity = false // stop it from falling to the ground
            self.sceneView.scene.rootNode.addChildNode(node)
            if node.name != StaticNodes.farmPlanefinal.rawValue {
                //                addAnimation(node: node)
            }
        }
    }
    
    // MARK: Renderer SCNNodes
    let farmPlanefinal = "farmPlanefinal"
    let yRootNodePosition: Float = 0.003
    let yChildNodePosition: Float = 0.04
    
    // plane
    var planScene: SCNScene!
    var counterBaseOneNode: SCNNode!
    var counterBaseTwoNode: SCNNode!
    
    // polyPlanefinalScene
    var polyPlanefinalScene: SCNScene!
    var polyPlanefinalNode: SCNNode!
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        print("planeAnchor location: \(planeAnchor.center)")
        
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z + -0.1)
        print("ogiginal object location : x: \(x) y: \(y) z: \(z)")
        
        //        // testing
        //        planScene = SCNScene(named: "Models.scnassets/cylinderGreen.scn")
        //        planegNode = planScene.rootNode.childNode(withName: "cylinderGreen", recursively: false)
        
        // testing
        polyPlanefinalScene = SCNScene(named: "Models.scnassets/\(StaticNodes.farmPlanefinal.rawValue).scn")
        polyPlanefinalNode = polyPlanefinalScene.rootNode.childNode(withName: "\(StaticNodes.farmPlanefinal.rawValue)", recursively: false)
        
        // counterBaseOne
        counterBaseOneNode = polyPlanefinalScene.rootNode.childNode(withName: StaticNodes.counterBaseOneNode.rawValue, recursively: true)
        counterBaseOneNode.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
        counterBaseOneNode.physicsBody?.categoryBitMask = BoxBodyType.barrier.rawValue
        
        // counterBaseTwo
        counterBaseTwoNode = polyPlanefinalScene.rootNode.childNode(withName: StaticNodes.counterBaseTwoNode.rawValue, recursively: true)
        counterBaseTwoNode.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
        counterBaseTwoNode.physicsBody?.categoryBitMask = BoxBodyType.barrier.rawValue
        
        //        guard let confettiNode = polyPlanefinalScene.rootNode.childNode(withName: "confettiNode", recursively: true),
        //            let confetti = SCNParticleSystem(named: "Models.scnassets/textures/confetti.scnp", inDirectory: nil) else {
        //            print("did not find confetti effect ")
        //            return
        //        }
        //        // MARK:- add addParticleSystem node
        //        confettiNode.addParticleSystem(confetti)
        //        confetti.particleVelocity = 0.9
        //
        ////        // Enable physics interaction
        //        confettiNode.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
        //        confettiNode.physicsBody?.categoryBitMask = BoxBodyType.barrier.rawValue
        //        node.addChildNode(confettiNode)
    
        // Add the base node
        polyPlanefinalNode.name = StaticNodes.farmPlanefinal.rawValue
        polyPlanefinalNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        polyPlanefinalNode.position = SCNVector3(x,y,z)
        
        
        node.addChildNode(polyPlanefinalNode)
        print("node was added..")
        // Hide debugOptions
        sceneView.debugOptions = []
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.itemsCollectionView.isHidden = false
            self.itemsCollectionView.loadingCellAnimation()
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//            self.itemsCollectionView.loadingCellAnimation()
//            self.itemsCollectionView.isHidden = false
//            self.itemsCollectionView.backgroundView?.alpha = 0
//            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
//                self.itemsCollectionView.backgroundView?.alpha = 1
//                self.itemsCollectionView.layoutIfNeeded()
//                self.view.layoutIfNeeded()
//            }, completion: nil)
//        }
    }
    
    // MARK: - PhysicsWorld
    var lastContactNode :SCNNode!
    
    func physicsWorld(_ world: SCNPhysicsWorld, didEnd contact: SCNPhysicsContact) {
        print("physicsWorld I was called...")
        /*
         //        var contactNode: SCNNode!
         //        if contact.nodeA.name == "Bullet" {
         //            contactNode = contact.nodeB
         //        } else {
         //            contactNode = contact.nodeA
         //            contact.nodeA.physicsBody?.isAffectedByGravity = false
         //        }
         //
         //        if self.lastContactNode != nil && self.lastContactNode == contactNode {
         //            return
         //        }
         //        self.lastContactNode = contactNode
         //
         //        guard let detectedColor = lastContactNode.geometry?.firstMaterial?.diffuse.contents.debugDescription else {return}
         //        print("Box Materials: \(detectedColor)")
         //        print("********************* Color **************************")
         //        if UIExtendedSRGBColorSpaceToUIColor.red.rawValue == detectedColor {
         //            print(colorName[UIExtendedSRGBColorSpaceToUIColor.red.rawValue]!)
         //        } else if UIExtendedSRGBColorSpaceToUIColor.blue.rawValue == detectedColor {
         //            print(colorName[UIExtendedSRGBColorSpaceToUIColor.blue.rawValue]!)
         //        } else {
         //            print("new color: \(detectedColor) ")
         //        }
         //        print("node name: \(lastContactNode.name?.description)")
         //        print("**********************************************")
         */
        
    }
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        print("didBegin I was called")
        lastContactNode = nil
        
        var contactNode: SCNNode!
        if contact.nodeA.name == "Bullet" {
            contactNode = contact.nodeA
        } else {
            contactNode = contact.nodeB
        }
        
        if self.lastContactNode != nil && self.lastContactNode == contactNode {
            return
        }
        self.lastContactNode = contactNode
        
        guard let detectedColor = lastContactNode.geometry?.firstMaterial?.diffuse.contents.debugDescription else {return}
        print("Box Materials: \(detectedColor)")
        print("********************* Color **************************")
        
        if UIExtendedSRGBColorSpaceToUIColor2.green.keys.first == detectedColor {
            print(UIExtendedSRGBColorSpaceToUIColor2.green.values.first as Any)
        } else if UIExtendedSRGBColorSpaceToUIColor2.blue.keys.first  == detectedColor {
            print(UIExtendedSRGBColorSpaceToUIColor2.blue.values.first as Any)
        } else {
            print("new color: \(detectedColor) ")
        }
        print("node name: \(String(describing: lastContactNode.name?.description))")
        print("**********************************************")
    }
    
    struct UIExtendedSRGBColorSpaceToUIColor2: Hashable {
        static let green = ["Optional(UIExtendedSRGBColorSpace 0.197085 0.571505 0.156546 1)" : "GreenColor" ]
        static let blue = ["Optional(UIExtendedSRGBColorSpace 0.0395691 0.337999 0.71286 1)": "BlueColor"]
    }
    
}

extension GameViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    // How many cells the colection displays
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    // Configures every single source cell in collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! itemCell
        cell.layer.cornerRadius = 5
        // Shows the images from Array
        cell.counterImageView.image = UIImage(named: self.itemsArray[indexPath.row])
        return cell
    }
    
    // Function to turn the label to green when the item is selected
    // This function gets triggered whenever we select a cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        self.selectedItem = itemsArray[indexPath.row]
        cell?.backgroundColor = (indexPath.row == 0) ? UIColor.blue : UIColor.green
        cell?.bounceCellEffect()
    }
    
    // Function to change the cell color back to normal on deselction
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = (indexPath.row == 0) ?  UIColor.clear : UIColor.clear
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let viewWidth = Int(self.view.frame.width)
        let CELL_WIDTH = 150
        let numberOfCells = self.itemsArray.count
        let CELL_SPACING = 20
        let totalCellWidth: Int = CELL_WIDTH * numberOfCells
        let totalSpacingWidth: Int = CELL_SPACING * (numberOfCells - 1)
        let leftInset: Int = (viewWidth - (totalCellWidth + totalSpacingWidth)) / 2
        let rightInset: Int = leftInset
        return UIEdgeInsetsMake(0, CGFloat(leftInset), 0, CGFloat(rightInset))
//        let cellWidth: CGFloat = 150.0 // Your cell width
//
//        let numberOfCells = floor(self.view.frame.size.width / cellWidth)
//        let edgeInsets = (self.view.frame.size.width - (numberOfCells * cellWidth)) / (numberOfCells + 1)
//        return UIEdgeInsetsMake(0, edgeInsets, 0, edgeInsets)
    }
    
    // MARK: set up aniamtion
    
    func addAnimation(node: SCNNode) {
        //        let rotateOne = SCNAction.rotateBy(x: 0, y: CGFloat(Float.pi), z: 0, duration: 5.0)
        let hoverUp = SCNAction.moveBy(x: 0, y: 0.03, z: 0, duration: 1.5)
        let hoverDown = SCNAction.moveBy(x: 0, y: -0.03, z: 0, duration: 1.5)
        let hoverSequence = SCNAction.sequence([hoverUp, hoverDown])
        //        let rotateAndHover = SCNAction.group([hoverSequence])
        let repeatForever = SCNAction.repeatForever(hoverSequence)
        node.runAction(repeatForever)
    }
    
    // MARK: - Setup audio playback
    // MARK: - Sound
    /// Sets up the audio for playback.
    // Tag: - SetUpAudio
    private func setUpAudio() {
        // Instantiate the audio source
        if let file = SCNAudioSource(fileNamed: "dropSound.mp3"){
            audioSource = file
        }
        // As an environmental sound layer, audio should play indefinitely
        //        audioSource.loops = true
        audioSource.loops = false
        // Decode the audio from disk ahead of time to prevent a delay in playback
        audioSource.load()
    }
    /// Plays a sound on the `objectNode` using SceneKit's positional audio
    /// - Tag: AddAudioPlayer
    private func playSound(for objectNode: SCNNode) {
        // Ensure there is only one audio player
        objectNode.removeAllAudioPlayers()
        // Create a player from the source and add it to `objectNode`
        objectNode.addAudioPlayer(SCNAudioPlayer(source: audioSource))
    }
}

