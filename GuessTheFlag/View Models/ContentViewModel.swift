//
//  ContentViewModel.swift
//  GuessTheFlag
//
//  Created by Michael & Diana Pascucci on 6/5/22.
//

import Foundation

class ContentViewModel: ObservableObject {
    
    // MARK: - PROPERTIES
    @Published var showingScore: Bool = false
    @Published var gameOver: Bool = false
    @Published var scoreTitle: String = ""
    @Published var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @Published var correctAnswer = Int.random(in: 0...2)
    @Published var userScore: Int = 0       // Added for Challenge 1
    @Published var questionCount: Int = 1
    
    // MARK: - ANIMATION PROPERTIES
    @Published var degreesToSpin = 0.0
    @Published var opacityAmount = 1.0
    @Published var scaleAmount = 1.0
    
    // MARK: - METHODS
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1                  // Added for Challenge 1
            degreesToSpin += 360
            opacityAmount -= 0.75
            scaleAmount -= 0.5
        } else {
            scoreTitle = "Wrong! That is the flag of\n \(countries[number])"        // Added for Challenge 2
        }
        
        if questionCount < 8 {              // Added for Challenge 3
            showingScore = true
            questionCount += 1
        } else {
            gameOver = true
            questionCount += 1
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        opacityAmount = 1.0
        scaleAmount = 1.0
    }
    
    func resetGame() {
        questionCount = 1
        userScore = 0         
        askQuestion()
    }
}
