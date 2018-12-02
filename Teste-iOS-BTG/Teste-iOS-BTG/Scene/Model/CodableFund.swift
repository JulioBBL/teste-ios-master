//
//  Fundo.swift
//  Teste-iOS-BTG
//
//  Created by Julio Brazil on 01/12/18.
//  Copyright © 2018 BTG Pactual. All rights reserved.
//

import Foundation

struct CodableFund: Codable, Equatable {
    
    struct Profitability: Codable {
        var month: Double
        var year: Double?
        var twelveMonths: Double?
    }
    
    struct FundDetails: Codable {
        var valueQuota: Double
        var rescueQuota: String
        var dateQuota: String
        var categoryDescription: String
    }
    
    var id: Int
    var name: String
    var minimumInitialInvestment: Double
    var riskName: String
    var netEquity: Double
    var beginDate: String
    var profitability: Profitability
    var detail: FundDetails
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "product"
        case minimumInitialInvestment
        case riskName
        case netEquity
        case beginDate = "begin"
        case profitability
        case detail
    }
    
    public static func createFundForFilterTest(id: Int, name: String, risk: RiskLevel, category: FundCategory, minimumInvestiment: Double, rescueInterval: RescueInterval) -> CodableFund {
        return CodableFund(id: id, name: name, minimumInitialInvestment: minimumInvestiment, riskName: risk.rawValue, netEquity: 0.0, beginDate: "", profitability: CodableFund.Profitability(month: 0.0, year: 0.0, twelveMonths: 0.0), detail: CodableFund.FundDetails(valueQuota: 0.0, rescueQuota: rescueInterval.rawValue, dateQuota: "", categoryDescription: category.rawValue))
    }
    
    static func == (lhs: CodableFund, rhs: CodableFund) -> Bool {
        return lhs.id == rhs.id
    }
    
}
