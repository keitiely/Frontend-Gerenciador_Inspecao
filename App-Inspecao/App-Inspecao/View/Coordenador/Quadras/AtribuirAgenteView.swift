//
//  AtribuirAgente.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//

import Foundation
import SwiftUI

public struct AtribuirAgenteView: View {
    let quadra: Quadra
    
    @StateObject private var viewModel = AtribuirAgenteViewModel()
    
    // Variável para guardar qual agente foi selecionado
    @State private var agenteSelecionadoID: String? = nil
    
    var onAtribuicaoSucesso: () -> Void
    
    // Para fechar a tela (modal) após o sucesso
    @Environment(\.dismiss) var dismiss
    
    public var body: some View {
        ZStack {
            VStack(spacing: 20) {
                
                //  Título
                Text("Agentes Disponíveis")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                // Lista de Agentes
                ScrollView {
                    if viewModel.isLoading && viewModel.agentesDisponiveis.isEmpty {
                        ProgressView()
                    } else {
                        ForEach(viewModel.agentesDisponiveis, id: \.id) { agente in
                            BotaoAgente(
                                nome: agente.nome,
                                estaSelecionado: agente.id == agenteSelecionadoID
                            ) {
                                // Ação do botão: seleciona/desseleciona o agente
                                if agenteSelecionadoID == agente.id {
                                    agenteSelecionadoID = nil // Permite desmarcar
                                } else {
                                    agenteSelecionadoID = agente.id
                                }
                            }
                        }
                    }
                }
                
                Spacer()
                
                // Botão Principal de Ação
                Button(action: {
                    guard let agenteID = agenteSelecionadoID else { return }
                    
                    Task {
                        await viewModel.atribuirAgente(
                            quadraID: quadra.id,
                            agenteID: agenteID
                        )
                       // Se a atribuição foi um sucesso,
                      // avisa a tela anterior antes de fechar.
                        if viewModel.atribuicaoSucesso {
                            onAtribuicaoSucesso()
                        }
                    }
                }) {
                    Text("Atribuir Agente")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                // Desabilita o botão se nenhum agente estiver selecionado
                .disabled(agenteSelecionadoID == nil || viewModel.isLoading)
                
            }
            .padding()
            .background(Color(UIColor.systemGray6).ignoresSafeArea())
            .navigationTitle("Atribuir: \(quadra.nome)")
            .navigationBarTitleDisplayMode(.inline)
            
            // --- Tela de Loading (por cima de tudo) ---
            if viewModel.isLoading {
                Color.black.opacity(0.4).ignoresSafeArea()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
            }
        }
        .onAppear {
            // Quando a tela carregar, busca os agentes
            Task {
                await viewModel.carregarAgentesDisponiveis()
            }
        }
        // Popup de Sucesso
        .alert("Agente Atribuído!", isPresented: $viewModel.atribuicaoSucesso) {
            Button("OK") {
                // Ao clicar OK, fecha a tela
                dismiss()
            }
        } message: {
            Text("O agente foi atribuído a esta quadra com sucesso.")
        }
        // Popup de Erro
        .alert("Erro", isPresented: .constant(viewModel.erroMensagem != nil), actions: {
            Button("OK") {
                viewModel.erroMensagem = nil // Limpa o erro
                
            }
        }, message: {
            Text(viewModel.erroMensagem ?? "Ocorreu um erro desconhecido.")
        })
    }
}


// Componente: Botão de Seleção de Agente 
struct BotaoAgente: View {
    let nome: String
    let estaSelecionado: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(nome)
                .font(.headline)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(UIColor.systemGray4))
                .cornerRadius(8)
                .overlay(
                    // Borda verde se estiver selecionado
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(estaSelecionado ? Color.green : Color.clear, lineWidth: 3)
                )
        }
    }
}

//// Preview
//#Preview {
//    NavigationStack {
//        AtribuirAgenteView(
//            quadra: Quadra(
//                id: "q1",
//                nome: "Quadra 01",
//                status: .naoAtribuida,
//                agenteNome: nil,
//                numeroInspecoes: 0
//            )
//        )
//    }
//}
