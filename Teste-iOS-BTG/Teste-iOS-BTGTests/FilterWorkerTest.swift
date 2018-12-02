//
//  FilterWorkerTest.swift
//  Teste-iOS-BTGTests
//
//  Created by Julio Brazil on 01/12/18.
//  Copyright © 2018 BTG Pactual. All rights reserved.
//

import XCTest
@testable import Teste_iOS_BTG

class FilterWorkerTest: XCTestCase {
    var worker: FilterWorker!
    var filter: FundFilterOptions!
    var funds: [CodableFund]!

    override func setUp() {
        super.setUp()
        
        self.worker = FilterWorker()
        self.funds = [
            CodableFund.createFundForFilterTest(id: 1, name: "abc", risk: .conservador, category: .rendaFixa, minimumInvestiment: 10.0, rescueInterval: .interval0),
            CodableFund.createFundForFilterTest(id: 2, name: "bcd", risk: .conservador, category: .multimercados, minimumInvestiment: 100.0, rescueInterval: .interval1),
            CodableFund.createFundForFilterTest(id: 3, name: "cde", risk: .moderado, category: .cambial, minimumInvestiment: 1_000.0, rescueInterval: .interval2),
            CodableFund.createFundForFilterTest(id: 4, name: "def", risk: .moderado, category: .acoes, minimumInvestiment: 10_000.0, rescueInterval: .interval2),
            CodableFund.createFundForFilterTest(id: 5, name: "efg", risk: .sofisticado, category: .rendaFixa, minimumInvestiment: 100_000.0, rescueInterval: .interval3),
            CodableFund.createFundForFilterTest(id: 6, name: "fgh", risk: .sofisticado, category: .multimercados, minimumInvestiment: 250_000.0, rescueInterval: .interval3)
        ]
    }

    override func tearDown() {
        self.worker = nil
        self.filter = nil
        self.funds = nil
        
        super.tearDown()
    }
    
    func testFilterByRisk() {
        // test risk level "conservador"
        self.filter = FundFilterOptions(risk: [RiskLevel.conservador], category: nil, minimumApplication: nil, rescueInterval: nil)
        
        var filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 2)
        XCTAssertEqual(filtered[0].id, 1)
        XCTAssertEqual(filtered[1].id, 2)
        
        // test risk level "moderado"
        self.filter = FundFilterOptions(risk: [RiskLevel.moderado], category: nil, minimumApplication: nil, rescueInterval: nil)
        
        filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 2)
        XCTAssertEqual(filtered[0].id, 3)
        XCTAssertEqual(filtered[1].id, 4)
        
        // test risk level "sofisticado"
        self.filter = FundFilterOptions(risk: [RiskLevel.sofisticado], category: nil, minimumApplication: nil, rescueInterval: nil)
        
        filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 2)
        XCTAssertEqual(filtered[0].id, 5)
        XCTAssertEqual(filtered[1].id, 6)
        
        // test risk level "conservador" and "moderado"
        self.filter = FundFilterOptions(risk: [RiskLevel.conservador, RiskLevel.moderado], category: nil, minimumApplication: nil, rescueInterval: nil)
        
        filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 4)
        XCTAssertEqual(filtered[0].id, 1)
        XCTAssertEqual(filtered[1].id, 2)
        XCTAssertEqual(filtered[2].id, 3)
        XCTAssertEqual(filtered[3].id, 4)
        
        // test risk level "conservador" and "sofisticado"
        self.filter = FundFilterOptions(risk: [RiskLevel.conservador, RiskLevel.sofisticado], category: nil, minimumApplication: nil, rescueInterval: nil)
        
        filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 4)
        XCTAssertEqual(filtered[0].id, 1)
        XCTAssertEqual(filtered[1].id, 2)
        XCTAssertEqual(filtered[2].id, 5)
        XCTAssertEqual(filtered[3].id, 6)
        
        // test risk level "moderado" and "sofisticado"
        self.filter = FundFilterOptions(risk: [RiskLevel.moderado, RiskLevel.sofisticado], category: nil, minimumApplication: nil, rescueInterval: nil)
        
        filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 4)
        XCTAssertEqual(filtered[0].id, 3)
        XCTAssertEqual(filtered[1].id, 4)
        XCTAssertEqual(filtered[2].id, 5)
        XCTAssertEqual(filtered[3].id, 6)
        
        // test every risk level
        self.filter = FundFilterOptions(risk: [RiskLevel.conservador, RiskLevel.moderado, RiskLevel.sofisticado], category: nil, minimumApplication: nil, rescueInterval: nil)
        
        filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 6)
        XCTAssertEqual(filtered[0].id, 1)
        XCTAssertEqual(filtered[1].id, 2)
        XCTAssertEqual(filtered[2].id, 3)
        XCTAssertEqual(filtered[3].id, 4)
        XCTAssertEqual(filtered[4].id, 5)
        XCTAssertEqual(filtered[5].id, 6)
    }
    
    func testFilterByCategory() {
        // test category "ações"
        self.filter = FundFilterOptions(risk: nil, category: FundCategory.acoes, minimumApplication: nil, rescueInterval: nil)
        
        var filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered[0].id, 4)
        
        // test category "cambial"
        self.filter = FundFilterOptions(risk: nil, category: FundCategory.cambial, minimumApplication: nil, rescueInterval: nil)
        
        filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered[0].id, 3)
        
        // test category "multimercados"
        self.filter = FundFilterOptions(risk: nil, category: FundCategory.multimercados, minimumApplication: nil, rescueInterval: nil)
        
        filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 2)
        XCTAssertEqual(filtered[0].id, 2)
        XCTAssertEqual(filtered[1].id, 6)
        
        // test category "renda fixa"
        self.filter = FundFilterOptions(risk: nil, category: FundCategory.rendaFixa, minimumApplication: nil, rescueInterval: nil)
        
        filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 2)
        XCTAssertEqual(filtered[0].id, 1)
        XCTAssertEqual(filtered[1].id, 5)
    }
    
    func testFilterByMinimumValue() {
        // test minimum value smaller or equal to "R$ 0,00"
        self.filter = FundFilterOptions(risk: nil, category: nil, minimumApplication: ApplicationInterval.upto0, rescueInterval: nil)
        
        var filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 0)
        
        // test minimum value smaller or equal to "R$ 100,00"
        self.filter = FundFilterOptions(risk: nil, category: nil, minimumApplication: ApplicationInterval.upto100, rescueInterval: nil)
        
        filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 2)
        XCTAssertEqual(filtered[0].id, 1)
        XCTAssertEqual(filtered[1].id, 2)
        
        // test minimum value smaller or equal to "R$ 250.000,00"
        self.filter = FundFilterOptions(risk: nil, category: nil, minimumApplication: ApplicationInterval.upto250k, rescueInterval: nil)
        
        filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, self.funds.count)
        XCTAssertEqual(filtered[0].id, 1)
        XCTAssertEqual(filtered[1].id, 2)
        XCTAssertEqual(filtered[2].id, 3)
        XCTAssertEqual(filtered[3].id, 4)
        XCTAssertEqual(filtered[4].id, 5)
        XCTAssertEqual(filtered[5].id, 6)
    }
    
    func testFilterByRescueInterval() {
        // test filter by rescue interval 0
        self.filter = FundFilterOptions(risk: nil, category: nil, minimumApplication: nil, rescueInterval: RescueInterval.interval0)
        
        var filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered[0].id, 1)
        
        // test filter by rescue interval 1
        self.filter = FundFilterOptions(risk: nil, category: nil, minimumApplication: nil, rescueInterval: RescueInterval.interval1)
        
        filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered[0].id, 2)
        
        // test filter by rescue interval 2
        self.filter = FundFilterOptions(risk: nil, category: nil, minimumApplication: nil, rescueInterval: RescueInterval.interval2)
        
        filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 2)
        XCTAssertEqual(filtered[0].id, 3)
        XCTAssertEqual(filtered[1].id, 4)
        
        // test filter by rescue interval 3
        self.filter = FundFilterOptions(risk: nil, category: nil, minimumApplication: nil, rescueInterval: RescueInterval.interval3)
        
        filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 2)
        XCTAssertEqual(filtered[0].id, 5)
        XCTAssertEqual(filtered[1].id, 6)
        
        // test filter by rescue interval 4
        self.filter = FundFilterOptions(risk: nil, category: nil, minimumApplication: nil, rescueInterval: RescueInterval.interval4)
        
        filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 0)
    }
    
    func testFilterByTwoFactors() {
        // test filter by risk and category
        self.filter = FundFilterOptions(risk: [RiskLevel.conservador], category: FundCategory.rendaFixa, minimumApplication: nil, rescueInterval: nil)
        
        var filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered[0].id, 1)
        
        // test filter by risk and minimum application value
        self.filter = FundFilterOptions(risk: [RiskLevel.moderado], category: nil, minimumApplication: ApplicationInterval.upto1k, rescueInterval: nil)
        
        filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered[0].id, 3)
        
        // test filter by risk and rescue interval
        self.filter = FundFilterOptions(risk: [RiskLevel.moderado], category: nil, minimumApplication: nil, rescueInterval: RescueInterval.interval0)
        
        filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 0)
        
        // test filter by category and minimum application value
        self.filter = FundFilterOptions(risk: nil, category: FundCategory.rendaFixa, minimumApplication: ApplicationInterval.upto10k, rescueInterval: nil)
        
        filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered[0].id, 1)
        
        // test filter by category and rescue interval
        self.filter = FundFilterOptions(risk: nil, category: FundCategory.cambial, minimumApplication: nil, rescueInterval: RescueInterval.interval1)
        
        filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 0)
        
        // test filter by minimum application value and rescue interval
        self.filter = FundFilterOptions(risk: nil, category: nil, minimumApplication: ApplicationInterval.upto1k, rescueInterval: RescueInterval.interval2)
        
        filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered[0].id, 3)
    }
    
    func testFilterByThreeFactors() {
        // test filter by risk, category and minimum application value
        self.filter = FundFilterOptions(risk: [RiskLevel.conservador], category: FundCategory.multimercados, minimumApplication: ApplicationInterval.upto25k, rescueInterval: nil)
        
        var filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered[0].id, 2)
        
        // test filter by risk, category and rescue interval
        self.filter = FundFilterOptions(risk: [RiskLevel.sofisticado], category: FundCategory.rendaFixa, minimumApplication: nil, rescueInterval: RescueInterval.interval0)
        
        filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 0)
        
        // test filter by risk, minimum application value and rescue interval
        self.filter = FundFilterOptions(risk: [RiskLevel.conservador], category: nil, minimumApplication: ApplicationInterval.upto3k, rescueInterval: RescueInterval.interval1)
        
        filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered[0].id, 2)
        
        // test filter by category, minimum application value and rescue interval
        self.filter = FundFilterOptions(risk: nil, category: FundCategory.rendaFixa, minimumApplication: ApplicationInterval.upto250k, rescueInterval: RescueInterval.interval3)
        
        filtered = self.worker.filterFunds(self.funds, by: self.filter)
        
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered[0].id, 5)
    }
    
    func testFilterByAllFactors() {
        self.filter = FundFilterOptions(risk: [RiskLevel.moderado], category: FundCategory.cambial, minimumApplication: ApplicationInterval.upto10k, rescueInterval: RescueInterval.interval2)
        
        var filtered = self.worker.filterFunds(self.funds, by: self.filter)
    
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered[0].id, 3)
    }
    
    func testFilterByText() {
        var filtered = self.worker.filterFunds(self.funds, byText: "a")
        
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered[0].id, 1)
        
        filtered = self.worker.filterFunds(self.funds, byText: "b")
        
        XCTAssertEqual(filtered.count, 2)
        XCTAssertEqual(filtered[0].id, 1)
        XCTAssertEqual(filtered[1].id, 2)
        
        filtered = self.worker.filterFunds(self.funds, byText: "bc")
        
        XCTAssertEqual(filtered.count, 2)
        XCTAssertEqual(filtered[0].id, 1)
        XCTAssertEqual(filtered[1].id, 2)
        
        filtered = self.worker.filterFunds(self.funds, byText: "bcd")
        
        XCTAssertEqual(filtered.count, 1)
        XCTAssertEqual(filtered[0].id, 2)
        
        filtered = self.worker.filterFunds(self.funds, byText: "bcde")
        
        XCTAssertEqual(filtered.count, 0)
    }
}
