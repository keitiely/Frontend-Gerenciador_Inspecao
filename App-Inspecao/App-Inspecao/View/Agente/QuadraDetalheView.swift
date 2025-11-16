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
    
    init(quadra: Quadra) {
        _viewModel = StateObject(wrappedValue: QuadraDetalheViewModel(quadra: quadra))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Agora usa o componente reutilizável
            QuadraCardView(quadra: viewModel.quadra)
                .padding(.horizontal)
            
            // --- 2. Cabeçalho da Lista "Inspeções" ---
            HStack {
                Text("Inspeções")
                    .font(.headline)
                Spacer()
                
                NavigationLink(destination: Text("Tela Futura: Adicionar Inspeção")) {
                    Image(systemName: "plus")
                        .font(.headline)
                        .padding(8)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                }
            }
            .padding()
            
            // --- 3. Lista de Inspeções ---
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
            
            // ---  Botão de Resumo (Footer) ---
            NavigationLink(destination: Text("Tela Futura: Resumo da Quadra")) {
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
           ))
       }
}
