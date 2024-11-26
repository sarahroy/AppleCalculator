import SwiftUI

struct ContentView: View {
    @State private var displayText = "0" // Display text
    @State private var firstNum: Double = 0 // First number chosen
    @State private var secondNum: Double = 0 // Second number chosen
    @State private var currentOperation: Operations = .none
    @State private var isPerformingOperation = false
    @State private var OperationsQ: [String] = [] //queue for operators
    @State private var operandsQ: [Double] = [] // Queue for operands
    
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
                        .font(.system(size: 70)) // Font size
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
                                    .font(.system(size: 40))
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
            operandsQ.removeAll() // Clear operands q
            OperationsQ.removeAll() // Clear operators q
            
        case .sign: // +/- button
            if displayText != "0" {
                if displayText.starts(with: "-") {
                    displayText.removeFirst()
                } else {
                    displayText = "-" + displayText
                }
            }
        case .percent: // % button
            if let lastValue = Double(displayText) {
                // For percent: multiply by 0.01
                let result = lastValue * 0.01
                displayText = formatDisplay(result)
                operandsQ.append(result) // Save the result for future operations
            }
        case .divide, .multiply, .minus, .plus: // Operation buttons
            // If there's a number on the screen, push it to the operands queue
            if let currentValue = Double(displayText) {
                operandsQ.append(currentValue)
                OperationsQ.append(button.title) // Store the operator
                displayText = "0" // Reset the display for the next input
            }
        case .decimal: // . button
            if !displayText.contains(".") {
                displayText += "."
            }
        case .equal: // "=" button
            // Add the last value to operands
            if let currentValue = Double(displayText) {
                operandsQ.append(currentValue)
            }
            let result = evaluateExpression()
            displayText = formatDisplay(result)
            operandsQ.removeAll() // Clear the operands q
            OperationsQ.removeAll() // Clear the operators q
        default:
            // Number buttons (0-9)
            let number = button.title
            if displayText == "0" {
                displayText = number
            } else {
                displayText += number
            }
        }
    }
    
    // Function to evaluate the operations queue
    func evaluateExpression() -> Double {
        // Handle operations in the queue
        var result = operandsQ.first ?? 0
        
        for (index, operatorSymbol) in OperationsQ.enumerated() {
            let operand = operandsQ[index + 1]
            
            switch operatorSymbol {
            case "+":
                result += operand
            case "-":
                result -= operand
            case "×":
                result *= operand
            case "÷":
                result /= operand
            default:
                break
            }
        }
        
        return result
    }
    
    // Function to format the display for whole number values
    func formatDisplay(_ value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1) == 0 {
            return String(Int(value)) // Return as an integer string
        } else {
            return String(format: "%.2f", value) // Return with two decimal places
        }
    }
}

#Preview {
    ContentView()
}
