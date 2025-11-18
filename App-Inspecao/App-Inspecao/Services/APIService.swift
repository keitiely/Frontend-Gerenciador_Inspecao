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
    private let baseURL = "http://localhost:3000"
    
    
    // Funcao login
    //    Usei 'async throws' para funcionar com o 'Task' da sua View
    func login(request: LoginRequest) async throws -> LoginResponse {
        
        // Cria a URL
        guard let url = URL(string: "\(baseURL)/auth/login") else {
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
    
    // MARK: - Quadras
        
        // 1. (GET) Busca todas as quadras para o Coordenador
        func getTodasAsQuadras() async throws -> [Quadra] {
            guard let url = URL(string: "\(baseURL)/quadras") else {
                throw APIError.invalidURL
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            // Aqui você adicionaria o token de auth, se necessário
            // urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIError.invalidResponse
            }
            
            do {
                return try JSONDecoder().decode([Quadra].self, from: data)
            } catch {
                print(error) // Ajuda a depurar erros de JSON
                throw APIError.decodingError
            }
        }
        
        // 2. (GET) Busca quadras de UM agente específico
        func getMinhasQuadras(agenteID: String) async throws -> [Quadra] {
            guard let url = URL(string: "\(baseURL)/quadras?id_agente=\(agenteID)") else {
                throw APIError.invalidURL
            }
            
            let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIError.invalidResponse
            }
            
            do {
                return try JSONDecoder().decode([Quadra].self, from: data)
            } catch {
                throw APIError.decodingError
            }
        }

        // MARK: - Agentes
        
        // 3. (GET) Busca todos os agentes para o Coordenador
        func buscarTodosAgentes() async throws -> [User] {
            guard let url = URL(string: "\(baseURL)/usuarios/agentes") else {
                throw APIError.invalidURL
            }
            
            let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIError.invalidResponse
            }
            
            do {
                return try JSONDecoder().decode([User].self, from: data)
            } catch {
                throw APIError.decodingError
            }
        }
        
        // 4. (GET) Busca agentes livres (sem quadra)
        func buscarAgentesLivres() async throws -> [User] {
            guard let url = URL(string: "\(baseURL)/usuarios/agentes/livres") else {
                throw APIError.invalidURL
            }
            
            let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIError.invalidResponse
            }
            
            do {
                return try JSONDecoder().decode([User].self, from: data)
            } catch {
                throw APIError.decodingError
            }
        }
        
        // 5. (GET) Busca detalhes de UM agente
        func buscarDetalhesAgente(id: String) async throws -> User {
            guard let url = URL(string: "\(baseURL)/usuarios/agentes/\(id)") else {
                throw APIError.invalidURL
            }
            
            let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIError.invalidResponse
            }
            
            do {
                return try JSONDecoder().decode(User.self, from: data)
            } catch {
                throw APIError.decodingError
            }
        }

        // 6. (POST) Atribui um agente a uma quadra
        func atribuirAgente(quadraID: String, agenteID: String) async throws {
            guard let url = URL(string: "\(baseURL)/quadras/atribuir") else {
                throw APIError.invalidURL
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Cria o corpo (body) do JSON
            let body = ["quadraID": quadraID, "agenteID": agenteID]
            urlRequest.httpBody = try JSONEncoder().encode(body)
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                // TODO: Tratar erro 400 (ex: agente já ocupado)
                throw APIError.invalidResponse
            }
            // Não precisamos decodificar nada, apenas saber que deu 200 OK
        }

        // MARK: - Inspeções e Resumos
        
        // 7. (GET) Busca inspeções (filtrando por quadra ou agente)
        func buscarInspecoes(quadraID: String? = nil, agenteID: String? = nil) async throws -> [Inspecao] {
            var urlString = "\(baseURL)/inspecoes"
            
            if let quadraID = quadraID {
                urlString += "?id_quadra=\(quadraID)"
            } else if let agenteID = agenteID {
                urlString += "?id_agente=\(agenteID)"
            } else {
                // Se não filtrar, pode trazer muitas. Mas vamos permitir.
            }
            
            guard let url = URL(string: urlString) else {
                throw APIError.invalidURL
            }

            let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIError.invalidResponse
            }
            
            do {
                return try JSONDecoder().decode([Inspecao].self, from: data)
            } catch {
                print(error)
                throw APIError.decodingError
            }
        }

        // 8. (GET) Busca o resumo da quadra (Etapa 3)
        func buscarResumo(quadraID: String) async throws -> ResumoQuadraResponse {
            guard let url = URL(string: "\(baseURL)/quadras/\(quadraID)/resumo") else {
                throw APIError.invalidURL
            }
            
            let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIError.invalidResponse
            }
            
            do {
                return try JSONDecoder().decode(ResumoQuadraResponse.self, from: data)
            } catch {
                throw APIError.decodingError
            }
        }
        
        // 9. (POST) Finaliza a quadra (Etapa 3)
        func finalizarQuadra(quadraID: String) async throws {
            guard let url = URL(string: "\(baseURL)/quadras/\(quadraID)/finalizar") else {
                throw APIError.invalidURL
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIError.invalidResponse
            }
        }

        // 10. (POST) Cria uma nova inspeção
        // NOTA: Precisamos de um 'struct' para enviar o JSON
        func registrarInspecao(request: CreateInspecaoRequest) async throws {
            guard let url = URL(string: "\(baseURL)/inspecoes") else {
                throw APIError.invalidURL
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(request)
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIError.invalidResponse
            }
        }
    }

    // MARK: - Structs de Requisição/Resposta

    // Adicione estes structs FORA da classe APIService, mas no mesmo arquivo.

    // Struct para a Etapa 3 (Resumo da Quadra)
    struct ResumoQuadraResponse: Codable {
        let visitadas: Int
        let fechadas: Int
    }

    // Struct para criar inspeção
    struct CreateInspecaoRequest: Codable {
        let id_quadra: String
        let id_agente: String
        let numero_casa: String
        let complemento: String?
        let status_visita: String // "aceita", "recusada", "morador_ausente"
        let relatorio: String
        let fotos: [String]? // Array de Base64
        let data_visita: String
        let hora_visita: String
    }
