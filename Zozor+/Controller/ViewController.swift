//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//  conversion Swift 4.2 de l'original puis Swift5

import UIKit
import AVFoundation

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var operatorsButtons: UIButton!
    
    // MARK: - Properties
    let calculator = Calculator()
    var isExpressionCorrect: Bool { return checkExpression() }  // check when = clicked
    var canAddOperator: Bool { return checkOperator() } // check when operator clicked
    var isNumberPositveInteger: Bool { return checkPositiveInteger() }
    var isLastOperatorUnitary: Bool { return checkLasOperatorUnitary()}
    var canAddNumber: Bool { return checkNumber() } // check when number cliked
    
    // MARK: - Action
    @IBAction func resetCalculation() {
        textView.text = ""
        calculator.stringNumbers = [String()]
    }
    // action if a number button is clicked
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        if  canAddNumber {
            for (i, numberButton) in numberButtons.enumerated() {
                if sender == numberButton {
                    calculator.addNumber(i)
                    updateDisplay()
                }
            }
        } else {
             presentAlert("Erreur","Entrez un opérateur binaire ! ")
        }
    }
    
    // action if an operator button is clicked + -titleLabel
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        if isExpressionCorrect {
            if canAddOperator {
                calculator.addOperator(sender.titleLabel!.text ?? "")
            }
        updateDisplay()
        }
    }
    
    // action if the = sign is selected
    @IBAction func equal() {
        if isExpressionCorrect {
            let total = calculator.getTotal()
            //print(total)
            textView.text = textView.text + "=\(total)"
        }
    }
    
    // adding decimals
    @IBAction func tappedPointButton(_ sender: UIButton) {
        calculator.addPoint()
        updateDisplay()
    }
    
    // carré
    @IBAction func tappedSquareButton(_ sender: UIButton) {
        if isExpressionCorrect && !isLastOperatorUnitary {
            calculator.addSquare()
            updateDisplay()
        } else {
            presentAlert("erreur opérateur","pas deux fois un même opérteur !")
        }
    }
    // Factoriel
    @IBAction func tappedFactorialButton(_ sender: UIButton) {
        if isExpressionCorrect && !isLastOperatorUnitary {
            if isNumberPositveInteger {
                calculator.addFactorial()
                updateDisplay()
            } else {
            }
        } else {
            presentAlert("pas après la factorielle", "essayer autre chose !")

                }
        
    }

    @IBAction func speechBtn(_ sender: UIButton) {
        var lang: String = "fr-FR"
        lang = "fr-FR"
        self.readMe(myText: textView.text! , myLang: lang)
    }

    // for factorials, positive integer otherwise required
    func checkPositiveInteger() -> Bool {
         if let stringNumber = calculator.stringNumbers.last {
            let numberFact = Float(stringNumber)
            if floorf(numberFact!) != numberFact || ((numberFact?.isLessThanOrEqualTo(0))!) {
                return false
            }
        }
        return true
    }
  
//    func checkLasOperatorUnitary() -> Bool {
//        if let stringNumber = calculator.stringNumbers.last {
//            if stringNumber.last == "²" || stringNumber.last == "!" {
//                return false
//            }
//        }
//        return true
//    }
    func checkLasOperatorUnitary() -> Bool {
        if let stringNumber = calculator.stringNumbers.last {
            if stringNumber.last == "²" || stringNumber.last == "!" {
                return true
            } else {
                return  false
            }
        }
        return true
    }
// returns if the expression is correct or not
// isExpressionCorrect
    fileprivate func checkExpression() -> Bool {
        if let stringNumber = calculator.stringNumbers.last {
            if stringNumber.isEmpty {
                if calculator.stringNumbers.count == 1 {
                    presentAlert("pas possible!", "Démarrez un nouveau calcul !")
                } else {
                    presentAlert(" Pas bon !", "Entrez une expression correcte !")
                }
                return false
            } else { // non-empty and division by zero
                if stringNumber == "0" && calculator.operators.last == "÷" {
                    presentAlert("Erreur !", " Division par zéro impossible !")
                    return false
                }
            }
        }
        return true
    }
 
    // valid if operator is OK as input
    fileprivate func checkOperator() -> Bool {
        if let stringNumber = calculator.stringNumbers.last {
            if stringNumber.isEmpty {
                presentAlert("Non non !","Expression incorrecte ! ")
                return false
            }
        }
        return true
    }
    
    // valid if number  is OK as input
    fileprivate func checkNumber() -> Bool {
        print("checkNumber")
        print(calculator.stringNumbers.last!)
        print(isLastOperatorUnitary)
        if !isLastOperatorUnitary {
            return true
        } else {
            return false
    //        presentAlert("Erreur","Entrez un opérateur binaire ! ")
        }
//        if let stringNumber = calculator.stringNumbers.last {
//            if stringNumber.isEmpty {
//                presentAlert("Non non !","Expression incorrecte ! ")
//                return false
//            }
//        }
        //return true
    }
    
    
    // show the expression
    func updateDisplay() {
        textView.text = calculator.getTextToDisplay()
        //print(textView.text!)
    }
    
    func readMe( myText: String , myLang : String) {
        let utterance = AVSpeechUtterance(string: myText )
        utterance.voice = AVSpeechSynthesisVoice(language: myLang)
        utterance.rate = 0.5
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    private func presentAlert(_ title: String, _ message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
}
