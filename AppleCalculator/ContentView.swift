import SwiftUI

struct ContentView: View {
    @State private var displayText = "0" // Display text
    @State private var firstNum: Double = 0 // First number chosen
    @State private var secondNum: Double = 0 // Second number chosen
    @State private var currentOperation: Operations = .none
    @State private var isPerformingOperation = false

    // Enum for calculator buttons
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
    
    // Enum for calculator operations
    enum Operations {
        case add, subtract, multiplication, division, none
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
            Color.black.edgesIgnoringSafeArea(.all)  // Black background takes up all the space (corners)
            
            VStack { // Vertical stack
                Spacer()
                
                // TEXT DISPLAY
                HStack { // Horizontal stack - to align to the right
                    Spacer() // Push text to the rightmost end
                    Text(displayText) // Placeholder text
                        .bold() // Make text bold
                        .font(.system(size: 64)) // Font size
                        .foregroundColor(.white) // Font color
                }
                .padding() // Padding on the left of the placeholder
                
                // BUTTONS
                ForEach(button, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { button in
                            Button(action: {
                                self.ButtonPress(button: button)
                            }) {
                                Text(button.title)
                                    .font(.system(size: 32))
                                    .frame(width: self.ButtonWidth(button: button), height: self.ButtonHeight())
                                    .background(self.ButtonColour(button: button))
                                    .foregroundColor(.white)
                                    .cornerRadius(self.ButtonWidth(button: button) / 2)
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
    
    // Function that assigns button colors
    func ButtonColour(button: CalculatorButton) -> Color {
        switch button {
        case .clear, .sign, .percent:
            return Color.gray // AC, +/- and % buttons are gray
        case .divide, .multiply, .minus, .plus, .equal:
            return Color.orange // Operation buttons are orange
        default:
            return Color(.darkGray) // All buttons are dark gray
        }
    }
    
    // Function that assigns button width
    func ButtonWidth(button: CalculatorButton) -> CGFloat {
        return button == .zero ? (UIScreen.main.bounds.width - 5 * 12) / 2 : (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    
    // Function that assigns button height
    func ButtonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    
    // Function that handles button presses
    func ButtonPress(button: CalculatorButton) {
        switch button {
        case .clear: // AC - All Clear
            displayText = "0"
            firstNum = 0
            secondNum = 0
            currentOperation = .none
        case .sign: // +/- button
            if displayText != "0" {
                if displayText.starts(with: "-") {
                    displayText.removeFirst()
                } else {
                    displayText = "-" + displayText
                }
            }
        case .percent: // % button
            let value = (Double(displayText) ?? 0) / 100
            displayText = formatDisplay(value)
        case .divide:
            currentOperation = .division
            firstNum = Double(displayText) ?? 0
            displayText = "0" // Reset display for the next number
        case .multiply:
            currentOperation = .multiplication
            firstNum = Double(displayText) ?? 0
            displayText = "0" // Reset display for the next number
        case .minus:
            currentOperation = .subtract
            firstNum = Double(displayText) ?? 0
            displayText = "0" // Reset display for the next number
        case .plus:
            currentOperation = .add
            firstNum = Double(displayText) ?? 0
            displayText = "0" // Reset display for the next number
        case .decimal:
            if !displayText.contains(".") {
                displayText += "."
            }
        case .equal:
            if let number = Double(displayText) {
                secondNum = number // Store the second number
                PerformOperation() // Perform the operation when "=" is pressed
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
        var expression = "\(firstNum)" // Start with the first number
        
        //Append the current operation symbol and the second number
        switch currentOperation {
        case .add:
            expression += " + \(secondNum)"
        case .subtract:
            expression += " - \(secondNum)"
        case .multiplication:
            expression += " * \(secondNum)" //Replace × with *
        case .division:
            expression += " / \(secondNum)" //Replace ÷ with /
        case .none:
            return
        }
        
        // Evaluate the expression and update display text
        let result = evaluateExpression(expression)
        displayText = formatDisplay(result)
        isPerformingOperation = true
    }
    
    // Function to format the display for whole number values
    func formatDisplay(_ value: Double) -> String {
        // Check if the result is an integer
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(value)) // Return as an integer string
        } else {
            return String(format: "%.1f", value) // Return with one decimal place
        }
    }
    
    // Function to evaluate the expression string
    func evaluateExpression(_ expression: String) -> Double {
        // Replace ÷ with / and × with * before passing to NSExpression
        let expressionWithCorrectOperators = expression
            .replacingOccurrences(of: "÷", with: "/")
            .replacingOccurrences(of: "×", with: "*")
        
        // Use NSExpression to evaluate the expression (handles BODMAS)
        let nsExpression = NSExpression(format: expressionWithCorrectOperators)
        let result = nsExpression.expressionValue(with: nil, context: nil) as? Double ?? 0
        return result
    }
}

#Preview {
    ContentView()
}
