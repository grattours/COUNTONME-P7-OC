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
}
