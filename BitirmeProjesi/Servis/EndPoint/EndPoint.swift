//
//  EndPoint.swift
//  BitirmeProjesi
//
//  Created by hamid on 06.03.25.
//

import Foundation

protocol EndPointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    
    func request() -> URLRequest
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}

/// farkli farkli path icin tanimlayacagiz
enum EndPoint {
    
    case generateDietPlan(userData: DietPlanRequest)
}

struct DietPlanRequest: Codable {
    let age: Int
    let weight: Double
    let height: Double
    let gender: String
    let activity_level: String
    let goal: String
    let dietary_restrictions: [String]
}

extension EndPoint: EndPointProtocol {
    var baseURL: String {
        return "https://capstoneprojectagent-1.onrender.com"
    }
    
    var path: String {
        switch self {
        case .generateDietPlan:
            return "/generate-diet-plan"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .generateDietPlan:
            return .post
        
            
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .generateDietPlan:
            return ["Content-Type": "application/json"]
        }
    }
    
    var body: Data? {
        switch self {
        case .generateDietPlan(let userData):
            return try? JSONEncoder().encode(userData)
        default:
            return nil
        }
    }
    
    func request() -> URLRequest {
        guard var components = URLComponents(string: baseURL) else {
            fatalError("Invalid base URL")
        }
        
        components.path = path
        
        guard let url = components.url else {
            fatalError("Invalid URL components")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        request.httpBody = body
        
        return request
    }
}
