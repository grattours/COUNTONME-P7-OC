//
//  CalulatorTests.swift
//  CalulatorTests
//
//  Created by Luc Derosne on 02/02/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalulatorTests: XCTestCase {
    var calculator = Calculator()
    
    override func setUp() {
        calculator = Calculator()
    }
    
    func testGivenFirstNumberIsSeven_WhenAdditionningWithNumberEight_ThenTotalIsFiveTeen() {
        calculator.addNumber(7)
        
        calculator.addOperator("+")
        calculator.addNumber(8)
        
        XCTAssertEqual(calculator.calculateTotal(), 15)
    }
    
    func testGivenFirstNumberIsTwelve_WhenSubstractingWithNumberNine_ThenTotalIsThree() {
        calculator.addNumber(12)
        
        calculator.addOperator("-")
        calculator.addNumber(9)
        
        XCTAssertEqual(calculator.calculateTotal(), 3)
    }
    
    func testGivenFirstNumberIsTwelve_WhenMutliplyingWithNumberTwo_ThenTotalIsTwentyFour() {
        calculator.addNumber(12)
        
        calculator.addOperator("x")
        calculator.addNumber(2)
        
        XCTAssertEqual(calculator.getTotal(), "24")
    }
    
    func testGivenFirstNumberIsFivetenn_WhenDividingWithNumberThree_ThenTotalIsFive() {
        calculator.addNumber(15)
        
        calculator.addOperator("÷")
        calculator.addNumber(3)
        
        XCTAssertEqual(calculator.getTotal(), "5")
    }
    
    func testGivenNumberIsFive_WhenFactoring_ThenTotalIs120() {
        calculator.addNumber(5)
        
        calculator.addFactorial()
        
        XCTAssertEqual(calculator.factorial(a: 5), 120)
        XCTAssertEqual(calculator.getTotal(), "120")
    }
    
    func testGivenNumberIsZero_WhenFactoring_ThenTotalIsOne() {
        calculator.addNumber(0)
        
        calculator.addFactorial()
        
        XCTAssertEqual(calculator.factorial(a: 0), 1)
        XCTAssertEqual(calculator.getTotal(), "1")
    }
    
    func testGivenNumberIsOne_WhenFactoring_ThenTotalIsOne() {
        calculator.addNumber(1)
        
        calculator.addFactorial()
        
        XCTAssertEqual(calculator.factorial(a: 1), 1)
        XCTAssertEqual(calculator.getTotal(), "1")
    }
    
    func testGivenNumberIsSix_WhenSquaring_ThenTotalIs36() {
        calculator.addNumber(6)
        
        calculator.addSquare()
        
        XCTAssertEqual(calculator.getTotal(), "36")
    }
    
    func testGivenExpressionEnded_CalculatingTotal_ThenExpressionIsCleared() {
        calculator.addNumber(12)
        calculator.addOperator("-")
        calculator.addNumber(9)
        calculator.addOperator("+")
        calculator.addNumber(6)
        calculator.addOperator("-")
        calculator.addNumber(4)
        calculator.addOperator("+")
        calculator.addNumber(10)
        
        let total = calculator.calculateTotal()
        
        XCTAssertEqual(total, 15)
        XCTAssertEqual(calculator.stringNumbers.last, "")
        XCTAssertEqual(calculator.stringNumbers.count, 1)
        XCTAssertEqual(calculator.operators.count, 1)
        

    }
    
    func testGivenActionEqual_GettingTotal_ThenExpressionIsTotalString() {
        calculator.addNumber(16)
        calculator.addOperator("+")
        calculator.addNumber(8)
        calculator.addOperator("-")
        calculator.addNumber(9)
        
        let result = calculator.getTotal()
        
        XCTAssertEqual(result, "15")
    }
    
    func testGivenExpressionIsEnded_WhenDisplayingExpression_ThenDisplayIsTheExpression() {
        calculator.addNumber(34)
        calculator.addOperator("+")
        calculator.addNumber(12)
        calculator.addOperator("-")
        calculator.addNumber(15)
        calculator.addOperator("+")
        calculator.addNumber(7)
        
        XCTAssertEqual(calculator.getTextToDisplay(), "34+12-15+7")
    }
    
    func testGivenExpressionWijtPointIsEnded_WhenDisplayingExpression_ThenDisplayIsTheExpression() {
        calculator.addNumber(8)
        calculator.addPoint()
        calculator.addNumber(3)
        calculator.addOperator("+")
        calculator.addNumber(1)
        calculator.addPoint()
        calculator.addNumber(9)
        
        XCTAssertEqual(calculator.getTextToDisplay(), "8.3+1.9")
        
        let result = calculator.getTotal()
        XCTAssertEqual(result, "10.2")
        
    }
    
}
