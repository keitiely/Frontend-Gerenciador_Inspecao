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
    
    
    //  O CodingKeys para segurança
    enum CodingKeys: String, CodingKey {
        case token
        case user
    }
}

