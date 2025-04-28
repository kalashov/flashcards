import Foundation

struct Flashcard: Codable, Identifiable {
    let id: Int
    let question: String
    let answer: String
    let topic: String
}

class FlashcardService {
    static let shared = FlashcardService()
    
    private let baseURL = "http://127.0.0.1:8000"

    private init() {}

    func fetchCards(completion: @escaping (Result<[Flashcard], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/cards") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            do {
                let cards = try JSONDecoder().decode([Flashcard].self, from: data)
                completion(.success(cards))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func sendProgress(userID: String, cardID: Int, status: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/progress") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let progressData: [String: Any] = [
            "user_id": userID,
            "card_id": cardID,
            "status": status
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: progressData)
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
        task.resume()
    }
}
