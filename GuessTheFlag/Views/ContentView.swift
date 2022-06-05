//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Michael & Diana Pascucci on 4/24/22.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - PROPERTIES
    @StateObject private var vm = ContentViewModel()
    
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
                        Text(vm.countries[vm.correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            withAnimation {
                                vm.flagTapped(number)
                            }
                        } label: {
                            FlagImage(image: vm.countries[number])
                        }
                        .scaleEffect(number == vm.correctAnswer ? 1 : vm.scaleAmount)
                        .rotation3DEffect(.degrees(number == vm.correctAnswer ? vm.degreesToSpin : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(number == vm.correctAnswer ? 1 : vm.opacityAmount)
                        .accessibilityLabel(K.labels[vm.countries[number], default: "Unknown flag"])
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(vm.userScore)").titleStyle()
                
                Spacer()
            }
            .padding()
        }
        .alert(vm.scoreTitle, isPresented: $vm.showingScore) {
            Button("Continue", action: vm.askQuestion)
        } message: {
            // Added for Challenge 1
            Text("Your score is \(vm.userScore)")
        }
        // Added for Challenge 3
        .alert("Game Over", isPresented: $vm.gameOver) {
            Button("Reset", action: vm.resetGame)
        } message: {
            Text("You got \(vm.userScore) of 8 flags correct!")
        }
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
