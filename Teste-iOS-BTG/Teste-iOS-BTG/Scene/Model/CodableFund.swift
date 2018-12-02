//
//  Fundo.swift
//  Teste-iOS-BTG
//
//  Created by Julio Brazil on 01/12/18.
//  Copyright © 2018 BTG Pactual. All rights reserved.
//

import Foundation

struct CodableFund: Codable {
    struct Profitability: Codable {
        var month: Double
        var year: Double?
        var twelveMonths: Double?
    }
    
    struct FundDetails: Codable {
        var valueQuota: Double
        var rescueQuota: String
        var dateQuota: String
    }
    
    var product: String
    var minimumInitialInvestment: Double
    var riskLevel: Int
    var netEquity: Double
    var begin: String
    var profitability: Profitability
    var detail: FundDetails
}
