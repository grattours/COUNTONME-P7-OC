//
//  Calculator.swift
//  CountOnMe
//
//  Created by Luc Derosne on 28/01/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation

class Calculator {

    // MARK: - Properties
    var stringNumbers: [String] = [String()]
    var operators: [String] = ["+"]
    var index = 0
    
    // reconstitue le text de l'expression avec les nombres et les opérateurs
    func getTextToDisplay() -> String {
        var text = ""
        for (i, stringNumber) in stringNumbers.enumerated() {
            // Add operator
            if i > 0 {
                text += operators[i]
            }
            // Add number
            text += stringNumber
        }
        // textView.text = text
        return text
    }

// concaténation des chiffres pour en faire des nombres
    func addNumber(_ newNumber: Int) {
        print("newNumber : \(newNumber)" )
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
    }
    
    func addOperator(_ newOperator: String) {
        operators.append(newOperator)
        stringNumbers.append("")
    }
//
    func calculateTotal() -> Int {
        var total = 0
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Int(stringNumber) {
                // faire un switch avec les opérateur si X et /
                if operators[i] == "+" {
                    total += number
                } else if operators[i] == "-" {
                    total -= number
                }
            }
        }
        clear()
        print("operators.count=\(operators.count)")
        print("stringNumbers.count=\(stringNumbers.count)")
        print("stringNumbers.last=\(String(describing: stringNumbers.last))")
        return total
    }

// gérer ici la priorité, avant calculateTotal()
// avec un tableau tmp
// func reduceExpression
    func getTotal() -> String {
        print("getTotal")
        print(stringNumbers)
        print("getTotal")
        print(operators)
        let total = calculateTotal()
        return String(total)
    }
    
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
    }
    
}
