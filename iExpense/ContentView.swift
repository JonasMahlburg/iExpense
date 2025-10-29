//
//  ContentView.swift
//  iExpense
//
//  Created by Jonas Mahlburg on 29.10.25.
//

import SwiftUI

struct SecondView: View{
    @Environment(\.dismiss) var dismiss
    var name: String
    
    var body: some View{
        Text("Hallo \(name)!")
        Text("🎅🏻")
            .font(.title)
        Button("Gehe zurück"){
            dismiss()
        }
    }
}

struct ContentView: View {
    @State private var showingSheet = false
    
    var body: some View {
        Button("Sag dem Weihnachtsmann hallo 🎅🏻"){
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet){
            SecondView(name: "Weihnachtsmann")
        }
    }
}

#Preview {
    ContentView()
}
