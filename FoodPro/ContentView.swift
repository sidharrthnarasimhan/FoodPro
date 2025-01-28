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
            Spacer()

            Image("logo") // Replace with your logo asset name
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)

            Text("Portion Pro")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)

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
                        gradient: Gradient(colors: [.red, .green]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: .green.opacity(0.4), radius: 10, x: 0, y: 5)
            }

            NavigationLink(destination: HomeView()) {
                Text("Go to Home Page")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.blue, .green]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(color: .blue.opacity(0.4), radius: 10, x: 0, y: 5)
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
                .foregroundColor(.green)

            Text("Welcome to Portion Pro")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.orange)

            NavigationLink(destination: RecipeCalculatorView()) {
                Text("Recipe Calculator")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.orange, .yellow]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(color: .orange.opacity(0.4), radius: 10, x: 0, y: 5)
            }


            GradientButton(title: "Fridge Recipe", colors: [.blue, .green]) {}

            GradientButton(title: "Theme Food", colors: [.red, .orange]) {}
        }
        .padding()
    }
}

struct RecipeCalculatorView: View {
    @State private var recipe: String = ""
    @State private var servings: Int = 1
    @State private var flavor: Int = 1
    @State private var ingredients: [String] = []

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Image(systemName: "list.bullet")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                    Text("Recipe Calculator")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
                .padding(.top)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Enter Recipe:")
                        .font(.headline)
                        .foregroundColor(.gray)

                    TextField("Type your recipe here", text: $recipe)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 5)
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Number of Servings: \(servings)")
                        .font(.headline)
                        .foregroundColor(.gray)

                    Stepper("", value: $servings, in: 1...100)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 5)
                        .labelsHidden()
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Flavor Intensity: \(flavor)")
                        .font(.headline)
                        .foregroundColor(.gray)

                    Stepper("", value: $flavor, in: 1...5)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 5)
                        .labelsHidden()
                }
                .padding(.horizontal)

                Button(action: {
                    fetchIngredients()
                }) {
                    HStack {
                        Image(systemName: "leaf")
                        Text("Fetch Ingredients")
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.green, .yellow]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(color: .green.opacity(0.4), radius: 10, x: 0, y: 5)
                }
                .padding(.horizontal)

                if !ingredients.isEmpty {
                    Text("Ingredients:")
                        .font(.headline)
                        .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(ingredients, id: \ .self) { ingredient in
                            Text(ingredient)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                                .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 5)
                        }
                    }
                    .padding(.horizontal)
                }

                Spacer()
            }
        }
        .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
    }

    func fetchIngredients() {
        // Example backend interaction
        guard let url = URL(string: "https://example-cloud-gpt-backend.com/ingredients") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "recipe": recipe,
            "servings": servings,
            "flavor": flavor
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            if let response = try? JSONDecoder().decode([String].self, from: data) {
                DispatchQueue.main.async {
                    ingredients = response
                }
            }
        }.resume()
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

