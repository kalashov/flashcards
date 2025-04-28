import SwiftUI

struct FlashcardsView: View {
    let userName: String
    @Binding var showResult: Bool
    @Binding var knowCount: Int
    @Binding var dontKnowCount: Int

    @State private var cards: [Flashcard] = []
    @State private var currentIndex: Int = 0
    @State private var showAnswer: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            if cards.indices.contains(currentIndex) {
                Text("Card \(currentIndex + 1) of \(cards.count)")
                    .font(.headline)

                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(radius: 10)
                        .frame(height: 300)
                        .overlay(
                            Text(showAnswer ? cards[currentIndex].answer : cards[currentIndex].question)
                                .font(.title2)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .padding()
                        )
                        .animation(.easeInOut, value: showAnswer)
                }

                Button(action: {
                    withAnimation {
                        showAnswer.toggle()
                    }
                }) {
                    Text("Flip")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                HStack(spacing: 20) {
                    Button(action: {
                        recordAnswer(known: false)
                        ProgressService.shared.sendProgress(userId: userName, cardId: cards[currentIndex].id, status: "dont_know")
                    }) {
                        Text("Не знаю")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }


                    Button(action: {
                        recordAnswer(known: true)
                        ProgressService.shared.sendProgress(userId: userName, cardId: cards[currentIndex].id, status: "know")
                    }) {
                        Text("Знаю")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                }
                .padding(.horizontal)
            } else {
                Text("Нет доступных карточек.")
                    .font(.title2)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .onAppear {
            loadCards()
        }
    }

    private func loadCards() {
        FlashcardService.shared.fetchCards { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let loadedCards):
                    self.cards = loadedCards
                case .failure(let error):
                    print("Ошибка загрузки карточек: \(error.localizedDescription)")
                }
            }
        }
    }

    private func recordAnswer(known: Bool) {
        if known {
            knowCount += 1
        } else {
            dontKnowCount += 1
        }

        if currentIndex + 1 < cards.count {
            currentIndex += 1
            showAnswer = false
        } else {
            // Игра закончилась
            UserDefaultsService.shared.saveResult(for: userName, know: knowCount, dontKnow: dontKnowCount)
            showResult = true
        }
    }
}
