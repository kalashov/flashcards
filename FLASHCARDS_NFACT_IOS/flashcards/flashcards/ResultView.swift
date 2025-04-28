import SwiftUI

struct ResultView: View {
    let userName: String
    let knowCount: Int
    let dontKnowCount: Int
    let onRestart: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Результаты, \(userName)!")
                .font(.largeTitle)
                .bold()

            Text("Знаю: \(knowCount)")
                .foregroundColor(.green)
                .font(.title2)

            Text("Не знаю: \(dontKnowCount)")
                .foregroundColor(.red)
                .font(.title2)

            Button(action: {
                onRestart() 
            }) {
                Text("Играть снова")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}
