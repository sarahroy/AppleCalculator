//
//  ContentView.swift
//  AppleCalculator
//
//  Created by Sarah Roy on 2024-10-29.
//

import SwiftUI

struct ContentView: View {
    @State private var displayText = "0" //display text
    @State private var firstNum: Double = 0 //first number chosen
    @State private var secondNum: Double = 0 //second number chosen
    @State private var currentOperation: Operations = .none
    @State private var isPerformingOperation = false
    
    //Enum for calculator buttons
    enum CalculatorButton: String, CaseIterable {
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
        
        var title: String {
            return self.rawValue
        }
    }
    //Enum for calculator operations
    enum Operations: String {
        case add = "+"
        case subtract = "-"
        case multiplication = "×"
        case division = "÷"
        case none = ""
    }
    let button: [[CalculatorButton]] = [
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
                ForEach(button, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { button in
                            Button(action: {
                                self.ButtonPress(button: button)
                            }) {
                                Text(button)
                                    .font(.system(size: 32))
                                    .frame(width: self.ButtonWidth(button: button), height: self.ButtonHeight())
                                    .background(self.ButtonColour(button: button))
                                    .foregroundColor(.white)
                                    .cornerRadius(self.ButtonWidth(button: button) / 2)
                            }
                        }
                    }
                }
            }.padding()
        }
    }
    
    
    
    //Function that assigns button colours
    func ButtonColour(button: String) -> Color {
        switch button {
            
        case CalculatorButton.clear.title, CalculatorButton.sign.title, CalculatorButton.percent.title:
            return Color.gray //AC, +/- and % buttons are gray
            
        case CalculatorButton.divide.title, CalculatorButton.multiply.title, CalculatorButton.minus.title, CalculatorButton.plus.title, CalculatorButton.equal.title:
            return Color.orange //operation buttons are orange
            
        default:
            return Color(.darkGray) //all buttons are dark gray
        }
    }
    
    //Function that assigns button width
    func ButtonWidth(button: String) -> CGFloat {
        return button == CalculatorButton.zero.title ? (UIScreen.main.bounds.width - 5 * 12) / 2 : (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    
    //Function that assigns button height
    func ButtonHeight() -> CGFloat{
        return 80; //will be changed
    }
    
    //Function that handles button presses
    func ButtonPress(button: CalculatorButton) {
        switch button{
        case .clear: //AC - All Clear
            displayText = "0"
            firstNum = 0
            secondNum = 0
            currentOperation = .none
        case .sign: //+/-
            if displayText != "0" {
                if displayText.starts(with: "-") {
                    displayText.removeFirst()
                } else {
                    displayText = "-" + displayText
                }
            }
        case .percent: //%
            let value = (Double(displayText) ?? 0) / 100
            displayText = formatDisplay(value)
        case .divide:
            currentOperation = .division
            isPerformingOperation = true
        case .multiply:
            currentOperation = .multiplication
            isPerformingOperation = true
        case .minus:
            currentOperation = .subtract
            isPerformingOperation = true
        case .plus:
            currentOperation = .add
            isPerformingOperation = true
        case .decimal:
            if !displayText.contains(".") {
                displayText += "."
            }
        case .equal:
            if let number = Double(displayText) {
                secondNum = number
                PerformOperation()
            }
        default:
            let number = button.title
            if isPerformingOperation {
                displayText = number
                isPerformingOperation = false
            } else {
                displayText = displayText == "0" ? number : displayText + number
            }
        }
    }
    
    //Function that handles the selected operation
    func PerformOperation() {
        let result: Double
        switch currentOperation {
        case .division:
            result = firstNum != 0 ? firstNum / secondNum : 0
        case .multiplication:
            result = firstNum * secondNum
        case .subtract:
            result = firstNum - secondNum
        case .add:
            result = firstNum + secondNum
        case .none:
            return
        }
        currentOperation = .none
        isPerformingOperation = true
        displayText = formatDisplay(result) // Format the result for display
    }
    //Function to format the display for whole number values
    func formatDisplay(_ value: Double) -> String {
        //Check if the result is an integer
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(value)) //Return as an integer string
        } else {
            return String(format: "%.1f", value) //Return with one decimal place
        }
    }
}

#Preview {
    ContentView()
}
