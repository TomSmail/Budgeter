//
//  ContentView.swift
//  Budgeter
//
//  Created by Tom Smail on 22/12/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var valInput: String = ""
    @State private var itemInput: String = ""
    @State var itemTable: Table = Table.init()
    
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
                    Text(" ")
                        .padding([.horizontal], 35)
                }
                .bold()
                Divider()
                    .gridCellUnsizedAxes(.horizontal)
                    .overlay(Color.primary)
                ForEach(itemTable.rows) { row in
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
            HStack {
            TextField("Item",
                       text: $itemInput)
            .keyboardType(.numberPad)
            .padding([.leading], 30)
            Spacer()
            TextField("Amount",
                       text: $valInput)
            .keyboardType(.numberPad)
            .padding()
            }
            Spacer()
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
}

struct Table: Identifiable, Equatable {
    var rows: [RowContents] = [RowContents(cost: 10, itemname: "Sausages"),
                              RowContents(cost: 15, itemname: "Sangria"),
                              RowContents(cost: 1, itemname: "Smarties")]
    let id = UUID()
    
    func saveRows(rows: [RowContents]) {
        func transformRowToString(row: RowContents) -> [String: NSString] {
            return [row.itemname : NSString(format: "%.2f", row.cost)]
        }
        let appData = UserDefaults.standard
        let stringRows = rows.flatMap(transformRowToString)
        print(stringRows)
        appData.set(stringRows, forKey: "table")
    }
    
    // decode rows
    mutating func retrieveRows() {
        
        func transformRowsToObjects(rows: [String: String]) -> [RowContents] {
            var listOfRows: [RowContents] = []
            for (iname, price) in rows {
                listOfRows.append(RowContents(cost: Float(price) ?? 0, itemname: iname))
            }
            return listOfRows
        }
        let appData = UserDefaults.standard
        let stringTable = appData.object(forKey: "table") as? [String: String] ?? [String: String]()
        rows = transformRowsToObjects(rows: stringTable)
        print(rows)
    }
    
    func get() -> [RowContents] {
        return rows
    }
}
                    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// this function may need to be static
// CHANGE TO USE USER DEFAULTS TO STORE DATA
//    func saveValues(){
//let str = "BOB" //getValues().
//let filename = getDocumentsDirectory().appendingPathComponent("output.txt")
//do {
//    try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
//} catch {
//    // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
//}
//}
//
//func readValues() -> String {
//let filename = getDocumentsDirectory().appendingPathComponent("output.txt")
//var contents: String = " "
//do {
//    try contents = String(contentsOf: filename)
//} catch {
//    contents = "error: Could not access file"
//}
//return(contents)
//}

//func getDocumentsDirectory() -> URL {
//let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//return paths[0]
//}
