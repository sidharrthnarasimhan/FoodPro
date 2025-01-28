import SwiftUI
import AuthenticationServices

struct ContentView: View {
    var body: some View {
        NavigationView {
            LoginView()
                .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
        }
    }
}

struct LoginView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("logo") // Replace with your logo asset name
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)

            Text("Portion Pro")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.orange)

            Spacer()

            SignInWithAppleButton(
                .signIn,
                onRequest: { _ in },
                onCompletion: { _ in }
            )
            .frame(height: 50)
            .cornerRadius(10)

            Button(action: {
                // Google sign-in action
            }) {
                HStack {
                    Image(systemName: "globe")
                    Text("Sign in with Google")
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.red, .orange]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: .orange.opacity(0.4), radius: 10, x: 0, y: 5)
            }

            NavigationLink(destination: HomeView()) {
                Text("Go to Home Page")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.green, .teal]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(color: .green.opacity(0.4), radius: 10, x: 0, y: 5)
            }

            Spacer()
        }
        .padding()
        .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
    }
}

struct HomeView: View {
    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "fork.knife")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.orange)

            Text("Welcome to Portion Pro")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.orange)

            GradientButton(title: "Recipe Calculator", colors: [.orange, .yellow]) {}

            GradientButton(title: "Fridge Recipe", colors: [.green, .blue]) {}

            GradientButton(title: "Theme Food", colors: [.red, .pink]) {}
        }
        .padding()
    }
}

struct GradientButton: View {
    var title: String
    var colors: [Color]
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: colors),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: colors.last!.opacity(0.4), radius: 10, x: 0, y: 5)
        }
        .padding(.horizontal)
    }
}

@main
struct PortionProApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
