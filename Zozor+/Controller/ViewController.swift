//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//  conversion Swift 4.2 de l'original puis Swift5

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
    var isNumberPositveInteger: Bool { return checkPositiveInteger() }
    
    // MARK: - Action
    @IBAction func resetCalculation() {
        textView.text = ""
        calculator.stringNumbers = [String()]
    }
// action si un bouton de chiffre est cliqué
    @IBAction func tappedNumberButton(_ sender: UIButton) {
            for (i, numberButton) in numberButtons.enumerated() {
                if sender == numberButton {
                    calculator.addNumber(i)
                    updateDisplay()
                }
            }
    }
 // action si un bouton opérateur est cliqué + -titleLabel
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        if isExpressionCorrect {
            if canAddOperator {
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
        }
    }
    
// ajout des nombres décimaux
    @IBAction func tappedPointButton(_ sender: UIButton) {
        calculator.addPoint()
        updateDisplay()
    }
    
    // carré
    @IBAction func tappedSquareButton(_ sender: UIButton) {
            calculator.addSquare()
            updateDisplay()
    }
    // Factoriel
    @IBAction func tappedFactorialButton(_ sender: UIButton) {
        if isNumberPositveInteger {
            calculator.addFactorial()
            updateDisplay()
        } else {
            let alertVC = UIAlertController(title: "Incorrect", message: "Factoriel - entier positif seulement", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }

    }

    // pour les factorielles, entier possitif demandé sinon alerte
    func checkPositiveInteger() -> Bool {
         if let stringNumber = calculator.stringNumbers.last {
            let numberFact = Float(stringNumber)
            if floorf(numberFact!) != numberFact || ((numberFact?.isLessThanOrEqualTo(0))!) {
                return false
            }
        }
        return true
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
//                    }

                }
                return false
            } else { // non vide et division par zéro
                if stringNumber == "0" && calculator.operators.last == "÷" {
                    let alertVC = UIAlertController(title: "Erreur !", message: "Division par zéro impossible !", preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertVC, animated: true, completion: nil)
                    return false
                }
            }
        }
        return true
    }
 
    // valide si operateur est OK
    fileprivate func checkOperator() -> Bool {
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
    
    // affiche l'expression
    func updateDisplay() {
        textView.text = calculator.getTextToDisplay()
    }

}
