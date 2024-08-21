//
//  CirclesView.swift
//  swift_animation
//
//  Created by OttoLin on 2024/8/20.
//

import SwiftUI

struct CirclesView: View {
    @ObserveInjection var inject

    @State private var scaleInOut = false
    @State private var rotateInOut = false
    @State private var moveInOut = false

    var body: some View {
        ZStack {
            Rectangle().edgesIgnoringSafeArea(.all)
            ZStack {
                ForEach(0 ..< 3) { c in
                    let degree = CGFloat(c) * 60
                    ZStack {
                        ForEach(0 ..< 2) { i in
                            let shift = CGFloat(i) * 120 - 60.0
                            Circle().fill(LinearGradient(gradient: Gradient(colors: [.green, .white]), startPoint: .top, endPoint: .bottom))
                                .frame(width: 120, height: 120)
                                .offset(y: moveInOut ? shift : 0)
                        }
                    }.opacity(0.5).rotationEffect(.degrees(degree))
                }
            }.rotationEffect(.degrees(rotateInOut ? 90 : 0))
                .scaleEffect(scaleInOut ? 1 : 0.25)
                .animation(Animation.easeInOut.repeatForever(autoreverses: true).speed(1 / 8))
                .onAppear {
                    moveInOut.toggle()
                    scaleInOut.toggle()
                    rotateInOut.toggle()
                }
        }
        .enableInjection()
    }
}

#Preview {
    CirclesView()
}
