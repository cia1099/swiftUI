//
//  PlayerView.swift
//  swift_animation
//
//  Created by OttoLin on 2024/8/21.
//

import AVFoundation
import Foundation
import SwiftUI

struct PlayerView: View {
    @State private var audioPlayer: AVAudioPlayer?
    @State private var rotateRecord = false
    @State private var rotateArm = false
    @State private var shouldAnimate = false
    @State private var degree: CGFloat = 0.0
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [.white, .black]), center: .center, startRadius: 20, endRadius: 600)
                .scaleEffect(1.2)
            RecordPlayerBox().offset(y: -100)
            VStack(alignment: .center) {
                RecordView(degree: $degree, shouldAnimate: $shouldAnimate)
                ArmView(rotateArm: $rotateArm)

                Button(action: {
                    shouldAnimate.toggle()
                    if shouldAnimate {
                        rotateArm = true
                        degree = 3600 - 90
                        playSound(sound: "music", type: "m4a")
                    } else {
                        rotateArm = false
                        degree = 0
                        audioPlayer?.stop()
                    }
                }, label: {
                    HStack(spacing: 8) {
                        if !shouldAnimate {
                            Text("Play")
                            Image(systemName: "play.circle.fill").imageScale(.large)
                        } else {
                            Text("Stop")
                            Image(systemName: "stop.fill").imageScale(.large)
                        }
                    }
                }).padding(.horizontal, 16).padding(.vertical, 10)
                    .background(Capsule().strokeBorder(.black, lineWidth: 1.25))
            }
        }
    }

    private func playSound(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            } catch {
                print("Could not find and play the sound file")
            }
        }
    }
}

struct RecordPlayerBox: View {
    var body: some View {
        ZStack {
            Rectangle().frame(width: 345, height: 345).cornerRadius(10)
            Image(decorative: "woodGrain").resizable().frame(width: 325, height: 325)
                .shadow(color: .white, radius: 3, x: 0, y: 0)
        }
    }
}

struct RecordView: View {
    @Binding var degree: CGFloat
    @Binding var shouldAnimate: Bool
    var body: some View {
        Image("record").resizable().frame(width: 275, height: 275)
            .shadow(color: .gray, radius: 1, x: 0, y: 0)
            .rotationEffect(.degrees(degree))
            // key point is the duration for this rotation changing degree
            .animation(.linear(duration: shouldAnimate ? 1 : 0).delay(1.8), value: degree)
    }
}

struct ArmView: View {
    @Binding var rotateArm: Bool
    var body: some View {
        Image("playerArm").resizable().aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150)
            .shadow(color: .gray, radius: 2, x: 0, y: 0)
            .rotationEffect(.degrees(-35), anchor: .topTrailing)
            .rotationEffect(.degrees(rotateArm ? 10 : 0), anchor: .topTrailing)
            .offset(x: 70, y: -250)
            .animation(Animation.linear(duration: 2), value: rotateArm)
    }
}

#Preview("PlayerView") {
    PlayerView()
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(degree: .constant(2.0), shouldAnimate: .constant(true))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

#Preview("RecordPlayerBox") {
    RecordPlayerBox()
}
