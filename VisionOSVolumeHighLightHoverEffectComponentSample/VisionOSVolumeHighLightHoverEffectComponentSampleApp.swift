//
//  VisionOSVolumeHighLightHoverEffectComponentSampleApp.swift
//  VisionOSVolumeHighLightHoverEffectComponentSample
//
//  Created by Sadao Tokuyama on 6/30/24.
//

import SwiftUI

@main
struct VisionOSVolumeHighLightHoverEffectComponentSampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 1.5, height: 1.0, depth: 1.0, in: .meters)
    }
}
