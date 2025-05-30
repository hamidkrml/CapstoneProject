//
//  Maneger.swift
//  BitirmeProjesi
//
//  Created by hamid on 06.03.25.
//

import Foundation
import SwiftData


class NetworkMeneger {
    static let shared = NetworkMeneger()
    private init(){}
    
    private func request<T:Decodable>(_ endpoint: EndPoint, completion: @escaping (Result<T, Error>) -> Void){
    
        let task = URLSession.shared.dataTask(with: endpoint.request()){data,response,eror in
            /// eror icin
            if let eror = eror{
                completion(.failure(eror))
                return
            }
            ///response icin
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200, response.statusCode <= 200 else {
                 
                completion(.failure(NSError(domain: "invalide response", code: 0)))
                return
            }
            
            guard let data = data else{
                completion(.failure(NSError(domain: "invalide response data", code: 0)))
                return
            }
            
            do {
                 let decodeData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodeData))
            }catch let error {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
   
    
    // Diyet planı oluşturma
    func generateDietPlanFromUserData(modelContext: ModelContext) async throws -> String {
        // Kullanıcı bilgilerini SwiftData'dan al
        let descriptor = FetchDescriptor<KullanciBilgileri>()
        guard let user = try modelContext.fetch(descriptor).first else {
            throw NSError(domain: "User not found", code: 0)
        }
        
        // Kullanıcı verilerini dönüştür
        guard let age = Int(user.yas),
              let weight = Double(user.ceki),
              let height = Double(user.boy) else {
            throw NSError(domain: "Invalid user data", code: 0)
        }
        
        // API isteği için veriyi hazırla
        let dietPlanRequest = DietPlanRequest(
            age: age,
            weight: weight,
            height: height,
            gender: user.cinsiyet.lowercased(),
            activity_level: "orta",
            goal: "kilo vermek",
            dietary_restrictions: []
        )
        
        // API isteğini oluştur
        let endpoint = EndPoint.generateDietPlan(userData: dietPlanRequest)
        let request = endpoint.request()
        
        // API isteğini gönder
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Yanıtı kontrol et
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NSError(domain: "Invalid response", code: 0)
        }
        
        // Yanıtı string'e çevir
        guard let responseString = String(data: data, encoding: .utf8) else {
            throw NSError(domain: "Invalid response data", code: 0)
        }
        
        return responseString
    }
}
