//
//  UserModel.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//

import Foundation

// envia para api
// precisa verifcar se corresponde ao json que o backend espera
struct LoginRequest: Codable {
    let email: String
    let password: String
}

// o que o back devolve
// verificar se corresponde ao json que o back envia
struct LoginResponse: Codable {
    let token: String
    let user: User
}

// a resposta dos dados do usuario que receber
struct User: Codable {
    // verificar os campos que o back vai mandar!
    let id: Int
    let nome: String
    let role: String //  "grupo_usuario" (ex: "coordenador" ou "agente")
}
