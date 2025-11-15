//
//  ContentView.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//
import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authManager: AuthManager

    var body: some View {
        
        if authManager.isLoggedIn {
            
            if authManager.userRole == "Agente" {
                HomeAgenteView()
            } else {
                HomeCoordenadorView()
                
            }
            
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthManager()) 
}
