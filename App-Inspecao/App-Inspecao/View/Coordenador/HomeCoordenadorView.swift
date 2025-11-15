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
                Text("Coordenador-\(viewModel.nomeCoordenador)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Painel")
                    .font(.title2)
                    .foregroundColor(.gray)
                
                // --- Botões ---
//                HStack(spacing: 20) {
//                    NavigationLink(destination: AgentesListView()) {
//                        BotaoMenu(titulo: "Agentes")
//                    }
//                    
//                    NavigationLink(destination: QuadrasListView()) {
//                        BotaoMenu(titulo: "Quadras")
//                    }
//                }
                
                Spacer() // Empurra tudo para cima
            }
            .padding(30) // Espaço nas laterais de toda a Vstack
            .onAppear {
                // 5. A MÁGICA ACONTECE AQUI:
                //    Quando a tela aparecer,
                //    manda o ViewModel carregar os dados
                //    passando o AuthManager
                viewModel.carregarDados(authManager: authManager)
            }
        }
    }
}


// COMPONENTE REUTILIZÁVEL: O Botão
struct BotaoMenu: View {
    var titulo: String
    
    var body: some View {
        Text(titulo)
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, maxHeight: 150) // Tamanho do botão
            .background(Color(UIColor.systemGray5)) // Fundo cinza
            .cornerRadius(16) // Cantos arredondados
    }
}


// Preview
#Preview {
    HomeCoordenadorView()
        // Adiciona um AuthManager falso para o Preview funcionar
        .environmentObject(AuthManager())
}
