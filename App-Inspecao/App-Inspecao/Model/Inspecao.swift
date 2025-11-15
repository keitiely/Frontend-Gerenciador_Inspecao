//
//  Inspecao.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//

import Foundation

struct Inspecao: Identifiable {
    let id = UUID()
    let nome: String
    let endereco: String
    // Outros campos que o banco de dados retornar...
}
