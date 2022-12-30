//
//  BudgeterApp.swift
//  Budgeter
//
//  Created by Tom Smail on 22/12/2022.
//

import SwiftUI

@main
struct BudgeterApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase){ phase in
            if phase == .background {
                ContentView().itemTable.saveRows(rows: ContentView().itemTable.rows)
            }
            
            
        }
    }
}
