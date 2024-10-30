//
//  ContentView.swift
//  AppleCalculator
//
//  Created by Sarah Roy on 2024-10-29.
//

import SwiftUI

enum CalculatorButton: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case plus = "+"
    case minus = "-"
    case multiply = "x"
    case divide = "/"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case sign = "-/+"
}
enum Operations {
    case addition, subtraction, multiplication, division, none
}
struct ContentView: View {
    //2D array for calc button grid
    let buttons: [[CalculatorButton]] = [
        [.clear, .sign, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal],
    ]
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
