//
//  ContentView.swift
//  VisionOSVolumeHighLightHoverEffectComponentSample
//
//  Created by Sadao Tokuyama on 6/30/24.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    
    @State private var toyEntity: Entity = Entity()
    @State private var strength: Float = 0
    @State private var highlightColor = Color.yellow
    
    let colors: [Color] = [.red, .green, .blue, .yellow, .orange, .purple]
    var body: some View {
        HStack {
            RealityView { content in
                
                if let entity = try? await Entity(named: "toy_drummer_idle") {
                    toyEntity = entity
                    // Animation
                    let availableAnimations = toyEntity.availableAnimations
                    let animationCount = availableAnimations.count
                    if animationCount > 0 {
                        toyEntity.playAnimation(availableAnimations[animationCount - 1].repeat())
                    }
                    
                    // Scale, Position
                    toyEntity.scale = [0.05, 0.05, 0.05]
                    toyEntity.position.y-=0.5
                    
                    // HoverEffectComponent, InputTargetComponent, CollisionComponent
                    toyEntity.components.set(HoverEffectComponent(.highlight(HoverEffectComponent.HighlightHoverEffectStyle(color: UIColor(highlightColor), strength: strength))))
                    toyEntity.components.set(InputTargetComponent())
                    toyEntity.components.set(CollisionComponent(shapes: [.generateBox(size: [10.0, 25.0, 15.0])]))
                    
                    content.add(toyEntity)
                }
            }
            VStack(spacing: 32) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 320)
                    .foregroundStyle(highlightColor)
                
                Picker("Select a Highlight color", selection: $highlightColor) {
                    ForEach(colors ,id: \.self) { color in
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(color)
                                .tag(color)
                            Spacer()
                        }
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding()
                .onChange(of: highlightColor) {
                    toyEntity.components.set(HoverEffectComponent(.highlight(HoverEffectComponent.HighlightHoverEffectStyle(color: UIColor(highlightColor), strength: strength))))
                }
                .hoverEffect()
                
                HStack(spacing: 32) {
                    Text("strength").font(.system(size: 72))
                    Slider(
                        value: Binding(
                            get: {
                                self.strength
                            },
                            set: { newValue in
                                if self.strength != newValue {
                                    toyEntity.components.set(HoverEffectComponent(.highlight(HoverEffectComponent.HighlightHoverEffectStyle(color: UIColor(highlightColor), strength: strength))))
                                    self.strength = newValue
                                }
                            }
                        ), in: -15.0...15.0)
                    .hoverEffect()
                }
            }
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
