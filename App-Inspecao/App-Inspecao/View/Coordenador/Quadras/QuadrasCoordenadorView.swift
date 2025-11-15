//
//  QuadrasCoordenadorView.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//

import SwiftUI

struct QuadrasCoordenadorView: View {
    
    @StateObject private var viewModel = QuadrasCoordenadorViewModel()
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Quadras")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Painel de quadras")
                    .font(.title2)
                    .foregroundColor(.gray)
                
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    // --- 1. SECÇÃO NÃO ATRIBUÍDAS ---
                    SecaoQuadrasView(
                        titulo: "Quadras não atribuidas",
                        cor: .red,
                        quadras: viewModel.quadrasNaoAtribuidas,
                         //Destino: A tela para ATRIBUIR
                        destino: { quadra in
                            AnyView(AtribuirAgenteView(quadra: quadra))
                        }
                    )
                    
                    // --- 2. SECÇÃO PENDENTES ---
                    SecaoQuadrasView(
                        titulo: "Quadras pendentes",
                        cor: .yellow,
                        quadras: viewModel.quadrasPendentes,
                        // Destino: A tela de RELATÓRIOS
                        destino: { quadra in
                            AnyView(RelatoriosListView(quadra: quadra))
                        }
                    )
                    
                    // --- 3. SECÇÃO CONCLUÍDAS ---
                    SecaoQuadrasView(
                        titulo: "Quadras Concluidas",
                        cor: .blue,
                        quadras: viewModel.quadrasConcluidas,
                      //   Destino: A tela de RELATÓRIOS
                        destino: { quadra in
                            AnyView(RelatoriosListView(quadra: quadra))
                        }
                    )
                }
            }
            .padding(20)
        }
//        .navigationTitle("")
//        .navigationBarBackButtonHidden(true)
        .onAppear {
           
            viewModel.carregarDados(authManager: authManager)
        }
    }
}



// Componente para a Secção (Vermelha, Amarela, Azul)
struct SecaoQuadrasView<Destino: View>: View {
    let titulo: String
    let cor: Color
    let quadras: [Quadra]
    let destino: (Quadra) -> Destino
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(titulo)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
            
            VStack(spacing: 1) {
                ForEach(quadras) { quadra in
                    NavigationLink(destination: destino(quadra)) {
                        CardQuadraCoordenador(quadra: quadra)
                    }
                    .buttonStyle(.plain)
                }
            }
            .background(.white)
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.bottom)
            
        }
        .frame(maxWidth: .infinity)
        .background(cor.opacity(0.8))
        .cornerRadius(16)
    }
}

// Componente para o Card (o item da lista)
struct CardQuadraCoordenador: View {
    let quadra: Quadra
    
    var body: some View {
        VStack {
            HStack {
                Text(quadra.nome)
                    .font(.headline)
                    .foregroundColor(.black)
                
                Spacer()
                
                if let agenteNome = quadra.agenteNome {
                    Text("Agente: \(agenteNome)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding(20)
            
            Divider()
        }
    }
}


#Preview {
    NavigationStack {
        QuadrasCoordenadorView()
            .environmentObject(AuthManager())
    }
}
