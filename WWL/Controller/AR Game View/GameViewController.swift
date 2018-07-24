//
//  GameViewController.swift
//  WWL
//
//  Created by Mohsen Qaysi on 7/14/18.
//  Copyright © 2018 Mohsen Qaysi. All rights reserved.
//

import UIKit
import ARKit
import AVFoundation

class GameViewController: UIViewController, ARSCNViewDelegate {
    
    var sound: Sound!
    var sounFileName: String!
    var nextSound: Int = 0

    fileprivate func upDateUIU() {
        DispatchQueue.main.async {
            self.countersArray.forEach { (counter) in
                counter.removeFromParentNode()
            }
            self.nodesThatDidNotChnage.removeAll()
            [self.counterBaseOneNode,self.counterBaseTwoNode,self.counterBaseThreeNode,self.counterBaseFourNode].forEach { $0?.isHidden = true }
        }
    }

    @IBAction func playSoundButton(_ sender: UIButton) {
        if nextSound < levelDataArray.count {
            nextSound = nextSound + 1
            print("new nextSound value: \(nextSound)")
            // update The UI with the new data
            upDateUIU()
            DispatchQueue.main.async {
                self.extractedFunc(index: self.nextSound)
                self.sound.playSoundTrack()
            }
        }
    }
    
    var levelDataArray = [GameModel]() {
        didSet {
            print("levelDataArray was set: ")
        }
    }
    
    var staticBaseNodes = [StaticNodes.counterBaseOneNode.toString(),
                           StaticNodes.counterBaseTwoNode.toString(),
                           StaticNodes.counterBaseThreeNode.toString(),
                           StaticNodes.counterBaseFourNode.toString()
    ]
    
    var nodesThatDidNotChnage: [String] = []
    
    @IBOutlet weak var touchIconButton: UIButton!
    @IBOutlet weak var statusLable: UITextView!
    
