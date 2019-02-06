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
    var isExpressionCorrect: Bool { return checkExpression() }  // vérif quand = cliqué
    var canAddOperator: Bool { return checkOperator() } // vérif quand opérateur cliqué
    // let point = "."
    
    // MARK: - Action
    @IBAction func resetCalculation() {
        textView.text = ""
 //       print("resetCalulation")
        calculator.stringNumbers = [String()]
    }
// action si un bouton de chiffre est cliqué
    @IBAction func tappedNumberButton(_ sender: UIButton) {
//        print(numberButtons.count)
        
            for (i, numberButton) in numberButtons.enumerated() {
                if sender == numberButton {
     //               print("indice i = \(i)")
                    calculator.addNumber(i)
                    updateDisplay()
                }
            }
            
        
//        print("tag du bouton : \(sender.tag)")
    }
 // action si un bouton opérateur est cliqué + -titleLabel
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        print("operateur \(String(describing: sender.titleLabel!.text))")
        if isExpressionCorrect {
            if canAddOperator {
                print("canAddOperator")
                calculator.addOperator(sender.titleLabel!.text ?? "")
            }
        updateDisplay()
        }
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
    
// ajout des nombres décimaux
    @IBAction func tappedPointButton(_ sender: UIButton) {
        print("bouton point")
        calculator.addPoint()
        updateDisplay()
    }
    
    // carré
    @IBAction func tappedSquareButton(_ sender: UIButton) {
        print("bouton square")
        calculator.addSquare()
        updateDisplay()
    }
// choix d'une opération unitaire factorielle ou carré
//    @IBAction func unaryOperationsChoosen(_ sender: UIButton) {
//        print("bouton X! ou x²")
//        let unitaryOperation = sender.titleLabel!.text
//        if unitaryOperation == "x!" {
//            calculator.factorial()
//        } else {
//            calculator.square()
//        }
//    }
    
    // renvoie si l'expression est correct ou pas
// isExpressionCorrect
    fileprivate func checkExpression() -> Bool {
        print("checkExpression")
        if let stringNumber = calculator.stringNumbers.last {
            if stringNumber.isEmpty {
                if calculator.stringNumbers.count == 1 {
                    let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertVC, animated: true, completion: nil)
                } else {
//                    if calculator.operators.last != "!" && calculator.operators.last != "²"{
                        print("calculator.operators.last: \(String(describing: calculator.operators.last))")
                        let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
                        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alertVC, animated: true, completion: nil)
//                    }

                }
                return false
            } else { // non vide et division par zéro
                print("Division par zéro ?")
                if stringNumber == "0" && calculator.operators.last == "÷" {
                    print ("Divide by zero")
                    let alertVC = UIAlertController(title: "Erreur !", message: "Division par zéro impossible !", preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertVC, animated: true, completion: nil)
                    return false
                }
//                if calculator.operators.last == "!" {
//                    print ("facto CheckExpression")
//                }
//                if calculator.operators.last == "²" {
//                    print ("square CheckExpression")
//                }
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
