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
                    CampoDetalhe(titulo: "Endereço:", valor: inspecao.quadraNome)
                    CampoDetalhe(titulo: "Horário:", valor: inspecao.horario)
                    CampoDetalhe(titulo: "Data:", valor: inspecao.data)
                        .padding(.trailing, 250)
                }
                .frame(maxWidth: .infinity)
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
                    // Seção de Imagens Decodificadas
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                
                                // 1. Faz um loop no novo array 'fotos'
                                ForEach(inspecao.fotos ?? [], id: \.self) { base64String in
                                    
                                    // 2. Tenta decodificar a string
                                    if let uiImage = imageFromBase64(base64String) {
                                        // 3. Mostra a imagem
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(8)
                                            .clipped()
                                    } else {
                                        // 4. Mostra um erro se a string for inválida
                                        Image(systemName: "photo.fill.on.rectangle.fill")
                                            .frame(width: 100, height: 100)
                                            .background(Color(UIColor.systemGray4))
                                            .cornerRadius(8)
                                    }
                                }
                            }
                        }
                                   
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(inspecao.nome) // "Relatório 1"
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // --- ADICIONE ESTA FUNÇÃO ---
        /// Converte uma string Base64 em um objeto UIImage
        private func imageFromBase64(_ base64String: String) -> UIImage? {
            // Algumas strings base64 podem vir com um prefixo, removemos
            let stringLimpa = base64String.replacingOccurrences(of: "data:image/jpeg;base64,", with: "")
            
            guard let data = Data(base64Encoded: stringLimpa) else {
                return nil
            }
            return UIImage(data: data)
        }
        // ----------------------------
    
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
