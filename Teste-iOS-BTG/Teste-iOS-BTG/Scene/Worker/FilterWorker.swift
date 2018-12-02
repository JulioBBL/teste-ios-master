//
//  FilterWorker.swift
//  Teste-iOS-BTG
//
//  Created by Julio Brazil on 01/12/18.
//  Copyright © 2018 BTG Pactual. All rights reserved.
//

import Foundation

public class FilterWorker {
    
    /// Filters funds according to the definitions privided.
    ///
    /// - Parameters:
    ///   - funds: array of CodableFund to be filtered.
    ///   - filter: definitions after which the funds will be filtered.
    /// - Returns: a CodableFund array comprised only of funds that comply to the options provided.
    func filterFunds(_ funds: [CodableFund], by filter: FundFilterOptions) -> [CodableFund] {
        var filteredFunds = funds
        
        if let risk = filter.risk {
            filteredFunds = filteredFunds.filter({ (fund) -> Bool in
                guard let fundRisk = RiskLevel(rawValue: fund.riskName) else {return false}
                return risk.contains(fundRisk)
            })
        }
        
        if let category = filter.category {
            filteredFunds = filteredFunds.filter({ (fund) -> Bool in
                return fund.detail.categoryDescription == category.rawValue
            })
        }
        
        if let minimumApplicationValue = filter.minimumApplication {
            filteredFunds = filteredFunds.filter({ (fund) -> Bool in
                return fund.minimumInitialInvestment <= minimumApplicationValue.rawValue
            })
        }
        
        if let rescueInterval = filter.rescueInterval {
            filteredFunds = filteredFunds.filter({ (fund) -> Bool in
                return fund.detail.rescueQuota == rescueInterval.rawValue
            })
        }
        
        return filteredFunds
    }
    
    /// Filter funds by the text comprised in it's name
    ///
    /// - Parameters:
    ///   - funds: array of CodableFund to be filtered.
    ///   - text: text that must be present on the fund's name.
    /// - Returns: a CodableFund array comprised only of funds that have the specified text in the name.
    func filterFunds(_ funds: [CodableFund], byText text: String) -> [CodableFund] {
        return funds.filter({ (fund) -> Bool in
            return fund.name.contains(text)
        })
    }
}
