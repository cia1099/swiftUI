//
//  BreathingView.swift
//  swift_animation
//
//  Created by OttoLin on 2024/8/23.
//

import SwiftUI

struct BreathingView: View {
    @State private var petal = false
    @State private var breathInOutLabel = 0
    @State private var offsetBreath = false
    @State private var diffuseBreath = false
    @State private var breathTheBouquet = false

    var body: some View {
        ZStack {
            // MARK: - WINTER BACKGROUND

            Image("winterNight").resizable().aspectRatio(contentMode: .fill)
                .frame(width: 400, height: 900)
            ZStack {
                SnowView()

                // MARK: - ANIMATE TEXT LABELS

                Group {
                    let labels = ["Breath In", "Breath Out"]
                    ForEach(0 ..< 2) { i in

                        Text(labels[i]).font(.custom("papyrus", fixedSize: 35))
                            .foregroundColor(i == 0 ? .green : .orange)
                            .offset(y: -160)
                            .opacity(breathInOutLabel == i ? 0 : 1)
                            .scaleEffect(breathInOutLabel == i ? 0 : 1)
                            .animation(.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true), value: breathInOutLabel)
                    }
                }

                Image("smoke").resizable().frame(width: 35, height: 125)
                    .offset(y: offsetBreath ? 90 : 0)
                    .animation(.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true), value: offsetBreath)
                    .blur(radius: diffuseBreath ? 1 : 60)
                    .offset(y: diffuseBreath ? -50 : -100)
                    .animation(.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true), value: diffuseBreath)
                    .shadow(radius: diffuseBreath ? 20 : 0)

                Group {
                    PetalView(petal: $petal, degrees: 0)
                    ForEach(1 ..< 3) { i in
                        ForEach(Array(stride(from: -1, through: 2, by: 2)), id: \.self) { j in
                            let start = CGFloat(25 * i * j)
                            let end = CGFloat(5 * i * j)
                            PetalView(petal: $petal, degrees: petal ? start : end)
                        }
                    }
                }

                Group {
                    ForEach(0 ..< 2) { i in
                        let dx = CGFloat(-25 + 5 * i)
                        let dy = CGFloat(90 + 5 * i)
                        let da = CGFloat(37 - 5 * i)
                        let ds = 1.04 - 0.02 * CGFloat(i)
                        Image("bouquet").resizable().aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 400)
                            .rotationEffect(.degrees(da))
                            .offset(x: dx, y: dy)
                            .scaleEffect(breathTheBouquet ? ds : 1, anchor: .center)
                            .modifier(MirrorEffect(breathTheBouquet: $breathTheBouquet, isMirror: i > 0))
                            .animation(.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true), value: breathTheBouquet)
                    }
                }
            }
            .onAppear {
                breathInOutLabel += 1
                offsetBreath.toggle()
                diffuseBreath.toggle()
                petal.toggle()
                breathTheBouquet.toggle()
            }
        }
    }
}

// MARK: - CUSTOM MODIFIER

struct MirrorEffect: ViewModifier {
    @Binding var breathTheBouquet: Bool
    let isMirror: Bool
    func body(content: Content) -> some View {
        if isMirror {
            content.rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                .hueRotation(.degrees(breathTheBouquet ? -50 : 300))
        } else {
            content
        }
    }
}

struct PetalView: View {
    @Binding var petal: Bool
    var degrees: CGFloat = 0.0
    var body: some View {
        Image("petal").resizable().frame(width: 75, height: 125)
            .rotationEffect(.degrees(petal ? degrees : degrees), anchor: .bottom)
            .animation(.easeInOut(duration: 2).delay(2).repeatForever(autoreverses: true), value: petal)
    }
}

#Preview {
    BreathingView()
}

struct PetalView_Previews: PreviewProvider {
    static var previews: some View {
        PetalView(petal: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
