//
//  AddInspencaoView.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 16/11/25.
//

import SwiftUI

struct AddInspecaoView: View {
    
    @StateObject private var viewModel: AddInspecaoViewModel
    
    // Ação de "callback" para atualizar a tela anterior
    var onRegistroSucesso: () -> Void
    
    @Environment(\.dismiss) var dismiss
    
    init(quadra: Quadra, onRegistroSucesso: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: AddInspecaoViewModel(quadra: quadra))
        self.onRegistroSucesso = onRegistroSucesso
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Informação da Inspeção")
                    .font(.title2)
                    .fontWeight(.bold)
                
                // --- Card do Formulário ---
                VStack(alignment: .leading, spacing: 15) {
                    CampoFormulario(titulo: "Endereço:", texto: $viewModel.endereco)
                    
                    CampoFormulario(titulo: "Horário:", texto: $viewModel.horario)
                    
                    CampoFormulario(titulo: "Data:", texto: $viewModel.data)
                    
                    VStack(alignment: .leading) {
                        Text("Relatório:")
                            .font(.caption)
                            .foregroundColor(.gray)
                        TextEditor(text: $viewModel.relatorioTexto)
                            .frame(height: 100)
                            .padding(4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(UIColor.systemGray4), lineWidth: 1)
                            )
                    }
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                
                // --- Seção de Imagens ---
                HStack(spacing: 20) {
                    Spacer()
                    BotaoFoto(titulo: "Capturar Foto", icone: "camera.fill") {
                        // TODO: Abrir a câmera
                    }
                    
                    BotaoFoto(titulo: "Importar Imagem", icone: "photo.on.rectangle") {
                        // TODO: Abrir a galeria
                    }
                    Spacer()
                }
                .padding(.top)

                Spacer()
            }
            .padding()
        }
        // --- Botão de Registrar no Footer ---
        .safeAreaInset(edge: .bottom) {
            Button(action: {
                Task {
                    await viewModel.registrarInspecao()
                }
            }) {
                Text(viewModel.isLoading ? "Registrando..." : "Registrar")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding()
            }
            .disabled(viewModel.isLoading)
        }
        .navigationTitle("Inspeção")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Sucesso!", isPresented: $viewModel.registroSucesso) {
            Button("OK") {
                // 1. Avisa a tela anterior para recarregar
                onRegistroSucesso()
                // 2. Fecha esta tela
                dismiss()
            }
        } message: {
            Text("Inspeção registrada com sucesso!")
        }
    }
}

// --- Componentes de ajuda para esta View ---

struct CampoFormulario: View {
    let titulo: String
    @Binding var texto: String
    var desabilitado: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(titulo)
                .font(.caption)
                .foregroundColor(.gray)
            TextField(titulo, text: $texto)
                .disabled(desabilitado)
                .padding(10)
                .background(desabilitado ? Color(UIColor.systemGray5) : Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(UIColor.systemGray4), lineWidth: 1)
                )
        }
    }
}

struct BotaoFoto: View {
    let titulo: String
    let icone: String
    let acao: () -> Void
    
    var body: some View {
        VStack {
            Button(action: acao) {
                Image(systemName: icone)
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                    .frame(width: 80, height: 80)
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(10)
            }
            Text(titulo)
                .font(.caption)
        }
    }
}
