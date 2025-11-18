//
//  ResumoQuadraDetalheView.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 16/11/25.
//

import SwiftUI
import Charts

struct ResumoQuadraView: View {
    
    @StateObject private var viewModel: ResumoQuadraViewModel
    

    var onFinalizacaoSucesso: () -> Void
    
    @Environment(\.dismiss) var dismiss
    
    init(quadra: Quadra, onFinalizacaoSucesso: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: ResumoQuadraViewModel(quadra: quadra))
        self.onFinalizacaoSucesso = onFinalizacaoSucesso
    }
    
    var body: some View {
        VStack {
            Text("Resumo da Quadra")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            if viewModel.isLoading {
                ProgressView()
                Spacer()
            } else {
              //card grafico
                VStack {
                    ZStack {
                        Chart(viewModel.chartData) { data in
                            SectorMark(
                                angle: .value("Total", data.valor),
                                innerRadius: .ratio(0.65)
                            )
                            .foregroundStyle(by: .value("Tipo", data.nome))
                        }
                        // Define as cores (para bater com a imagem)
                        .chartForegroundStyleScale([
                            "visitadas": .green, // ou .gray
                            "fechadas": .white
                        ])
                        // Remove a legenda automática
                        .chartLegend(.hidden)
                        //texto de porcentagem no meio
                        Text(viewModel.percentualVisitadas.formatted(.percent.precision(.fractionLength(2))))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .frame(height: 300)
                    .padding()

                    // legenda
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(viewModel.chartData) { data in
                            HStack {
                                Circle()
                                    .fill(data.nome == "visitadas" ? .green: .white)
                                    .frame(width: 10, height: 10)
                                Text(data.nomeLegenda)
                                    .font(.subheadline)
                            }
                        }
                    }
                    .padding()
                    
                }
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.systemGray5))
                .cornerRadius(20)
                .padding()
                
                Spacer()
                
                // botao finalizar
                Button(action: {
                    Task {
                        await viewModel.finalizarQuadra()
                    }
                }) {
                    Text(viewModel.isLoading ? "Finalizando..." : "Finalizar Quadra")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                }
                .disabled(viewModel.isLoading)
                .padding()
            }
        }
        .task {
            // Carrega o resumo quando a tela aparece
            await viewModel.carregarResumo()
        }
        .alert("Sucesso!", isPresented: $viewModel.finalizacaoSucesso) {
            Button("OK") {
                onFinalizacaoSucesso()
                dismiss()
            }
        } message: {
            Text("Quadra finalizada com sucesso!")
        }
    }
}
