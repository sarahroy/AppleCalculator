//
//  ContentView.swift
//  AppleCalculator
//
//  Created by Sarah Roy on 2024-10-29.
//

import SwiftUI

enum CalculatorButton: String, Identifiable {
    case zero, one, two, three, four, five, six, seven, eight, nine, plus, minus, multiply, divide, equal, clear, decimal, percent, sign
    
    var id: Self { self }
}
struct ContentView: View {
    //2D array for calc button grid
    let buttons: [[CalculatorButton]] = []
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) //black bg takes up all the space (corners)
            
            VStack { //vertical stack
                
                //TEXT DISPLAY
                HStack { //horizotal stack - to align to the right
                    Spacer() //push text to the rightmost end
                    Text("0") //placeholder text
                        .bold() //make text bold
                        .font(.system(size: 64)) //font size
                        .foregroundColor(.white)//font colour
                }
                .padding() //padding on the left of the placeholder
                
                //BUTTONS
                
            }
        }
    }
}

#Preview {
    ContentView()
}