    var status: String! {
        didSet {
            statusLable.text = status ?? ""
        }
    }
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
   
//    /// Convenience accessor for the session owned by ARSCNView.
//    var session: ARSession {
//        return sceneView.session
//    }
//    /// Creates a new AR configuration to run on the `session`.
//    func resetTracking() {
//        parnatNode = nil
//        let configuration = ARWorldTrackingConfiguration()
//        configuration.planeDetection = [.horizontal]
//        session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViewSetUp()
        self.registerGestureRecognizers()
//        for (index,value) in levelDataArray[0].CounterProperty.enumerated() {
//            print("CounterProperty Index: \(index) CounterProperty: \(value)")
//        }
    }
    
    fileprivate func initialViewSetUp() {
        statusLable.isHidden = true
        statusLable.textAlignment = .center
        statusLable.layer.cornerRadius = 15
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
        // Enable physicsWorld contact
        self.sceneView.scene.physicsWorld.contactDelegate = self
    }
    
    // MARK: Register Gesture Recognizers
    func registerGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panned))
        self.sceneView.addGestureRecognizer(panGestureRecognizer)
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        self.sceneView.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    // MARK: GestureRecognizer
    // TODO: - LongPress
    @objc func longPress(sender: UILongPressGestureRecognizer){
    }
    
    // Function to Detect Tap
    @objc func tapped(sender: UITapGestureRecognizer){
        // Find out the tap only on the horizontal surface found in Scene View
        guard let sceneView = sender.view as? ARSCNView, sender.view != nil else {return}
        let tapLocation = sender.location(in: sceneView)
        // Match the location of tap with the location of the Horizontal Plane
        // Checks that the location of tap "tapLocation" matches the location of plane "existingPlaneUsingExtent"
        // If the tap is on plane, the hitTest array will have result values or else it'll be empty
        let hitTest = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
        if !hitTest.isEmpty {
            // print("Touched a Horizontal Surface !!")
            self.addItem(hitTestResult: hitTest.first!)
        }
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
                    if !doesNotEqualToStaticNodes(nodeName: node.name!) {
                        currentPossion = SCNVector3(transform.x,(transform.y + yChildNodePosition),transform.z)
                        setCurrentObjectPostion(for: node, at: currentPossion!)
                    } else if node.name != StaticNodes.farmPlanefinal.toString() {
                        print("\(StaticNodes.farmPlanefinal.toString()) was found")
                        recognizer.isEnabled = false
                        // add addShakingAnimationToNode if it did not chnage from the previous game setp
                        node.addShakingAnimationToNode(ShakingDistants: 0.007) {
                            recognizer.isEnabled = true
                        }
                    }
                }
            }
            //            setUpAudio()
        }
        if recognizer.state == .ended {
            if  let node = parnatNode {
                if !doesNotEqualToStaticNodes(nodeName: node.name!) {
                } else {
                    print("\(StaticNodes.farmPlanefinal.toString()) was found")
                    print("node is set to nil")
                }
                //                playSound(for: parnatNode!)
            }
        }
    }
    

    // MARK:- doesNotEqualToStaticNodes
    fileprivate func doesNotEqualToStaticNodes(nodeName: String) -> Bool {
        switch nodeName {
        case StaticNodes.farmPlanefinal.toString():
            return true
        case _ where staticBaseNodes.contains(nodeName):
            return true
        case _ where nodesThatDidNotChnage.contains(nodeName):
            return true
        default:
            return false
        }
    }
    
    //MARK:- Hit tests against the `sceneView` to find an object at the provided point.
    fileprivate func virtualObject(at point: CGPoint) {
        let hitTestOptions: [SCNHitTestOption : Any] = [SCNHitTestOption.searchMode : true]
        let hitTestResults = sceneView.hitTest(point, options: hitTestOptions)
        if !hitTestResults.isEmpty {
            let hitNode = hitTestResults.first!
            guard let nodeName = hitNode.node.name else {return}
            print("nodeName: \(nodeName)")
            parnatNode = hitNode.node
            // TODO: - Check if the found node is movebale or not
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
    fileprivate func addItem(hitTestResult: ARHitTestResult){
        if let selectedItem = self.selectedItem {
            // When Plane is detected, place the object on that
            let scene = SCNScene(named: "Models.scnassets/\(selectedItem).scn")
            let node = (scene?.rootNode.childNode(withName: selectedItem, recursively:false))!
            // Get transform matrix to get the values to place objects right on top of horzontal surface detected
            let transform = hitTestResult.worldTransform
            // Position of detected surface is in 3rd column of transform matrix
            let thirdColumn = transform.columns.3
            // Position the Object node right where the detected surface is
            
            node.position = SCNVector3(thirdColumn.x,thirdColumn.y + yChildNodePosition,thirdColumn.z)
            //            node.position = SCNVector3(thirdColumn.x,thirdColumn.y,thirdColumn.z)
            print("added node location: \(node.position)")
            // MARK: add SCNPhysicsBody and BitMask to add Nodes
            ApplyPhysices(node: node, name: node.name!)
            self.sceneView.scene.rootNode.addChildNode(node)
            if !doesNotEqualToStaticNodes(nodeName: node.name!) {
                //                SCNNode().addFloatingAnimationToNode(node: node)
            }
        }
    }
    
    
    // MARK: Renderer SCNNodes
    let farmPlanefinal = "farmPlanefinal"
    let yRootNodePosition: Float = 0.003
    let yChildNodePosition: Float = 0.04
    
    // plane
    var planScene: SCNScene!
    // Base Nodes
    var counterBaseOneNode: SCNNode!
    var counterBaseTwoNode: SCNNode!
    var counterBaseThreeNode: SCNNode!
    var counterBaseFourNode: SCNNode!
    
    // polyPlanefinalScene
    var polyPlanefinalScene: SCNScene!
    var polyPlanefinalNode: SCNNode!
    var planeAnchor: ARPlaneAnchor!
    var anchorNode: SCNNode!
    var overlayPlane: SCNNode!
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        print("++++++++++++++++++++++++++++ ( ARAnchor) ++++++++++++++++++++++++++++++++++")
        print("Deticted anchor: \(anchor)")
        print("_______________________________________________________________________")
        if didAddedParentNode {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.planeAnchor = anchor as? ARPlaneAnchor // else {return}
                self.anchorNode = node
                self.overlayPlane = OverlayPlane(anchor: self.planeAnchor)
                node.addChildNode(self.overlayPlane)
                self.uuidString = self.planeAnchor.identifier.uuidString
                print("ogiginal planeAnchor location: \(self.planeAnchor.center)")
                print("uuidString: \(self.uuidString)")
                self.touchIconButton.isHidden = false
                self.touchIconButton.blinkingButtonEffect(duration: 0.5)
            }
        }
        print("-----------------------------------------------------------------------")
        guard let newPlaneAnchor = anchor as? ARPlaneAnchor else {return}
        print("New planeAnchor location: \(newPlaneAnchor)")
        print("New uuidString: \(newPlaneAnchor.identifier.uuidString)")
        print("-----------------------------------------------------------------------")
    }
    
    @IBAction func touchIconButtonAction(_ sender: UIButton) {
        print("touchIconButtonAction was pressed...")
        // Add the Parent node onto the ARPlane
        addFarm()
    }
    
    fileprivate func setUpbaseCounterPhysics(parantScene: SCNScene, childName: String) -> SCNNode {
        let childNode: SCNNode!
        childNode = parantScene.rootNode.childNode(withName: childName, recursively: true)
        childNode.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
        childNode.physicsBody?.categoryBitMask = BoxBodyType.barrier.rawValue
        return childNode
    }
    // MARK: - AddFarm
    fileprivate func addFarm(){
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)// + -0.1)
        print("ogiginal object location : x: \(x) y: \(y) z: \(z)")
        print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
        
        // testing
        polyPlanefinalScene = SCNScene(named: "Models.scnassets/\(StaticNodes.farmPlanefinal.toString()).scn")
        polyPlanefinalNode = polyPlanefinalScene.rootNode.childNode(withName: "\(StaticNodes.farmPlanefinal.toString())", recursively: false)
        
        // counterBaseOne
        counterBaseOneNode = setUpbaseCounterPhysics(parantScene: polyPlanefinalScene, childName: StaticNodes.counterBaseOneNode.toString())
        // counterBaseTwo
        counterBaseTwoNode = setUpbaseCounterPhysics(parantScene: polyPlanefinalScene, childName: StaticNodes.counterBaseTwoNode.toString())
        // counterBaseThreeNode
        counterBaseThreeNode = setUpbaseCounterPhysics(parantScene: polyPlanefinalScene, childName: StaticNodes.counterBaseThreeNode.toString())
        // counterBaseFourNode
        counterBaseFourNode = setUpbaseCounterPhysics(parantScene: polyPlanefinalScene, childName: StaticNodes.counterBaseFourNode.toString())
      
        [counterBaseOneNode,counterBaseTwoNode,counterBaseThreeNode,counterBaseFourNode].forEach { $0?.isHidden = true }
       
        // Add the base node
        polyPlanefinalNode.name = StaticNodes.farmPlanefinal.toString()
        polyPlanefinalNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        polyPlanefinalNode.position = SCNVector3(x,y,z)
        
        anchorNode.addChildNode(polyPlanefinalNode)
        addStartingCounters()
        self.polyPlanefinalNode.opacity = 0
        
        // Animate the Parent Node into the view
        DispatchQueue.main.async {
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 1.0
            self.polyPlanefinalNode.opacity = 1
            self.overlayPlane.opacity = 0
            SCNTransaction.commit()
            self.overlayPlane.removeFromParentNode()
            // Hide debugOptions
            self.sceneView.debugOptions = []
        }
        print("node was added..")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.touchIconButton.isHidden = true
            // Unhide the itemsCollectionView
            self.itemsCollectionView.isHidden = false
            self.itemsCollectionView.loadingCellAnimation()
        }
    }
    
    fileprivate func ApplyPhysices(node: SCNNode, name: String){
        node.name = name// BoxBodyTypeName.counter.toString() //"Counter"
        node.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
        node.physicsBody?.categoryBitMask = BoxBodyType.bullet.toInt()
        node.physicsBody?.contactTestBitMask = BoxBodyType.barrier.toInt()
        node.physicsBody?.isAffectedByGravity = false // stop it from falling to the ground
    }
    
    var blueCounterNodeOne: SCNNode!
    var blueCounterNodeTwo: SCNNode!
    var blueCounterNodeThree: SCNNode!
    var greenCounterNodeOne: SCNNode!
    
    // MARK: - Create Counter Node
    func createCounterNode(counterColorID: Int) -> SCNNode {
        var counterName = ""
        if counterColorID == 1 {
            counterName = Identifiers.blueCounter
        } else {
            counterName = Identifiers.greenCounter
        }
        let counterSceneNode = SCNScene(named: "Models.scnassets/\(counterName).scn")
        let counterNode = (counterSceneNode?.rootNode.childNode(withName: counterName, recursively: false))!
        return counterNode
    }
    
    //MARK:-  Setup the inital game Counters in the view
    fileprivate func setUpCounterspostionsInView(_ countersArray: [SCNNode]) {
       
        // TODO: NodesThatDidNotChnage
        //        nodesThatDidNotChnage.append(blueCounterNodeOne.name!)
        for (index,counter) in countersArray.enumerated() {
            switch index {
            case 0:
                counter.position = counterBaseOneNode.position
                counter.eulerAngles.x = counterBaseOneNode.eulerAngles.x
                counterBaseOneNode.isHidden = false
            case 1:
                counter.position = counterBaseTwoNode.position
                counter.eulerAngles.x = counterBaseTwoNode.eulerAngles.x
                counterBaseTwoNode.isHidden = false
            case 2:
                counter.position = counterBaseThreeNode.position
                counter.eulerAngles.x = counterBaseThreeNode.eulerAngles.x
                counterBaseThreeNode.isHidden = false
            case 3:
                counter.position = counterBaseFourNode.position
                counter.eulerAngles.x = counterBaseFourNode.eulerAngles.x
                counterBaseFourNode.isHidden = false
            default:
                return
            }
        }
    }
    
    //MARK: - SetUpStaticCounters
    func SetUpStaticCounters(CounterPropertyArray: [CounterProperty]){
        for (indexOfCounterProperty,counterProperty) in CounterPropertyArray.enumerated() {
            print("CounterProperty Index: \(indexOfCounterProperty) CounterProperty: \(counterProperty)")
            switch indexOfCounterProperty {
            case 0...3:
                let counter = self.countersArray[indexOfCounterProperty]
                if !counterProperty.counterChanged {
                    print("counterProperty counter name: \(counter.name!)")
                    self.nodesThatDidNotChnage.append(counter.name!)
                }
            default:
                return
            }
        }
    }
    
    var countersArray = [SCNNode]()
    
    fileprivate func createCountersFromCounterPropertyModel(_ index: Int, completed: (()-> ())) {
        countersArray = []
//        counterBaseOneNode = nil
//        counterBaseTwoNode = nil
//        counterBaseThreeNode = nil
//        counterBaseFourNode = nil

        // Take the CounterProperty at index:
        levelDataArray[index].CounterProperty.forEach { (counter) in
            if counter.color == CounterColor.blueColor.toInt() {
                if blueCounterNodeOne == nil {
                    blueCounterNodeOne = createCounterNode(counterColorID: counter.color)
                    blueCounterNodeOne.name = Identifiers.blueCounterNodeOne
                    // Add to array
                    countersArray.append(blueCounterNodeOne)
                } else if blueCounterNodeTwo == nil {
                    blueCounterNodeTwo = createCounterNode(counterColorID: counter.color)
                    blueCounterNodeTwo.name = Identifiers.blueCounterNodeTwo
                    countersArray.append(blueCounterNodeTwo)
                } else {
                    blueCounterNodeThree = createCounterNode(counterColorID: counter.color)
                    blueCounterNodeThree.name = Identifiers.blueCounterNodeThree
                    // Add to array
                    countersArray.append(blueCounterNodeThree)
                }
            } else {
                greenCounterNodeOne = createCounterNode(counterColorID: counter.color)
                greenCounterNodeOne.name = Identifiers.greenCounterNodeOne
                // Add to array
                countersArray.append(greenCounterNodeOne)
            }
        }
        // Loop over all of them and apply physices
        countersArray.forEach {
            ApplyPhysices(node: $0, name: $0.name!)
        }
        completed()
    }
    
    fileprivate func extractedFunc(index: Int) {
        createCountersFromCounterPropertyModel(index) {
            //MARK: Gamge counters Positioning
            print("countersArray: \(countersArray.debugDescription)")
            // setup the Counters spostions in the view
            setUpCounterspostionsInView(countersArray)
        }
        
        // TODO: check this line of code which set ONLY the first CounterProperty
        let counterPropertyArray = levelDataArray[index].CounterProperty
        
        // Fix the location of the ones that did not change
        SetUpStaticCounters(CounterPropertyArray: counterPropertyArray)
        
        // SetUp sound track
        setSoundtrack(index: index)
        // Loop over all counters and add them to the view
        countersArray.forEach {
            polyPlanefinalNode.addChildNode($0)
        }
    }
    
    func addStartingCounters(index: Int = 0){
        extractedFunc(index: index)
    }
    
    fileprivate func setSoundtrack(index: Int) {
        print("sounFileName: \(levelDataArray[index].key!)")
        let key = levelDataArray[index].key!
        sounFileName = "sounds/module02/\(key)"
        sound = Sound(fileName: sounFileName)
    }
    
    // check the anchor before add the node ... if a node already being added do not update it's postion.
    var didAddedParentNode: Bool = true
    var uuidString: String! = nil
    
    func renderer(_ renderer: SCNSceneRenderer, willUpdate node: SCNNode, for anchor: ARAnchor) {
        if uuidString != nil {
            if anchor.identifier.uuidString == uuidString {
                didAddedParentNode = false
            }
        }
    }
    var lastContactNode: SCNNode!
}

