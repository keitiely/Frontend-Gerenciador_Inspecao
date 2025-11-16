//
//  AgentesDetalhesView.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 16/11/25.
//

import SwiftUI

struct AgenteDetalheView: View {
    
    @StateObject private var viewModel: AgenteDetalheViewModel
    
    init(agente: User) {
        _viewModel = StateObject(wrappedValue: AgenteDetalheViewModel(agente: agente))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text(viewModel.agente.nome)
                .font(.title)
                .fontWeight(.bold)
            
        
            Text("Informações do \(viewModel.agente.nome)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            //  Mostra um loading enquanto os dados carregam
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding()
            } else {
                // --- Card de Informações ---
                VStack(alignment: .leading, spacing: 15) {
                    
                   
                    CampoInfoAgente(titulo: "Código:", valor: viewModel.codigoAgente)
                    CampoInfoAgente(titulo: "Nome:", valor: viewModel.nomeCompleto)
                    CampoInfoAgente(titulo: "Status:", valor: viewModel.statusAgente)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
            }
            
            Spacer()
            
            
            NavigationLink(destination: RelatoriosAgenteView(agente: viewModel.agente)) {
                Text("Relatórios")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(10)
            }
            
        }
        .padding()
        .navigationTitle(viewModel.agente.nome)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.carregarDetalhes()
        }
    }
}

// Componente de ajuda para esta tela
struct CampoInfoAgente: View {
    let titulo: String
    let valor: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(titulo)
                .font(.caption)
                .foregroundColor(.gray)
            Text(valor)
                .font(.body)
                .fontWeight(.medium)
        }
    }
}

//#Preview {
//    NavigationView {
//        AgenteDetalheView(agente: User(codigoAgente: "agente_01", nomeCompleto: "Marcos", role: "agente"))
//    }
//}
