//
//  ContentView.swift
//  Rock-Paper-Sciscors-Game
//
//  Created by Santhosh Srinivas on 01/06/25.
//

import SwiftUI

struct ContentView: View {
    
    let rps = ["🪨", "📄", "✂️"]
    let winningCombo = ["📄", "✂️", "🪨"]
    let losingCombo = ["✂️", "🪨", "📄"]
    @State private var result = Bool.random()
    @State private var score = 0
    @State private var compChoice = Int.random(in: 0...2)
    @State private var questionNumber = 1
    @State private var maxQuestions = false
    @State private var animate = false
    var body: some View {
        ZStack{
            Circle()
                .fill(LinearGradient(
                    colors: [Color.pink.opacity(0.6), Color.purple.opacity(0.6)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing))
                .frame(width: 300, height: 300)
                .blur(radius: 80)
                .offset(x: animate ? -150 : 150, y: animate ? -150 : 150)
                .animation(.easeInOut(duration: 6).repeatForever(autoreverses: true), value: animate)

            Circle()
                .fill(LinearGradient(
                    colors: [Color.blue.opacity(0.6), Color.cyan.opacity(0.6)],
                    startPoint: .bottomTrailing,
                    endPoint: .topLeading))
                .frame(width: 300, height: 300)
                .blur(radius: 80)
                .offset(x: animate ? 150 : -150, y: animate ? 150 : -150)
                .animation(.easeInOut(duration: 6).repeatForever(autoreverses: true), value: animate)

            VStack{
                Text("Rock Paper Scisscors")
                    .font(.largeTitle.bold())
                    .padding(.top,100)
                VStack{
                    Text("I Pick")
                        .font(.largeTitle)
                    
                    Text("\(rps[compChoice])")
                        .font(.system(size: 150))
                    Text("\( result ? "You Should Win" : "You Should Lose")")
                        .font(.title.bold())
                }
                .padding(.top)
                Spacer()
                
                HStack{
                    ForEach(0..<3){ option in
                        Button{
                            print("\(rps[option]) Button is clicked")
                            playerMove(option: option)
                        } label: {
                            Text("\(rps[option])")
                                .font(.system(size: 100))
                        }
                    }
                }
                Text("Play No: \(questionNumber)/10")
                    .font(.title.bold())
                    .padding(2)
                Text("Score: \(score)/10")
                    .font(.title.bold())
                    .padding(2)
//                Spacer()
                Spacer()
            }
        }
        .ignoresSafeArea()
        .alert("""
                    You've reached the end.
                    Do you wish to restart?
                    """, isPresented: $maxQuestions) {
                    Button("Restart", action: replayGame)
        //            questionNumber = 1
                } message: {
                    Text("You got a score of \(score)/10")
                }
    }
    
    func playerMove(option: Int) {
        if result {
            if rps[option] == winningCombo[compChoice]{
                score += 1
            }
        } else {
            if rps[option] == losingCombo[compChoice]{
                score += 1
            }
        }
        if questionNumber == 10 {
            maxQuestions = true
            return
            
        }
        replayGame()
    }
    func replayGame() {
        compChoice = Int.random(in: 0...2)
        result.toggle()
        questionNumber += 1
        if maxQuestions {
            questionNumber = 1
            score = 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
