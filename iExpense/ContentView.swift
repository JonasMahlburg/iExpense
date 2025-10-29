//
//  ContentView.swift
//  iExpense
//
//  Created by Jonas Mahlburg on 29.10.25.
//

import SwiftUI

struct ContentView: View {
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    
    var body: some View {
        Button("Tap Count: \(tapCount)"){
            tapCount += 1
            
            UserDefaults.standard.set(tapCount, forKey: "Tap")
        }
    }
}

//struct ContentView: View {
//    @AppStorage("tapCount") private var tapCount = 0
//    
//    var body: some View {
//        Button("Tap Count: \(tapCount)"){
//            tapCount += 1
//        }
//    }
//}

#Preview {
    ContentView()
}



