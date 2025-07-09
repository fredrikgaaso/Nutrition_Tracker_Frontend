import Foundation
import SwiftUI


enum ProductService {
    
    static func fetchProductsFromApi(completion: @escaping (Result < [Product], Error>) -> Void) {
        guard let apiUrl = Bundle.main.infoDictionary?["API_BASE_URL"] as? String,
              let url = URL(string: "\(apiUrl)/product/fetch") else {
            completion(.failure(NSError(domain: "Invalidurl", code: -1)))
            return
        }
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            if let error = error {
                print("Network error \(error)")
                completion(.failure(error))
                return
            }
            guard let data = data else {
                print("No data received")
                completion(.failure(NSError(domain: "No data", code: -1)))
                return
            }
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
            }catch {
                print("Failure parsing JSON: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }

    
    static func getAllProducts(completion: @escaping (Result < [Product], Error> ) -> Void) {
        guard let apiUrl = Bundle.main.infoDictionary?["API_BASE_URL"] as? String,
              let url = URL(string: "\(apiUrl)/product/all") else {
            completion(.failure(NSError(domain: "Invalid url", code: -1)))
            return
        }
      
            URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Network error \(error)")
                completion(.failure(error))
                return
            }
            guard let data = data else {
                print("No data received")
                completion(.failure(NSError(domain: "No data", code: -1)))
                return
            }
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
            } catch {
                print("Failure parsing JSON: \(error)")
                completion(.failure(error))
            }
            
        }.resume()
    }
}
