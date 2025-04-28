import SwiftUI

struct ContentView: View {
    @State private var userName: String = UserDefaults.standard.string(forKey: "userName") ?? ""
    @State private var isStarted: Bool = UserDefaults.standard.bool(forKey: "isStarted")
    @State private var showResult: Bool = false
    @State private var knowCount: Int = UserDefaults.standard.integer(forKey: "knowCount")
    @State private var dontKnowCount: Int = UserDefaults.standard.integer(forKey: "dontKnowCount")

    var body: some View {
        VStack {
            if !isStarted || userName.isEmpty {
                StartView(userName: $userName, isStarted: $isStarted)
            } else if !showResult {
                FlashcardsView(
                    userName: userName,
                    showResult: $showResult,
                    knowCount: $knowCount,
                    dontKnowCount: $dontKnowCount
                )
            } else {
                ResultView(
                    userName: userName,
                    knowCount: knowCount,
                    dontKnowCount: dontKnowCount,
                    onRestart: {
                        UserDefaultsService.shared.resetResult(for: userName)
                        userName = ""
                        isStarted = false
                        knowCount = 0
                        dontKnowCount = 0
                        showResult = false
                    }
                )
            }
        }
    }
}
