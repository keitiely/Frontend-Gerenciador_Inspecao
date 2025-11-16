//
//  App_InspecaoApp.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//

import SwiftUI

@main
struct App_InspecaoApp: App {
    
    @StateObject private var authManager = AuthManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authManager)
        }
    }
}
