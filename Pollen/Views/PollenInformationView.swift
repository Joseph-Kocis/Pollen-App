//
//  PollenInformationView.swift
//  Pollen
//
//  Created by Jody Kocis on 4/28/20.
//  Copyright © 2020 Joseph Kocis. All rights reserved.
//

import SwiftUI

struct PollenInformationView: View {
    var data: PollenData
    
    @State var capsuleWidth = CGFloat(0)
    @Binding var hasAnimated: Bool
    @Binding var informationViewsAnimated: [PollenType: Bool]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(data.pollenType) Pollen")
                        .font(.headline)
                
                Text(data.intensity.rawValue)
                    .bold()
                    .padding(.horizontal, 13)
                    .padding(.vertical, 3)
                    .foregroundColor(data.intensityColor)
                    .overlay(
                        Capsule(style: .continuous)
                            .stroke(
                                data.intensityColor,
                                lineWidth: 1
                            )
                    )
            }
            
            HStack {
                Text("Amount:")
                    .lineLimit(1)
                
                GeometryReader { geometry in
                    self.graph(geometry)
                    Spacer()
                }
                .frame(maxHeight: 25)
            }
        }
        .padding(.horizontal, 15)
        .frame(
            maxWidth: .infinity,
            alignment: Alignment(
                horizontal: .leading,
                vertical: .center
            )
        )
    }
    
    func graph(_ geometry: GeometryProxy) -> some View {
        let capsuleMaxWidth = (geometry.size.width - 30) *
            (CGFloat(data.amount) / CGFloat(
            data.maxAmount))
        
        let capsule = Capsule(style: .continuous)
            .fill(Color.blue)
            .frame(width: capsuleWidth)
            .onAppear() {
                self.capsuleAnimation(withMaxWidth: capsuleMaxWidth)
            }
            .onReceive(NotificationCenter.default.publisher(for: UIScene.didActivateNotification)) { _ in
                self.hasAnimated = false
                self.capsuleAnimation(withMaxWidth: capsuleMaxWidth)
            }
            .onReceive(NotificationCenter.default.publisher(for: UIScene.willDeactivateNotification)) { _ in
                self.capsuleWidth = 0
            }
        
        return HStack {
            capsule
            Text({
                let text = Int(
                    CGFloat(data.amount) /
                    CGFloat(data.maxAmount) *
                    10
                )
                return "\(text)"
            }())
        }
    }
    
    func capsuleAnimation(withMaxWidth capsuleMaxWidth: CGFloat) -> () {
        if self.hasAnimated {
            return withAnimation(.none) {
                self.capsuleWidth = capsuleMaxWidth
            }
        } else {
            if let pollenType = PollenType(rawValue: self.data.pollenType) {
                self.informationViewsAnimated[pollenType] = true
            }
            
            if !self.informationViewsAnimated.contains(where: { _, value in !value }) {
                self.hasAnimated = true
            }
            return withAnimation(.ripple()) {
                self.capsuleWidth = capsuleMaxWidth
            }
        }
    }
}

extension Animation {
    static func ripple() -> Animation {
        return Animation.spring(dampingFraction: 0.5)
            .speed(0.5)
            .delay(0.6)
    }
}
