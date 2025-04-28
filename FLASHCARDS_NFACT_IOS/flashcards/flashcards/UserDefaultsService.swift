import Foundation

class UserDefaultsService {
    static let shared = UserDefaultsService()
    
    private let knowKey = "knowCounts"
    private let dontKnowKey = "dontKnowCounts"
    
    private init() {}
    
    func saveResult(for user: String, know: Int, dontKnow: Int) {
        var knowCounts = UserDefaults.standard.dictionary(forKey: knowKey) as? [String: Int] ?? [:]
        var dontKnowCounts = UserDefaults.standard.dictionary(forKey: dontKnowKey) as? [String: Int] ?? [:]
        
        knowCounts[user] = know
        dontKnowCounts[user] = dontKnow
        
        UserDefaults.standard.set(knowCounts, forKey: knowKey)
        UserDefaults.standard.set(dontKnowCounts, forKey: dontKnowKey)
    }
    
    func loadResult(for user: String) -> (know: Int, dontKnow: Int) {
        let knowCounts = UserDefaults.standard.dictionary(forKey: knowKey) as? [String: Int] ?? [:]
        let dontKnowCounts = UserDefaults.standard.dictionary(forKey: dontKnowKey) as? [String: Int] ?? [:]
        
        let know = knowCounts[user] ?? 0
        let dontKnow = dontKnowCounts[user] ?? 0
        
        return (know, dontKnow)
    }
    
    func resetResult(for user: String) {
        var knowCounts = UserDefaults.standard.dictionary(forKey: knowKey) as? [String: Int] ?? [:]
        var dontKnowCounts = UserDefaults.standard.dictionary(forKey: dontKnowKey) as? [String: Int] ?? [:]
        
        knowCounts[user] = 0
        dontKnowCounts[user] = 0
        
        UserDefaults.standard.set(knowCounts, forKey: knowKey)
        UserDefaults.standard.set(dontKnowCounts, forKey: dontKnowKey)
    }
}
