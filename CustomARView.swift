import ARKit
import SwiftUI
import RealityKit

/*
// Custom View for AR Implementation
class CustomARView: ARView {
    // User's carbon footprint to determine number of sphere's
    let carbonFootprint: Double
    
    // Init footprint and frameRect
    init(frame frameRect: CGRect, carbonFootprint: Double) {
        self.carbonFootprint = carbonFootprint
        super.init(frame: frameRect)
    }
    
    // Required init CGRect
    required init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented. Use init(frame:carbonFootprint:) instead.")
    }
    
    // Required init NSCoder
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Init screen frame and Carbon Footprint
    convenience init(carbonFootprint: Double) {
        self.init(frame: UIScreen.main.bounds, carbonFootprint: carbonFootprint)
        placeModel(buildingPosition: SIMD3<Float>(x: -0.2, y: -0.1, z: 0.20))
    }
    
    // Empire State Model
    // Created by printable_models (https://free3d.com/3d-model/empire-state-building-v2--490585.html) Personal Use License
    
    // Burj Khalifa Model
    // "Burj Khalifa" (https://skfb.ly/osxoP) by NanoRay is licensed under Creative Commons Attribution (http://creativecommons.org/licenses/by/4.0/).
    
    // One World Trade Center
    // "One World Trade Center" (https://skfb.ly/oouwq) by NanoRay is licensed under Creative Commons Attribution (http://creativecommons.org/licenses/by/4.0/).
    
    // Load Models and Place
    func placeModel(buildingPosition: SIMD3<Float>) {
        // Guard failure to load models
        guard let empireStateURL = Bundle.main.url(forResource: "empire_state", withExtension: "usdz"),
              let burjKhalifaURL = Bundle.main.url(forResource: "burj_khalifa", withExtension: "usdz"),
              let oneWorldTradeURL = Bundle.main.url(forResource: "one_world_trade", withExtension: "usdz") else {
            fatalError("Failed to load model files.")
        }
        
        // Load Empire State Building model
        let empireStateModelEntity = try! Entity.loadModel(contentsOf: empireStateURL)
        empireStateModelEntity.setScale(SIMD3<Float>(repeating: 0.004), relativeTo: empireStateModelEntity)
        empireStateModelEntity.transform.rotation = simd_quatf(angle: -.pi / 2, axis: [1, 0, 0])
        
        // Add horizontal plane anchor for Empire State Building
        let empireStateAnchor = AnchorEntity(plane: .horizontal)
        empireStateAnchor.addChild(empireStateModelEntity)
        scene.addAnchor(empireStateAnchor)
        
        // Load Burj Khalifa model
        let burjKhalifaModelEntity = try! Entity.loadModel(contentsOf: burjKhalifaURL)
        burjKhalifaModelEntity.setScale(SIMD3<Float>(repeating: 1.0), relativeTo: burjKhalifaModelEntity)
        burjKhalifaModelEntity.transform.rotation = simd_quatf(angle: -.pi / 2, axis: [1, 0, 0])
        
        // Position Burj Khalifa model next to Empire State Building
        let burjKhalifaPosition = SIMD3<Float>(x: buildingPosition.x - 0.90, y: buildingPosition.y, z: buildingPosition.z - 0.40)
        
        // Add horizontal plane anchor for Burj Khalifa
        let burjKhalifaAnchor = AnchorEntity(plane: .horizontal)
        burjKhalifaAnchor.position = burjKhalifaPosition
        burjKhalifaAnchor.addChild(burjKhalifaModelEntity)
        scene.addAnchor(burjKhalifaAnchor)
        
        // Load One World Trade Center model
        let oneWorldTradeModelEntity = try! Entity.loadModel(contentsOf: oneWorldTradeURL)
        oneWorldTradeModelEntity.setScale(SIMD3<Float>(repeating: 1.0), relativeTo: oneWorldTradeModelEntity)
        oneWorldTradeModelEntity.transform.rotation = simd_quatf(angle: -.pi / 2, axis: [1, 0, 0])
        
        // Position One World Trade Center model next to Empire State Building and Burj Khalifa
        let oneWorldTradePosition = SIMD3<Float>(x: buildingPosition.x + 0.90, y: buildingPosition.y, z: buildingPosition.z - 0.40)
        
        // Add horizontal plane anchor for One World Trade Center
        let oneWorldTradeAnchor = AnchorEntity(plane: .horizontal)
        oneWorldTradeAnchor.position = oneWorldTradePosition
        oneWorldTradeAnchor.addChild(oneWorldTradeModelEntity)
        scene.addAnchor(oneWorldTradeAnchor)
        
        // Determine number of spheres based on user's footprint (one sphere = 1 ton of output)
        let numberOfSpheres = Int(carbonFootprint / 1000)
        
        // Call func to add spheres to plane
        addCarbonSpheresAroundBuilding(numberOfSpheres: numberOfSpheres, buildingPosition: buildingPosition)
    }

    // Add carbon spheres to scene
    func addCarbonSpheresAroundBuilding(numberOfSpheres: Int, buildingPosition: SIMD3<Float>) {
        
        // Control Spacing
        let verticalSpacing: Float = 0.07
        let horizontalSpacing: Float = 0.01
        
        // Sphere radius = .034 (scaled to represent volume relative to scaled building)
        let sphereRadius: Float = 0.034
        
        // Add horizontal anchor
        let anchor = AnchorEntity(plane: .horizontal)
        scene.addAnchor(anchor)
        
        // Populate spheres
        for i in 0..<numberOfSpheres {
            let sphereY = verticalSpacing * Float(i)
            let sphereX = buildingPosition.x + horizontalSpacing
            let sphereZ = buildingPosition.z
            
            // Create material and color for spheres
            let sphereEntity = ModelEntity(mesh: .generateSphere(radius: sphereRadius), materials: [SimpleMaterial(color: .green, isMetallic: false)])
            sphereEntity.position = SIMD3<Float>(x: sphereX, y: sphereY, z: sphereZ)
            
            // Add sphere as child of anchor
            anchor.addChild(sphereEntity)
        }
    }
}
*/
