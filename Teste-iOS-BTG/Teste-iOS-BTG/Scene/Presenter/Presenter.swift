//
//  Presenter.swift
//  Teste-iOS-BTG
//
//  Created by Julio Brazil on 02/12/18.
//  Copyright © 2018 BTG Pactual. All rights reserved.
//

import UIKit

public class Presenter {
    weak var viewController: FundTableViewController?
    
    func present(_ funds: [CodableFund]) {
        guard let viewController = self.viewController else { return }
        
        let formattedFunds = funds.map { (fund) -> FormattedFund in
            return FormattedFund(from: fund)
        }
        
        viewController.funds = formattedFunds
    }
    
    func presentError(_ errorDescription: String) {
        viewController?.errorMessage = errorDescription
    }
}
