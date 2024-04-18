//  Created by Kevin Watters on 12/27/23.

import SwiftUI
import RealityKit
import GodotVision

struct ContentView: View {
    @StateObject private var godotVision = GodotVisionCoordinator()
    
    var body: some View {
        GeometryReader3D { (geometry: GeometryProxy3D) in
            RealityView { content in
                
                let pathToGodotProject = "Godot_Project" // The path to the folder containing the "project.godot" you wish Godot to load.
                
                // Initialize Godot
                let rkEntityGodotRoot = godotVision.setupRealityKitScene(content,
                                                                         volumeSize: VOLUME_SIZE,
                                                                         projectFileDir: pathToGodotProject)
                
                print("Godot scene root: \(rkEntityGodotRoot)")
                
            } update: { content in
                // update called when SwiftUI @State in this ContentView changes. See docs for RealityView.
                // user can change the volume size from the default by selecting a different zoom level.
                // we watch for changes via the GeometryReader and scale the godot root accordingly
                let frame = content.convert(geometry.frame(in: .local), from: .local, to: .scene)
                let volumeSize = simd_double3(frame.max - frame.min)
                godotVision.changeScaleIfVolumeSizeChanged(volumeSize)
            }
        }
        .modifier(GodotVisionRealityViewModifier(coordinator: godotVision))
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
