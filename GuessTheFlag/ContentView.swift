//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Fray Pineda on 15/5/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Hello, world!")
                Text("This is inside a stack")
                Text("third")
            }
            HStack {
                Text("Hello, world!")
                Text("This is inside a stack")
                Text("third")
            }
            HStack {
                Text("Hello, world!")
                Text("This is inside a stack")
                Text("third")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
