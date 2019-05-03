//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//  Reprise de l'app. Luc Derosne P7
//  conversion Swift 4.2 de l'original puis Swift5

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var operatorsButtons: UIButton!
    
    let calculator = Calculator()

    // when the view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        setObservatoryNotifications()
    }
    
    @IBAction func resetButton() {
        textView.text = ""
        calculator.resetCalculation()
    }
    // action if a number button is clicked
    @IBAction func tappedNumberButton(_ sender: UIButton) {
            for (i, numberButton) in numberButtons.enumerated() {
                if sender == numberButton {
                    calculator.addNumber(i)
                    updateDisplay()
                }
            }
    }
    // action if an operator button is clicked + -titleLabel
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        guard let operat = sender.titleLabel?.text else { return }
        if calculator.isExpressionCorrect {
                calculator.addOperator(operat)
        updateDisplay()
        }
    }
    // action if the = sign is selected
    @IBAction func equal() {
        if calculator.isExpressionCorrect {
            let total = calculator.getTotal()
            textView.text = textView.text + "=\(total)"
        }
    }

    // show the expression
    func updateDisplay() {
        textView.text = calculator.getTextToDisplay()
    }
    
    // Observatory of notifications for alerts    
    func setObservatoryNotifications() {
        // listen to notifications
        let errorNotif01 = Notification.Name(rawValue: "StartWithNewCalculation")
        NotificationCenter.default.addObserver(self, selector: #selector(AlertFromNotif(_:)), name: errorNotif01, object: nil)
        let errorNotif02 = Notification.Name(rawValue: "EnterCorrectExpression")
        NotificationCenter.default.addObserver(self, selector: #selector(AlertFromNotif(_:)), name: errorNotif02, object: nil)
        let errorNotif03 = Notification.Name(rawValue: "Nodivisionbyzero")
        NotificationCenter.default.addObserver(self, selector: #selector(AlertFromNotif(_:)), name: errorNotif03, object: nil)
    }

    // same alerte with title and message as parameter
    func presentAlert(_ message: String) {
        let alertVC = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    @objc func AlertFromNotif(_ notif:Notification)  {
        let row = notif.name.rawValue
        switch row {
        case "StartWithNewCalculation":
            presentAlert("Commencez un nouveau calcul")
        case "EnterCorrectExpression":
            presentAlert("Entrez une expression correcte")
        case "Nodivisionbyzero":
            presentAlert("Pas de division par zéro")
        default:
            break
        }
    }
    
}


