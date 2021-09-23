//
//  AddView.swift
//  learN
//
//  Created by Alex Honcharuk on 25.01.2021.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses : Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    let types = ["Bussines", "Personal"]
    var body: some View {
        NavigationView{
            Form{
                TextField("Название", text: $name)
                Picker(selection: $type, label: Text("Тип"), content: {
                    ForEach(self.types, id: \.self){
                        Text($0)
                    }
                    
                })
                TextField("Cтоимость", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("Добавить")
            .navigationBarItems(trailing: Button(
                                    action: {
                                        if let actualAmount = Int(self.amount){
                                            let item = expenceItem(name: self.name, type: self.type, amount: actualAmount)
                                            self.expenses.items.append(item)
                                            self.presentationMode.wrappedValue.dismiss()
                                        }
                                    }, label: {
                                        Text("Cохранить")
                                    }))
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
