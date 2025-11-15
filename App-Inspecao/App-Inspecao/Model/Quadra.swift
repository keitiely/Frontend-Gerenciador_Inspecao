//
//  Quadra.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//

import Foundation
// Define a estrutura de dados de uma Quadra
// O 'Identifiable' é necessário para o SwiftUI usar em Listas (ForEach)
struct Quadra: Identifiable {
    let id = UUID() // Identificador único para a lista
    let numero: Int
    let numeroInspecoes: Int
    let isPendente: Bool   // O booleano que virá do banco de dados
    
    // Bônus: Podemos criar propriedades "computadas"
    // para facilitar a vida da View
    
    // Retorna o nome formatado (ex: "Quadra-07")
    var nomeFormatado: String {
        return "Quadra-\(String(format: "%02d", numero))"
    }
    
    // Retorna o texto do status baseado no booleano
    var statusTexto: String {
        return isPendente ? "Pendente" : "Concluído"
    }
}