extension GameViewController: SCNPhysicsContactDelegate {
    // MARK: - PhysicsWorld
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
        
        if contact.nodeA.name == BoxBodyTypeName.counter.toString() {
            contactNode = contact.nodeA
            print("node A \(String(describing: contact.nodeA.name)) was assigned to contactNode")
        } else {
            contactNode = contact.nodeB
            print("node B \(String(describing: contact.nodeA.name)) was assigned to contactNode")
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
        } else if UIExtendedSRGBColorSpaceToUIColor2.blue.keys.first == detectedColor {
            print(UIExtendedSRGBColorSpaceToUIColor2.blue.values.first as Any)
        } else {
            print("new color: \(detectedColor) ")
        }
        print("node name: \(String(describing: lastContactNode.name?.description))")
        print("**********************************************")
    }
}
extension GameViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    // How many cells the colection displays
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    // Configures every single source cell in collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.itemID, for: indexPath) as! itemCell
        cell.layer.cornerRadius = 5
        // Shows the images from Array
        cell.imageName = itemsArray[indexPath.row] //UIImage(named: self.itemsArray[indexPath.row])
        return cell
    }
    
    // Function to turn the label to green when the item is selected
    // This function gets triggered whenever we select a cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        self.selectedItem = itemsArray[indexPath.row]
        cell?.backgroundColor = (indexPath.row == 0) ? blueColor : greenColor
        cell?.bounceCellEffect()
    }
    
    // Function to change the cell color back to normal on deselction
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = (indexPath.row == 0) ?  .clear : .clear
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
    }
    
    // MARK: - Setup audio playback
    // MARK: - Sound
    /// Sets up the audio for playback.
    // SetUpAudio
    private func setUpAudio() {
        // Instantiate the audio source
        if let file = SCNAudioSource(fileNamed: "dropSound.mp3"){
            audioSource = file
        }
        // As an environmental sound layer, audio should play indefinitely
        audioSource.loops = false
        // Decode the audio from disk ahead of time to prevent a delay in playback
        audioSource.load()
    }
    // Plays a sound on the `objectNode` using SceneKit's positional audio
    // MARK:- AddAudioPlayer
    private func playSound(for objectNode: SCNNode) {
        // Ensure there is only one audio player
        objectNode.removeAllAudioPlayers()
        // Create a player from the source and add it to `objectNode`
        objectNode.addAudioPlayer(SCNAudioPlayer(source: audioSource))
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        switch camera.trackingState {
        case .notAvailable:
            statusLable.statusShowLabelAnimation(isHidden: false)
            status = CamerStatus.NotAvailable.toString()
        case .limited:
            statusLable.statusShowLabelAnimation(isHidden: false)
            status = CamerStatus.limited.toString()
        default:
            statusLable.statusShowLabelAnimation(isHidden: true)
            // camera.trackingState is normal ... hide the statusLable
        }
    }
}
