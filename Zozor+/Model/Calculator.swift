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
    var isExpressionCorrect: Bool { return checkExpression() }  // check when = clicked
    
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
    
// concatenate numbers to make multi-digit
    func addNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
    }
// Add operator to operator array
    func addOperator(_ newOperator: String) {
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
        resetCalculation()
        return total
    }
    
    // format and calculate the total
    func getTotal() -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        reduceExpression()
        let totaln = calculateTotal()
        guard let total = formatter.string(from: NSNumber(value: totaln)) else { return "0" }
        return total
    }
    
    // priorities we reduce the expression by replacing the operations X and /
    // from the left. replace the result in the number table
    // and remove the operators / and * from the tmpOperator array
    func reduceExpression() {
        // opération  *  et X
        var tmpStringNumbers = stringNumbers
        var tmpOperators = operators
        while tmpOperators.contains("x") || tmpOperators.contains("÷") {
            if let indexTmpOperator = tmpOperators.firstIndex (where: { $0 == "x" || $0 == "÷"}) {
                let tmpOperator = tmpOperators[indexTmpOperator]
                guard let tmpOperande1 = Float(tmpStringNumbers[indexTmpOperator - 1]) else { return }
                guard let tmpOperande2 = Float(tmpStringNumbers[indexTmpOperator]) else { return }
                var tmpResult: Float = 0
                if tmpOperator == "x" {
                    tmpResult = Float(tmpOperande1 * tmpOperande2)
                } else {
                    tmpResult = Float(tmpOperande1 / tmpOperande2)
                }
                tmpOperators.remove(at: indexTmpOperator)

                tmpStringNumbers[indexTmpOperator - 1] = "\(tmpResult)"
                tmpStringNumbers.remove(at: indexTmpOperator)
                stringNumbers = tmpStringNumbers
                operators = tmpOperators
            }

        }
    }

    
    // var isExpressionCorrect - it's written on it as the Port Salut
    func checkExpression() -> Bool {
        var notif = ""
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty { // not begin with an operator
                if stringNumbers.count == 1 {
                    notif = "StartWithNewCalculation"
                    sendNotification(notif)
                } else {
                    notif = "EnterCorrectExpression"
                     sendNotification(notif)
                }
                return false
            } else { // non-empty and division by zero
                if Float(stringNumber) == 0 && operators.last == "÷" {
                    notif = "Nodivisionbyzero"
                    sendNotification(notif)
                    resetCalculation()
                    return false
                }
            }
        }
        return true
    }
    
 
    // clear no ?
    func resetCalculation() {
        stringNumbers = [String()]
        operators = ["+"]
    }
    
    // send notification from model to controller
    func sendNotification( _ notif: String){
        let name = Notification.Name(rawValue: "\(notif)")
        let notification = Notification(name: name)
        NotificationCenter.default.post(notification)
    }
    
}
