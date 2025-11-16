//
//  HomeCoordenadorView.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//

import SwiftUI

struct HomeCoordenadorView: View {

    @EnvironmentObject var authManager: AuthManager
    @StateObject private var viewModel = HomeCoordenadorViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                
                // --- Título ---
                Text("Coordenador -\n\(viewModel.nomeCoordenador)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Acessos")
                    .font(.title2)
                    .foregroundColor(.gray)
                
                // --- Botões ---
                HStack(spacing: 20) {
                    NavigationLink(destination:
                        AgentesCoordenadorView()) {
                        BotaoMenu(titulo: "Agentes")
                    }
                    
                    NavigationLink(destination:
                        QuadrasCoordenadorView()) {
                        BotaoMenu(titulo: "Quadras")
                    }
                }
                
                Spacer() // Empurra tudo para cima
            }
            .padding(30)
            .onAppear { //assim que a tela aparecer manda pra viewmodel carregar os dados passando o authmanager
                viewModel.carregarDados(authManager: authManager)
            }
        }
    }
}



struct BotaoMenu: View {
    var titulo: String
    
    var body: some View {
        Text(titulo)
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, maxHeight: 150)
            .background(Color(UIColor.systemGray5))
            .cornerRadius(16)
    }
}


// Preview
#Preview {
    HomeCoordenadorView()
        .environmentObject(AuthManager())
}
