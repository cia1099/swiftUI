//
//  ContentView.swift
//  swift_animation
//
//  Created by OttoLin on 2024/8/20.
//
import SwiftUI

struct ContentView: View {
    @ObserveInjection var inject
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world555123")
        }
        .padding()
        .enableInjection()
    }
}

// #Preview {
//    ContentView()
// }
