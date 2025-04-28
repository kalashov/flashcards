import SwiftUI

struct StartView: View {
    @Binding var userName: String
    @Binding var isStarted: Bool

    var body: some View {
        VStack(spacing: 20) {
            Text("Добро пожаловать!")
                .font(.largeTitle)
                .bold()

            TextField("Введите ваше имя", text: $userName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                if !userName.isEmpty {
                    UserDefaults.standard.set(userName, forKey: "userName")
                    isStarted = true
                }
            }) {
                Text("Начать")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
}
