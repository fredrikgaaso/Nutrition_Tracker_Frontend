import Foundation
import SwiftUI

enum CartService {
    static func fetchCartItems(completion: @escaping (Result<[Cart], Error>) -> Void) {
        guard let apiUrl = Bundle.main.infoDictionary?["API_BASE_URL"] as? String,
              let url = URL(string: "\(apiUrl)/cart/all") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1)))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("❌ Network error: \(error)")
                completion(.failure(error))
                return
            }

            guard let data = data else {
                print("❌ No data received")
                completion(.failure(NSError(domain: "No data", code: -1)))
                return
            }

            do {
                let carts = try JSONDecoder().decode([Cart].self, from: data)
                completion(.success(carts))
            } catch {
                print("❌ Decoding error: \(error)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    static func deleteCart (cartId: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let apiUrl = Bundle.main.infoDictionary?["API_BASE_URL"] as? String,
              let url = URL(string: "\(apiUrl)/cart/delete/\(cartId)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1)))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                completion(.failure(error))
                return
            } else {
                completion(.success(()))
            }
        }.resume()
    }
    static func createCart(cartName: String, completion: @escaping (Result<Cart, Error> ) -> Void) {
        guard let apiUrl = Bundle.main.infoDictionary?["API_BASE_URL"] as? String,
              let url = URL(string: "\(apiUrl)/cart/create") else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = ["cartName": cartName]
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1)))
                return
            }
            do {
                let createdCart = try JSONDecoder().decode(Cart.self, from: data)
                completion(.success(createdCart))
            }
            catch{
                completion(.failure(error))
            }
        }.resume()
    }
}
