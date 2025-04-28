import Foundation

class ProgressService {
    static let shared = ProgressService()
    
    private let baseURL = "http://127.0.0.1:8000"
    
    private init() {}
    
    func sendProgress(userId: String, cardId: Int, status: String) {
        guard let url = URL(string: "\(baseURL)/progress") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "user_id": userId,
            "card_id": cardId,
            "status": status
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Ошибка отправки прогресса:", error)
            } else if let response = response as? HTTPURLResponse {
                print("Прогресс отправлен. Код ответа: \(response.statusCode)")
            }
        }
        task.resume()
    }
}
