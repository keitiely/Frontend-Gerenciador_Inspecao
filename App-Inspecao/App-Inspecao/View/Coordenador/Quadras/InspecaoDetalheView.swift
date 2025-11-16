//
//  InspecaoDetalheView.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 16/11/25.
//

import SwiftUI

struct InspecaoDetalheView: View {
    
    let inspecao: Inspecao
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Informação da Inspeção")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
                // --- Seção de Detalhes ---
                VStack(alignment: .leading, spacing: 15) {
                    CampoDetalhe(titulo: "Endereço:", valor: inspecao.endereco)
                    CampoDetalhe(titulo: "Horário:", valor: inspecao.horario)
                    CampoDetalhe(titulo: "Data:", valor: inspecao.data)
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                
                // --- Seção do Relatório ---
                VStack(alignment: .leading, spacing: 8) {
                    Text("Relatório:")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    Text(inspecao.relatorioTexto)
                        .font(.body)
                }
                
                // --- Seção de Imagens ---
                VStack(alignment: .leading, spacing: 8) {
                    Text("Imagens:")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    // Placeholder para as imagens
                    HStack(spacing: 10) {
                        Rectangle()
                            .fill(Color(UIColor.systemGray4))
                            .frame(width: 100, height: 100)
                            .cornerRadius(8)
                        
                        Rectangle()
                            .fill(Color(UIColor.systemGray4))
                            .frame(width: 100, height: 100)
                            .cornerRadius(8)
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(inspecao.nome) // "Relatório 1"
        .navigationBarTitleDisplayMode(.inline)
    }
}

// --- Componente de ajuda para esta tela ---
struct CampoDetalhe: View {
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
