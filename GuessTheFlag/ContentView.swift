// Created by deovinsum

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "Germany", "France", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    
    @State private var animationAmount = 0.0
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundStyle(.white)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                        .font(.largeTitle.weight(.semibold))
                }
                
                ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            withAnimation(.spring(duration: 1, bounce: 0.5)) {}
                            
                        } label: {
                            Image(countries[number])
                                .clipShape(.buttonBorder)
                                .shadow(radius: 5)
                                .rotation3DEffect(.degrees(animationAmount), axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/)
                        }
                }
                
                    Text("You score is \(userScore)")
                    .foregroundStyle(.white)
                    .font(.subheadline.weight(.heavy))
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
//            Text("You score is \(userScore)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            userScore += 1
            scoreTitle = "Correct"
            animationAmount = 360
        } else {
            scoreTitle = "Incorrect"
            animationAmount = 0
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        animationAmount = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}

