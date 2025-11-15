//
//  Quadra.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//

import Foundation
struct Quadra: Identifiable {
    let id = UUID()
    let numero: Int
    let numeroInspecoes: Int
    let isPendente: Bool   // O booleano que virá do banco de dados
    

    
    // Retorna o nome formatado (ex: "Quadra-07")
    var nomeFormatado: String {
        return "Quadra-\(String(format: "%02d", numero))"
    }
    
    // Retorna o texto do status baseado no booleano
    var statusTexto: String {
        return isPendente ? "Pendente" : "Concluído"
    }
}
