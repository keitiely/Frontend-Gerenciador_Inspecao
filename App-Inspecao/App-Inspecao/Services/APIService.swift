//
//  APIService.swift
//  App-Inspecao
//
//  Created by Keitiely Silva Viana on 15/11/25.
//

import Foundation

// Enum para nossos erros de rede
enum APIError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed(Error)
    case decodingError
}


class APIService {
    
    // Instância única (Singleton)
    static let shared = APIService()
    
    // IMPORTANTE: Coloque o IP do computador do
    // que está rodando o backend.
    private let baseURL = "http://192.168.1.10:8080/api"
    
    
    // Funcao login
    //    Usei 'async throws' para funcionar com o 'Task' da sua View
    func login(request: LoginRequest) async throws -> LoginResponse {
        
        // Cria a URL
        guard let url = URL(string: "\(baseURL)/login") else {
            throw APIError.invalidURL
        }
        
        //  1. Configura o Request (POST, headers, body)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // 2. Codificar o 'LoginRequest' (Struct) para JSON (Dados)
        urlRequest.httpBody = try JSONEncoder().encode(request)
        
        // 3. Fazer a chamada de rede
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // 4. Checar se a resposta é um 'OK' (200)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        // 5. Decodificar o JSON (Dados) para 'LoginResponse' (Struct)
        do {
            return try JSONDecoder().decode(LoginResponse.self, from: data)
        } catch {
            throw APIError.decodingError
        }
    }
    
    // ...adicionar 'getAgentes()', 'getQuadras()' aqui depois ...
}
