//
//  ContentView.swift
//  iExpense
//
//  Created by Jonas Mahlburg on 29.10.25.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem](){
        didSet{
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = decodedItems
                return
            }
        }
        items = []
    }
}

struct ContentView: View {
    
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack{
            List{
                Section("Personal") {
                    ForEach(expenses.items.filter { $0.type == "Personal" }) { item in
                        HStack {
                            VStack(alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            Text(item.amount,  format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundStyle(item.amount < 10 ? .blue : (item.amount > 100 ? .red : .primary))
                        }
                    }
                    .onDelete(perform: removePersonalItems)
                }
                
                Section("Business") {
                    ForEach(expenses.items.filter { $0.type == "Business" }) { item in
                        HStack {
                            VStack(alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            Text(item.amount,  format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundStyle(item.amount < 10 ? .blue : (item.amount > 100 ? .red : .primary))
                        }
                    }
                    .onDelete(perform: removeBusinessItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus"){
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense){
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        let personal = expenses.items.enumerated().filter { $0.element.type == "Personal" }
        let indicesToRemove = offsets.compactMap { personal[$0].offset }
        for index in indicesToRemove.sorted(by: >) {
            expenses.items.remove(at: index)
        }
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        let business = expenses.items.enumerated().filter { $0.element.type == "Business" }
        let indicesToRemove = offsets.compactMap { business[$0].offset }
        for index in indicesToRemove.sorted(by: >) {
            expenses.items.remove(at: index)
        }
    }
}

#Preview {
    ContentView()
}
