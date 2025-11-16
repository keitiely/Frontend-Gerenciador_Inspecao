//
//  RelatoriosListView.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.

import SwiftUI

struct RelatoriosListView: View {
    
    @StateObject private var viewModel: RelatoriosListViewModel
    
    init(quadra: Quadra) {
        _viewModel = StateObject(wrappedValue: RelatoriosListViewModel(quadra: quadra))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Relatórios feitos - \(viewModel.quadra.nome)")
                .font(.title)
                .fontWeight(.bold)
                .padding([.horizontal, .top])
            
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                // Lista de Relatórios
                List(viewModel.inspecoes) { inspecao in
                    
                    // Cada linha é um link para a Tela 2
                    NavigationLink(destination: InspecaoDetalheView(inspecao: inspecao)) {
                        

                        VStack(alignment: .leading, spacing: 4) {
                            Text(inspecao.nome)
                                .font(.headline)
                            Text(inspecao.quadraNome)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 8)
                    }
                }
                .listStyle(.plain)
            }
        
        }
        .navigationTitle("Relatórios")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            // Carrega os dados quando a tela aparece
            await viewModel.carregarRelatorios()
        }
    }
}

// Preview
#Preview {
    NavigationView {
        RelatoriosListView(quadra: Quadra(
            id: "q-mock",
            nome: "Quadra 1",
            status: .pendente,
            agenteNome: "Marcos", numeroInspecoes: 2
        ))
    }
}
