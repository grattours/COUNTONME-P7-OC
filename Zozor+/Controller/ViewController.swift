//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//  conversion Swift 4.2
//  conversion Swift 5
// 

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var operatorsButtons: UIButton!
    
    // MARK: - Properties
    let calculator = Calculator()
    var isExpressionCorrect: Bool { return checkExpression() }
    var canAddOperator: Bool { return checkOperator() }

    // MARK: - Action
    @IBAction func resetCalculation() {
        textView.text = ""
        print("resetCalulation")
        calculator.stringNumbers = [String()]
    }
// action si un bouton de chiffre est cliqué
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        print(numberButtons.count)
        for (i, numberButton) in numberButtons.enumerated() {
            if sender == numberButton {
                print("indice i = \(i)")
                calculator.addNumber(i)
                updateDisplay()
            }
        }
        print("tag du bouton : \(sender.tag)")
    }
 // action si un bouton opérateur est cliqué + -
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        if canAddOperator {
           print("can add")
//            calculator.operators.append(sender.titleLabel!.text ?? "")
//            calculator.stringNumbers.append("")
            calculator.addOperator(sender.titleLabel!.text ?? "")
        }
        updateDisplay()
    }
// action si le signe = est sélectionné
    @IBAction func equal() {
        if isExpressionCorrect {
            let total = calculator.getTotal()
            textView.text = textView.text + "=\(total)"
//        let total = calculator.getTotal()
//        textView.text = textView.text + "=\(total)"
        }
    }
// renvoie si l'expression est correct ou pas
// isExpressionCorrect
    fileprivate func checkExpression() -> Bool {
        if let stringNumber = calculator.stringNumbers.last {
            if stringNumber.isEmpty {
                if calculator.stringNumbers.count == 1 {
                    let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertVC, animated: true, completion: nil)
                } else {
                    let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertVC, animated: true, completion: nil)
                }
                return false
            }
        }
        return true
    }
   
    fileprivate func checkOperator() -> Bool {
        print("checkOperator")
        if let stringNumber = calculator.stringNumbers.last {
            if stringNumber.isEmpty {
                let alertVC = UIAlertController(title: "Zéro!", message: "Expression incorrecte !", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
                return false
            }
        }
        return true
    }
    
    func updateDisplay() {
        textView.text = calculator.getTextToDisplay()
    }

}
