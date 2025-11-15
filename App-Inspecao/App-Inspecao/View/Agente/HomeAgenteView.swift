//
//  HomeAgenteView.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//
import SwiftUI

struct HomeAgenteView: View {
    @EnvironmentObject var authManager : AuthManager
    @StateObject private var viewModel = AgenteViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                
                // Titulo
                Text("Agente - \(viewModel.agente?.nome ?? "...")")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
               // cabeçalho lista
                HStack {
                    Text("Quadras Atribuídas")
                        .font(.headline)
                    Spacer()
                    Text("Mes: \(viewModel.mesAtual)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
               
                //lista de quadras
                if viewModel.isLoading {
                    ProgressView() // Mostra um "loading"
                        .frame(maxWidth: .infinity)
                } else {
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(viewModel.quadras) { quadra in
                                NavigationLink(destination: QuadraDetalheView(quadra: quadra)) {
                                    QuadraCardView(quadra: quadra)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.top)
            .navigationTitle("") // Oculta o título padrão da barra
            .navigationBarHidden(true) // Esconde a barra inteira
            
            .onAppear { //assim que a tela aparecer manda pra viewmodel carregar os dados passando o authmanager
                viewModel.carregarDados(authManager: authManager)
            }
        }
    }
}
#Preview {
    HomeAgenteView()
        .environmentObject(AuthManager())
}

