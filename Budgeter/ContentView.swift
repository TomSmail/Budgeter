//
//  ContentView.swift
//  Budgeter
//
//  Created by Tom Smail on 22/12/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var valInput: String = ""
    @State private var rowValues: [RowContents] = RowContents.get_values()
    
    var body: some View {
        VStack {
            HStack {
                Text("Spending")
                    .font(.title)
                    .multilineTextAlignment(.leading)
                    .padding([.vertical], 15)
                    .padding()
                Spacer()
            }
            Grid {
                GridRow {
                    Text("Item: ").frame(maxWidth: .infinity, alignment: .leading)
                    Text(" ")}
                .bold()
                Divider()
                    .gridCellUnsizedAxes(.horizontal)
                    .overlay(Color.primary)
                ForEach(rowValues) { row in
                    GridRow {
                        Text(row.itemname).frame(maxWidth: .infinity, alignment: .leading)
                        Text(row.cost.formatted())
                    }
                    Divider()
                        .gridCellUnsizedAxes(.horizontal)
                        .overlay(Color.primary)
                }
            }
            .padding()
            Spacer()
            TextField( "Enter Amount",
                       text: $valInput)
            .keyboardType(.numberPad)
            .padding([.vertical], 100)
            .padding()
        }
        
        //        .onReceive(valInput,
//                   perform: { newInput in
//            let allowedValues = "0123456789"
//            if allowedValues.contains(newInput) {
//                    self.text = newInput }
//        }
//            )
    }
}

struct RowContents: Identifiable, Equatable {
    let cost: Float
    let itemname: String
    let id = UUID()
    
    static func get_values() -> [RowContents]{
        return [RowContents(cost: 10, itemname: "Sausages"),
                RowContents(cost: 15, itemname: "Sangria"),
                RowContents(cost: 1, itemname: "Smarties")]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
