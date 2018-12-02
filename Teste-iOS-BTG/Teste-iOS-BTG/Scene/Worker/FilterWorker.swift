//
//  FilterWorker.swift
//  Teste-iOS-BTG
//
//  Created by Julio Brazil on 01/12/18.
//  Copyright © 2018 BTG Pactual. All rights reserved.
//

import Foundation

public class FilterWorker {
    func filterFunds(_ funds: [CodableFund], by filter: FundFilterOptions) -> [CodableFund] {
        var filteredFunds = funds
        
        if let risk = filter.risk {
            filteredFunds = filteredFunds.filter({ (fund) -> Bool in
                return fund.riskName == risk.rawValue
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
    
    func filterFunds(_ funds: [CodableFund], byText text: String) -> [CodableFund] {
        return funds.filter({ (fund) -> Bool in
            return fund.name.contains(text)
        })
    }
}
