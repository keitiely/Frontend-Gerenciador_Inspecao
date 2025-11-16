//
//  QuadraCard.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//
import SwiftUI

struct QuadraCardView: View {
    let quadra: Quadra
    
    private var corDeFundo: Color {
        return quadra.isPendente ?
        .red.opacity(0.7) :
        .green.opacity(0.7)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Usa a propriedade 'nomeFormatado' do modelo
            Text(quadra.nomeFormatado)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Text("Numero de Inspeções: \(quadra.numeroInspecoes)")
                .font(.subheadline)
                .foregroundColor(.black)
        
            HStack {
                Spacer()
                
                // Usa a propriedade 'statusTexto' do modelo
                Text("Status: \(quadra.statusTexto)")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(corDeFundo)
        .cornerRadius(10)
    }
}


#Preview {
    VStack(spacing: 20) {
        QuadraCardView(quadra: Quadra(numero: 7, numeroInspecoes: 20, isPendente: false))
    }
    .padding()
}

