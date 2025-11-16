//
//  RelatoriosAgenteView.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 16/11/25.
//
//
//  RelatoriosAgenteView.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 16/11/25.
//

import SwiftUI

struct RelatoriosAgenteView: View {
    
    @StateObject private var viewModel: RelatoriosAgenteViewModel
    
    init(agente: User) {
        _viewModel = StateObject(wrappedValue: RelatoriosAgenteViewModel(agente: agente))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Relatórios feitos - \(viewModel.agente.nome)")
                .font(.title)
                .fontWeight(.bold)
                .padding([.horizontal, .top])
            
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                // Lista de Relatórios
                List(viewModel.inspecoes) { inspecao in
                    
                    // CADA LINHA LEVA PARA A TELA 4 (JÁ EXISTENTE)
                    NavigationLink(destination: InspecaoDetalheView(inspecao: inspecao)) {
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(inspecao.nome)
                                .font(.headline)
                            Text(inspecao.quadraNome) // Mostra a quadra
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
            await viewModel.carregarRelatorios()
        }
    }
}
//
//#Preview {
//    NavigationView {
//        RelatoriosAgenteView(agente: User(id: "1", nome: "Marcos", role: "agente"))
//    }
//}
