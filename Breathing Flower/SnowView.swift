//
//  SnowView.swift
//  swift_animation
//
//  Created by OttoLin on 2024/8/24.
//

import SwiftUI

struct SnowView: UIViewRepresentable {
    func makeUIView(context _: Context) -> some UIView {
        let screen = UIScreen.main.bounds
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screen.width, height: screen.height))
        view.layer.masksToBounds = true

        let emitter = CAEmitterLayer()
        emitter.frame = CGRect(x: screen.width / 2, y: -16, width: screen.width, height: screen.height)

        let cell = CAEmitterCell()
        cell.birthRate = 16
        cell.lifetime = 25
        cell.velocity = 60
        cell.scale = 0.025
        cell.emissionRange = CGFloat.pi
        cell.contents = UIImage(named: "snow")?.cgImage

        emitter.emitterCells = [cell]
        view.layer.addSublayer(emitter)

        return view
    }

    func updateUIView(_: UIViewType, context _: Context) {}
}

#Preview {
    SnowView().background(.gray)
}
