//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Michael & Diana Pascucci on 4/24/22.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - VIEWS
    struct FlagImage: View {
        var image: String
        
        var body: some View {
            Image(image)
                .renderingMode(.original)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
        }
    }
    
    // MARK: - PROPERTIES
    @State private var showingScore: Bool = false
    @State private var gameOver: Bool = false
    @State private var scoreTitle: String = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var userScore: Int = 0
    @State private var questionCount: Int = 1
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    // MARK: - ANIMATION PROPERTIES
    @State private var degreesToSpin = 0.0
    @State private var opacityAmount = 1.0
    @State private var scaleAmount = 1.0
    
    // MARK: - FUNCTIONS
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1          // Increase the UserScore
            degreesToSpin += 360
            opacityAmount -= 0.75
            scaleAmount -= 0.5
        } else {
            scoreTitle = "Wrong! That is the flag of\n \(countries[number])"
        }
        
        if questionCount < 8 {
            showingScore = true     // Trigger the ShowScore Alert
            questionCount += 1      // Increment the QuestionCount
        } else {
            gameOver = true         // Trigger the GameOver Alert
            questionCount += 1      // Increment the QuestionCount
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        opacityAmount = 1.0
        scaleAmount = 1.0
    }
    
    func resetGame() {
        questionCount = 1       // Reset the QuestionCount to 1
        userScore = 0           // Reset the UserScore to 0
        askQuestion()
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            
            //LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
            RadialGradient(stops: [Gradient.Stop(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                                   Gradient.Stop(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)],
                           center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    } //: VStack
                    
                    ForEach(0..<3) { number in
                        Button {
                            withAnimation {
                                flagTapped(number)
                            }
                        } label: {
                            FlagImage(image: countries[number])
                        }
                        .scaleEffect(number == correctAnswer ? 1 : scaleAmount)
                        .rotation3DEffect(.degrees(number == correctAnswer ? degreesToSpin : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(number == correctAnswer ? 1 : opacityAmount)
                        .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                    } //: ForEach
                } //: VStack
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)").titleStyle()
                
                Spacer()
            }
            .padding()
        }
        
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(userScore)")
        }
        
        .alert("Game Over", isPresented: $gameOver) {
            Button("Continue", action: resetGame)
        } message: {
            Text("You got \(userScore) of 8 flags correct!")
        }
    }
}

// MARK: - VIEW MODIFIERS
struct MyTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.title.bold())
    }
}

// MARK: - VIEW EXTENSIONS
extension View {
    func titleStyle() -> some View {
        modifier(MyTitle())
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
