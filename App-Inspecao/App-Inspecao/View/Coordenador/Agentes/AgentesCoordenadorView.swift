//
//  AgentesCoordenadorView.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 16/11/25.
//

import SwiftUI

struct AgentesCoordenadorView: View {
    
    @StateObject private var viewModel = AgentesCoordenadorViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Agentes")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Text("Painel de Agentes")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.horizontal)
                .padding(.top, -10)
            
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                // Lista de Agentes
                List(viewModel.agentes, id: \.id) { agente in
                    
                    // Cada agente leva para a Tela 2
                    NavigationLink(destination: AgenteDetalheView(agente: agente)) {
                        Text(agente.nome)
                            .font(.headline)
                            .padding(.vertical, 8)
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Agentes")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.carregarAgentes()
        }
    }
}

#Preview {
    NavigationView {
        AgentesCoordenadorView()
    }
}
