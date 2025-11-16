//
//  QuadraDetalheView.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//
import SwiftUI

struct QuadraDetalheView: View {
    
    @StateObject private var viewModel: QuadraDetalheViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var onSucesso: () -> Void
    
    init(quadra: Quadra, onSucesso: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: QuadraDetalheViewModel(quadra: quadra))
        self.onSucesso = onSucesso
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Componente reutilavel
            QuadraCardView(quadra: viewModel.quadra)
                .padding(.horizontal)
            
            // Cabeçalho da Lista "Inspeções"
            HStack {
                Text("Inspeções")
                    .font(.headline)
                Spacer()
                
                NavigationLink(destination:
                AddInspecaoView( quadra: viewModel.quadra, onRegistroSucesso: {
                      Task {
                         await viewModel.carregarInspecoes()
                        }
                    }
                )
                ) {
                    Image(systemName: "plus")
                        .font(.headline)
                        .padding(8)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                }
            }
            .padding()
            
            // Lista de Inspeções
            if viewModel.isLoading {
                ProgressView()
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: 12) {
                        
                 //chamando o componente da quadra
                        ForEach(viewModel.inspecoes) { inspecao in
                            InspecaoCard(inspecao: inspecao)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            // Botao Tela resumo
            NavigationLink(destination:
                            ResumoQuadraView(
                                quadra: viewModel.quadra,
                                onFinalizacaoSucesso: {
                                    self.onSucesso()
                                    presentationMode.wrappedValue.dismiss()
                                }
                            )
            ) {
                Text("Resumo da Quadra")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            .padding()
            
        }
        .task {
            await viewModel.carregarInspecoes()
        }
        .navigationTitle(viewModel.quadra.nome)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.primary)
            }
        )
    }
}


#Preview {
    NavigationView {
           // Corrigido para usar o NOVO "molde" de Quadra
           QuadraDetalheView(quadra: Quadra(
               id: "q-mock-1",
               nome: "Quadra 01",
               status: .pendente,
               agenteNome: "Joao Mock", numeroInspecoes: 5
           ), onSucesso: {
               // O Preview não faz nada no sucesso
               print("Callback de sucesso chamado no Preview")
           }
           )
       }
}
