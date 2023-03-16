//
//  ContentView.swift
//  ChatGPT generation
//
//  Created by James Meegan on 3/15/23.
//

import SwiftUI

struct ContentView: View {
    let buttons = [
        ["7", "8", "9", "×"],
        ["4", "5", "6", "−"],
        ["1", "2", "3", "+"],
        [".", "0", "C", "="]
    ]
    
    @State var currentNumber: String = ""
    @State var storedNumber: Double = 0
    @State var storedOperation: String = ""
    @State var previousCalculations: [String] = []
    @State var storedEntries: [String] = []
    
    var body: some View {
        VStack(spacing: 12) {
            VStack {
                ForEach(previousCalculations.reversed(), id: \.self) { calculation in
                    HStack {
                        Spacer()
                        Text(calculation)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .lineLimit(1)
                    }
                }
            }
            Spacer()
            HStack(spacing: 12) {
                Spacer()
                Text(currentNumber)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .lineLimit(1)
                Spacer()
            }
            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 12) {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            self.buttonTapped(button)
                        }) {
                            Text(button)
                                .font(.headline)
                                .frame(width: 70, height: 70)
                                .foregroundColor(.white)
                                .background(Color.gray)
                                .cornerRadius(35)
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    func buttonTapped(_ button: String) {
        if let number = Double(button) {
            if currentNumber == "0" {
                currentNumber = button
            } else {
                currentNumber += button
            }
        } else if button == "." {
            if !currentNumber.contains(".") {
                currentNumber += "."
            }
        } else if button == "C" {
            currentNumber = "0"
            storedNumber = 0
            storedOperation = ""
            previousCalculations.removeAll()
            storedEntries.removeAll()
        } else if let operation = button.first {
            if storedOperation.isEmpty {
                storedNumber = Double(currentNumber) ?? 0
                currentNumber = ""
            } else {
                performCalculation()
            }
            storedOperation = String(operation)
        } else if button == "=" {
            performCalculation()
        }
        updatePreviousCalculations()
    }
    
    func performCalculation() {
        if let operation = storedOperation.first {
            switch operation {
            case "+":
                storedNumber += Double(currentNumber) ?? 0
            case "−":
                storedNumber -= Double(currentNumber) ?? 0
            case "×":
                storedNumber *= Double(currentNumber) ?? 0
            case "÷":
                storedNumber /= Double(currentNumber) ?? 1
            default:
                break
            }
        }
        currentNumber = String(storedNumber)
        storedOperation = ""
    }
    
    func updatePreviousCalculations() {
        
        if let operation = storedOperation.first {
            let operationResult = "\(storedNumber) \(operation) \(currentNumber)"
            let calculation = "\(storedNumber) \(operation) \(currentNumber) = "
            previousCalculations.append(calculation)
//            storedEntries.append(calculation)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
