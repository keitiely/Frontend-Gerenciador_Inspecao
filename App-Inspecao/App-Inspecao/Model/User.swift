//
//  User.swift
//  App-Inspecao
//
// Created by Keitiely Silva Viana on 15/11/25.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    let nome: String
    let role: String // ex: "coordenador" ou "agente"
    
    // tela agente detalhe view precisa
    let codigoAgente: String?
    let nomeCompleto: String?
    let statusAgente: String? // ex: "Ativo"

    // "Traduz" os nomes da API (direita) para os do App (esquerda)
    enum CodingKeys: String, CodingKey {
        case id
        case nome
        case role
        
        // Mapeia os campos da API para os nomes do seu struct
        case codigoAgente = "codigo_agente"
        case nomeCompleto = "nome_completo"
        case statusAgente = "status_agente"
    }
}
