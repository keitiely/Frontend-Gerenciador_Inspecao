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
    let statusVisita: StatusVisita
    // Outros campos que o banco de dados retornar...
}

enum StatusVisita: String {
    case pendente = "PENDENTE" // Exemplo, verifique o valor real
    case concluida = "CONCLUIDA" // Exemplo

}
