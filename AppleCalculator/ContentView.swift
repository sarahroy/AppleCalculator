//
//  ContentView.swift
//  AppleCalculator
//
//  Created by Sarah Roy on 2024-10-29.
//

import SwiftUI

struct ContentView: View {
    @State private var displayText = "0" //display text
    @State private var secondNum: Double = 0 //second number chosen
    @State private var firstNum: Double = 0 //first number chosen
    
    //Enum for calculator buttons
    enum CalculatorButton: String {
        case clear = "AC"
        case sign = "+/-"
        case percent = "%"
        case divide = "÷"
        case multiply = "×"
        case minus = "-"
        case plus = "+"
        case equal = "="
        case decimal = "."
        case one = "1"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
        case zero = "0"
    }
    //Enum for calculator operations
    enum Operations: String {
        case add = "+"
        case subtract = "-"
        case multiplication = "×"
        case division = "÷"
        case none = ""
    }
    let buttons: [[CalculatorButton]] = [
        [.clear, .sign, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal],
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)  //black bg takes up all the space (corners)
            
            VStack {//vertical stack
                Spacer()
                
                //TEXT DISPLAY
                HStack { //horizotal stack - to align to the right
                    Spacer() //push text to the rightmost end
                    Text(displayText) //placeholder text
                        .bold() //make text bold
                        .font(.system(size: 64)) //font size
                        .foregroundColor(.white)//font colour
                }
                .padding() //padding on the left of the placeholder
                
                //BUTTONS
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { button in
                            Button(action: {
                                self.Press(button: button)
                            }) {
                                Text(button)
                                    .font(.system(size: 32))
                                    .frame(width: self.buttonWidth(button: button), height: self.buttonHeight())
                                    .background(self.buttonColor(button: button))
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(button: button) / 2)
                            }
                        }
                    }
                }
            }.padding()
        }
    }
    
    
    
    //Function that assigns button colours
    func buttonColor(button: String) -> Color {
        switch button {
        case "AC", "+/-", "%":
            return Color.gray
        case "÷", "×", "-", "+", "=":
            return Color.orange
        default:
            return Color(.darkGray)
        }
    }
    
    //Function that assigns button width
    func ButtonWidth() {
        
    }
    
    //Function that assigns button height
    func ButtonHeight(){
        
    }
    
    //Function that handles button presses
    func ButtonPress() {
        
    }
    
    //Function that handles the selected operation
    func PerformOperation() {
        
    }
}

#Preview {
    ContentView()
}
