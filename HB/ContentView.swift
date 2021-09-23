//
//  ContentView.swift
//  learN
//
//  Created by Alex Honcharuk on 13.01.2021.
//

import SwiftUI

struct expenceItem : Identifiable, Encodable {
    let id = UUID()
    var name : String
    var type : String
    var amount : Int
}

class Expenses : ObservableObject{
    @Published var items = [expenceItem](){
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.setValue(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if UserDefaults.standard.data(forKey: "Items") != nil{
            _ = JSONDecoder()
        }
    }
}

struct ContentView: View {
    
    @State private var showingAddExpense = false
    @ObservedObject var expenses = Expenses()
    
    var body: some View {
        NavigationView{
            List{
                ForEach(expenses.items) { item in
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text("$\(item.amount)")
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("Расходы")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.showingAddExpense = true
                                    }, label: {
                                        Image(systemName: "plus")
                                    }).sheet(isPresented: $showingAddExpense, content: {
                                        AddView(expenses: self.expenses)
                                    })
            )
        }
    }
    func removeItems(as offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets )
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

