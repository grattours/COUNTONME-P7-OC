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
        return text
    }

// ajout du signeDecimal
    func addPoint() {
        let stringNumber = stringNumbers.last
        var stringNumberDecimal = stringNumber
        stringNumberDecimal = stringNumberDecimal! + "."
        stringNumbers[stringNumbers.count-1] = stringNumberDecimal!
    }
    // ajout du nombre avec "²" dans le tableau des nombres
    func addSquare() {
        let stringNumberS = stringNumbers.last!
        var stringNumberSquare = stringNumberS
        stringNumberSquare = stringNumberSquare + "²"
        stringNumbers[stringNumbers.count-1] = stringNumberSquare
    }
    
    // ajout du nombre avec "!" dans le tableau des nombres
    func addFactorial(){
        let stringNumberf = stringNumbers.last!
        var stringNumberFactorial = stringNumberf
        stringNumberFactorial = stringNumberFactorial + "!"
        stringNumbers[stringNumbers.count-1] = stringNumberFactorial
    }
    // ajout factorielle
    func factorial(a: Float) -> Float {
        let n = a
        if(n == 0){
            return 1
        } else {
            return a == 1 ? a : a*factorial(a: a-1)
        }
    }

// concaténation des chiffres pour en faire des nombres
    func addNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
    }
// Ajout de l'opérateur au tableau des opérateurs
    func addOperator(_ newOperator: String) {
        print("addOperator")
//        if newOperatorMutable == "x!" { newOperatorMutable = "!"}
        operators.append(newOperator)
        stringNumbers.append("")
    }
//  on ne calcule que des + et - puisque l'expression est réduite à ces opérations la.
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
    
    // formatte et calcul le total
    func getTotal() -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        reduceExpression()
        let total = formatter.string(from: NSNumber(value: calculateTotal()))
        print("total getTotal = \(String(describing: total))")
        return String(total!)
    }
    
    // priorités on reduit l'expression en remplaçant les opérations X et /
    // en partant de la gauche. on remplace le résultat dans le tableau des nombres[]
    // on supprime les opérateurs /  et * du tableau tmpOperator[]
    func reduceExpression() {
        reduceSquare()      // cacul réduit le carré à son résultat
        reduceFactorial()   // réduit la factorielle à son résultat
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
     // cacul réduit le carré à son résultat
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
    
    // touche clear => réinitialisation des tableaux de nombres et d'opérateurs
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
    }
    
    // réduit la factorielle à son résultat
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
