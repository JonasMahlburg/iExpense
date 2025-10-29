//
//  ContentView.swift
//  iExpense
//
//  Created by Jonas Mahlburg on 29.10.25.
//

import SwiftUI

struct ContentView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    ForEach(numbers, id: \.self){
                        Text("Reihe \($0)")
                    }
                    .onDelete(perform: removeRow)
                }
                Button("Hinzufügen"){
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .toolbar{
                EditButton()
            }
        }

    }
    func removeRow(at offsets: IndexSet){
        numbers.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
