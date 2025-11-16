//
//  InspecaoCardView.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//

import SwiftUI


struct InspecaoCard: View {
    

    let inspecao: Inspecao
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(inspecao.nome)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Text(inspecao.endereco)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .border(Color.gray)
      
        
        
    }
}


#Preview {
    InspecaoCard(
        inspecao: Inspecao(
            nome: "Inspeção 1",
            endereco: "Endereço: Quadra 29, Conjunto C, Casa 29"
        )
    )
    .padding()
}
