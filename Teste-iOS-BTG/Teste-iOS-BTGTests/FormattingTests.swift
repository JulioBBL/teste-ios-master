//
//  Teste_iOS_BTGTests.swift
//  Teste-iOS-BTGTests
//
//  Created by BTG Pactual digital on 30/11/18.
//  Copyright © 2018 BTG Pactual. All rights reserved.
//

import XCTest
@testable import Teste_iOS_BTG

class FormattingTests: XCTestCase {
    
    func testDateFormatting() {
        var output = ""
        
        output = FormattedFund.formatted(date: "2018-12-30T00:00:00.000-0000")
        XCTAssertEqual(output, "30/12/2018")
        
        output = FormattedFund.formatted(date: "1995-10-14T00:00:00.000-0000")
        XCTAssertEqual(output, "14/10/1995")
    }
    
    func testMoneyFormatting() {
        var output = ""
        
        output = FormattedFund.formatted(money: 1_000)
        XCTAssertEqual(output, "1.000,00")
        
        output = FormattedFund.formatted(money: 0.0)
        XCTAssertEqual(output, "0,00")
    }
    
    func testPercentileFormatting() {
        var output = ""
        
        output = FormattedFund.formatted(percentile: 0.0)
        XCTAssertEqual(output, "!")
        
        output = FormattedFund.formatted(percentile: 0.1)
        XCTAssertEqual(output, "0,1%")
        
        output = FormattedFund.formatted(percentile: 0.01)
        XCTAssertEqual(output, "0,01%")
        
        output = FormattedFund.formatted(percentile: 0.001)
        XCTAssertEqual(output, "0%")
        
        output = FormattedFund.formatted(percentile: 1.0)
        XCTAssertEqual(output, "1%")
    }
    
    func testFormattedFundColor() {
        var formattedFund = FormattedFund(from: CodableFund.createFundForFilterTest(id: 0, name: "", risk: .conservador, category: .acoes, minimumInvestiment: 0.0, rescueInterval: .interval0))
        XCTAssertEqual(formattedFund.riskColor, .btg_blue)
        
        formattedFund = FormattedFund(from: CodableFund.createFundForFilterTest(id: 0, name: "", risk: .moderado, category: .acoes, minimumInvestiment: 0.0, rescueInterval: .interval0))
        XCTAssertEqual(formattedFund.riskColor, .btg_orange)
        
        formattedFund = FormattedFund(from: CodableFund.createFundForFilterTest(id: 0, name: "", risk: .sofisticado, category: .acoes, minimumInvestiment: 0.0, rescueInterval: .interval0))
        XCTAssertEqual(formattedFund.riskColor, .btg_red)
    }

}
