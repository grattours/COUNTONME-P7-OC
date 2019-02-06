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
    let point = "."

    // reconstructs the text of the expression with numbers and operators
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
        return text
    }

// adding the Decimal point
    func addPoint() {
        let stringNumber = stringNumbers.last
        var stringNumberDecimal = stringNumber
        stringNumberDecimal = stringNumberDecimal! + "."
        stringNumbers[stringNumbers.count-1] = stringNumberDecimal!
    }
    // adding the number with "²" in the number table
    func addSquare() {
        let stringNumberS = stringNumbers.last!
        var stringNumberSquare = stringNumberS
        stringNumberSquare = stringNumberSquare + "²"
        stringNumbers[stringNumbers.count-1] = stringNumberSquare
    }
    
    // adding the number with "!" in the numbers table
    func addFactorial(){
        let stringNumberf = stringNumbers.last!
        var stringNumberFactorial = stringNumberf
        stringNumberFactorial = stringNumberFactorial + "!"
        stringNumbers[stringNumbers.count-1] = stringNumberFactorial
    }
    // factorial addition
    func factorial(a: Float) -> Float {
        let n = a
        if(n == 0){
            return 1
        } else {
            return a == 1 ? a : a*factorial(a: a-1)
        }
    }

// concatenate numbers to make numbers
    func addNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
    }
// Add operator to operator array
    func addOperator(_ newOperator: String) {
        print("addOperator")
//        if newOperatorMutable == "x!" { newOperatorMutable = "!"}
        operators.append(newOperator)
        stringNumbers.append("")
    }
//  we only calculate + and - since the expression is reduced to these operations
    func calculateTotal() -> Float {
        var total: Float = 0
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Float(stringNumber) {
                if operators[i] == "+" {
                    total += number
                } else if operators[i] == "-" {
                    total -= number
                }
            }
        }
        clear()
        return total
    }
    
    // format and calculate the total
    func getTotal() -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        reduceExpression()
        let total = formatter.string(from: NSNumber(value: calculateTotal()))
        print("total getTotal = \(String(describing: total))")
        return String(total!)
    }
    
    // priorities we reduce the expression by replacing the operations X and /
    // from the left. replace the result in the number table
    // you remove the operators / and * from the tmpOperator array
    func reduceExpression() {
        reduceSquare()      // calculation reduces the square to its result
        reduceFactorial()   // reduces the factorial to its result
        // opération  *  et X
        var tmpStringNumbers = stringNumbers
        var tmpOperators = operators
        while tmpOperators.contains("x") || tmpOperators.contains("÷") {
            let indexTmpOperator = tmpOperators.firstIndex (where: { $0 == "x" || $0 == "÷"})
            let tmpOperator = tmpOperators[indexTmpOperator!]
            let tmpOperande1 = Float(tmpStringNumbers[indexTmpOperator! - 1])
            let tmpOperande2 = Float(tmpStringNumbers[indexTmpOperator!])
            print(tmpOperande1!)
            print(tmpOperande2!)
            var tmpResult: Float = 0
            if tmpOperator == "x" {
                tmpResult = Float(tmpOperande1! * tmpOperande2!)
            } else {
                tmpResult = Float(tmpOperande1! / tmpOperande2!)
            }
            tmpOperators.remove(at: indexTmpOperator!)
            
            tmpStringNumbers[indexTmpOperator! - 1] = "\(tmpResult)"
            tmpStringNumbers.remove(at: indexTmpOperator!)
            stringNumbers = tmpStringNumbers
            operators = tmpOperators
        }
    }
     // we reduce the square to its result
     func reduceSquare() {
        var tmpNumbersToSquare = stringNumbers
        var firstSquareIndex = tmpNumbersToSquare.firstIndex { $0.contains("²")}
        while firstSquareIndex != nil {
            let tmpSquaredNumber = powf(Float(tmpNumbersToSquare[firstSquareIndex!].dropLast(1))!, 2)
            tmpNumbersToSquare[firstSquareIndex!] = "\(tmpSquaredNumber)"
            firstSquareIndex = tmpNumbersToSquare.firstIndex { $0.contains("²")}
        }
        stringNumbers = tmpNumbersToSquare
    }
    
    // clear key => reset tables of numbers and operators
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
    }
    
    // reduces the factorial to its result
    func reduceFactorial(){
            var tmpNumbersToFactorial = stringNumbers
            var firstFactorialIndex = tmpNumbersToFactorial.firstIndex { $0.contains("!")}
            while firstFactorialIndex != nil {
                let tmpFactorialNumber =
                    factorial(a: Float(tmpNumbersToFactorial[firstFactorialIndex!].dropLast(1))!)
                tmpNumbersToFactorial[firstFactorialIndex!] = "\(tmpFactorialNumber)"
                firstFactorialIndex = tmpNumbersToFactorial.firstIndex { $0.contains("!")}
            } //fin while
            stringNumbers = tmpNumbersToFactorial
  
    } //fin reduceFactorial
}
