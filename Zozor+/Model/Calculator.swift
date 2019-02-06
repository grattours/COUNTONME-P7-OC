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
        // textView.text = text
        return text
    }

// ajout du signeDecimal
    func addPoint() {
//        if let stringNumber = stringNumbers.last, point.range(of: stringNumber) == nil {
//            addNumericalEntry(stringNumber, point)
//        }
        let stringNumber = stringNumbers.last
        var stringNumberDecimal = stringNumber
        stringNumberDecimal = stringNumberDecimal! + "."
        stringNumbers[stringNumbers.count-1] = stringNumberDecimal!
//        print("ajout point")
        print(stringNumbers)
    }
    
    func addSquare() {
        let stringNumber = stringNumbers.last!
        var stringNumberSquare = stringNumber
        stringNumberSquare = stringNumberSquare + "²"
        stringNumbers[stringNumbers.count-1] = stringNumberSquare
        print("ajout square")
        print(stringNumbers)
        let num = Float(stringNumber)
        print("carré \(powf(num!, 2))")
        // stringNumbers.last = String(num)
        //stringNumber = String(num)

    }
//
//  Add an entry to a number
//    private func addNumericalEntry(_ stringNumber: String, _ newNumericalEntry: String) {
//        var stringNumberMutable = stringNumber
//        stringNumberMutable += newNumericalEntry
//        stringNumbers[stringNumbers.count-1] = stringNumberMutable
//    }

// concaténation des chiffres pour en faire des nombres
    func addNumber(_ newNumber: Int) {
//        print("newNumber : \(newNumber)" )
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
    }
    
//    func factorial(){
//        print("factorial")
//        let stringNumber = stringNumbers.last
//        var stringNumberFact = stringNumber
//        // calcul facto
//        stringNumberFact = stringNumberFact! + "."
//        var fact: Float = 1
//        for index in stride(from:1, to: Float(stringNumberFact!) + Float(1), by:1){
//            fact = fact * index
//        }
//        stringNumbers[stringNumbers.count-1] = stringNumberFact!
//        print("ajout Facto")
//        print(stringNumbers)
//    }
    
    func addOperator(_ newOperator: String) {
        var newOperatorMutable = newOperator
//        if newOperatorMutable == "x!" { newOperatorMutable = "!"}
        if newOperatorMutable == "x²" { newOperatorMutable = "²"}
        operators.append(newOperatorMutable)
//          operators.append(newOperator)
        stringNumbers.append("")
    }
//  on ne calcule que des + et - puisque l'expression est réduite à ces opérations la.
    func calculateTotal() -> Float {
        var total: Float = 0
        print("calculateTotal")
        print(stringNumbers)
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Float(stringNumber) {
                print("number \(number)")
                print("operators[i] \(operators[i])")
                if operators[i] == "+" {
                    total += number
                } else if operators[i] == "-" {
                    total -= number
                }
            }
        }
        clear()
//        print("operators.count=\(operators.count)")
//        print("stringNumbers.count=\(stringNumbers.count)")
//        print("stringNumbers.last=\(String(describing: stringNumbers.last))")
//        return total
        return total
        // formatter.string(from: total as NSNumber)
    }
    
    func getTotal() -> String {
//        print("appel reduceExpression")
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        reduceExpression()
//        print("getTotal")
//        print(stringNumbers)
//        print("getTotal")
//        print(operators)
        let total = formatter.string(from: NSNumber(value: calculateTotal()))
        print("total getTotal = \(String(describing: total))")
        // return String(formatter.string(from: as NSNumber))
        return String(total!)
        // formatter.string(from: as NSNumber)
    }
    
    // priorités on reduit l'expression en remplaçant les opérations X et /
    // en partant de la gauche. on remplace le résultat dans le tableau des nombres[]
    // on supprime les opérateurs /  et * du tableau tmpOperator[]
    fileprivate func reduceExpression() {
//        print("nombres et opérateurs d'origine : ")
//        print(tmpStringNumbers)
//        print(tmpOperators)
        var tmpStringNumbers = stringNumbers
        var tmpOperators = operators
        reduceSquare()
// opération  *  et X
        while tmpOperators.contains("x") || tmpOperators.contains("÷") {
//            print("opération x ou ÷")
            let indexTmpOperator = tmpOperators.firstIndex (where: { $0 == "x" || $0 == "÷"})
            let tmpOperator = tmpOperators[indexTmpOperator!]
            let tmpOperande1 = Float(tmpStringNumbers[indexTmpOperator! - 1])
            let tmpOperande2 = Float(tmpStringNumbers[indexTmpOperator!])
//            print("tmpOperande1")
            print(tmpOperande1!)
//            print("tmpOperande2")
            print(tmpOperande2!)
//            print("opération à remplacer :")
            
            // print(tmpStringNumbers[indexTmpOperator!])
            // print("resultat à remplacer :")
            var tmpResult: Float = 0
            if tmpOperator == "x" {
                tmpResult = Float(tmpOperande1! * tmpOperande2!)
                // print("mult: \(tmpResult)")
            } else {
                tmpResult = Float(tmpOperande1! / tmpOperande2!)
                // print("div: \(tmpResult)")
            }
//            print("\(tmpOperande1!)\(tmpOperator)\(tmpOperande2!) => \(tmpResult)")
            // print("Result =\(tmpResult)")
            tmpOperators.remove(at: indexTmpOperator!)
            
            tmpStringNumbers[indexTmpOperator! - 1] = "\(tmpResult)"
            tmpStringNumbers.remove(at: indexTmpOperator!)
            // print("opération après reduction)\(tmpOperators)")
//            print("nombres et opérateurs reduit : ")
//            print(tmpStringNumbers)
//            print(tmpOperators)
            stringNumbers = tmpStringNumbers
            operators = tmpOperators
        }
    }
    
    fileprivate func reduceSquare() {
        var tmpNumbersToSquare = stringNumbers
        var firstSquareIndex = tmpNumbersToSquare.firstIndex { $0.contains("²")}
        print("firstSquareIndex \(String(describing: firstSquareIndex))")
        while firstSquareIndex != nil {
            let tmpSquaredNumber = powf(Float(tmpNumbersToSquare[firstSquareIndex!].dropLast(1))!, 2)
            print("tmpNumbersToSquare avant \(tmpNumbersToSquare)")
            tmpNumbersToSquare[firstSquareIndex!] = "\(tmpSquaredNumber)"
            print("tmpNumbersToSquare après \(tmpNumbersToSquare)")
            firstSquareIndex = tmpNumbersToSquare.firstIndex { $0.contains("²")}
        }
        stringNumbers = tmpNumbersToSquare
        print("stringNumbers reduceSquare \(stringNumbers)")
    }
    
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
    }
    
}
