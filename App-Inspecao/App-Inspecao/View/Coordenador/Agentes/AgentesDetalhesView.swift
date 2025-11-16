//
//  AgentesDetalhesView.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 16/11/25.
//

import SwiftUI

struct AgenteDetalheView: View {
    
    let agente: User
    
    // Mocks para os campos da UI
    let codigoAgente: String = "A01234"
    let nomeCompleto: String = "Marcos Antonio Xavier"
    let statusAgente: String = "Ativo"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(agente.nome) // "Marcos"
                .font(.title)
                .fontWeight(.bold)
            
            Text("Informações do Marcos") // TODO: Usar nome dinâmico
                .font(.subheadline)
                .foregroundColor(.gray)
            
            // --- Card de Informações ---
            VStack(alignment: .leading, spacing: 15) {
                CampoInfoAgente(titulo: "Código:", valor: codigoAgente)
                CampoInfoAgente(titulo: "Nome:", valor: nomeCompleto)
                CampoInfoAgente(titulo: "Status:", valor: statusAgente)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
            
            Spacer()
            
            // --- Botão de Navegação ---
            NavigationLink(destination: RelatoriosAgenteView(agente: agente)) {
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
        .navigationTitle(agente.nome)
        .navigationBarTitleDisplayMode(.inline)
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

#Preview {
    NavigationView {
        AgenteDetalheView(agente: User(id: "1", nome: "Marcos", role: "agente"))
    }
}
