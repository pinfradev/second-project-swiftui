//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Fray Pineda on 15/5/21.
//

import SwiftUI

struct FlagImage: View {
    var country: String
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/))
            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 2)
    }
}

struct BoxButton: View {
    var number: Int
    @Binding var showingScore: Bool
    @Binding var scoreTitle: String
    @Binding var selectedButton: Int
    @Binding var userScore: Int?
    @Binding var shouldMakeOpaque: Bool

    var countries: [String]
    var correctAnswer: Int
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            userScore = 100
            scoreTitle = "Correct"
            shouldMakeOpaque = true
        } else {
            userScore = 0
            scoreTitle = "Wrong that is the flag of \(countries[number])"
        }
        
        showingScore = true
    }
    
    var body: some View {
        Button(action: {
            self.selectedButton = number
            flagTapped(number)
        }) {
            FlagImage(country: self.countries[number])
        }
        .rotationEffect(
            .degrees(( selectedButton == correctAnswer && selectedButton == number) ? Double(360) : 0)
        )
        .opacity((shouldMakeOpaque && selectedButton != number) ? 0.25 : 1.0)
        .animation(shouldMakeOpaque ? .interpolatingSpring(stiffness: 10.0, damping: 11.0) : nil)
    }
}
struct ContentView: View {
    @State var showingScore = false
    @State var scoreTitle = ""
    @State var selected = 4
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0 ... 2)
    @State var userScore: Int?
    @State var shouldmakeOpaque = false
    
    private var flagsArray = [FlagImage]()
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
        userScore = nil
        shouldmakeOpaque = false
    }
    
    private func getText() -> String {
        var textToShow = ""
        if let text = userScore {
            textToShow = "\(text)"
        } else {
            textToShow = countries[correctAnswer]
        }
        return textToShow
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    
                    Text(getText())
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    BoxButton(number: number,
                              showingScore: self.$showingScore, scoreTitle: self.$scoreTitle, selectedButton: self.$selected, userScore: self.$userScore, shouldMakeOpaque: self.$shouldmakeOpaque, countries: countries, correctAnswer: correctAnswer)
                    
                    Spacer()
                }
            }
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text("your score is \(userScore ?? 0)"), dismissButton: .default(Text("Continue")) {
                    askQuestion()
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
