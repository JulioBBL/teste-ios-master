//
//  FormattedFund.swift
//  Teste-iOS-BTG
//
//  Created by Julio Brazil on 03/12/18.
//  Copyright © 2018 BTG Pactual. All rights reserved.
//

import UIKit

public class FormattedFund {
    var id: Int
    var name: String
    var minimumInvestiment: String
    var riskColor: UIColor
    var netEquity: String
    var beginDate: String
    var month: String
    var year: String
    var twelveMonths: String
    var rescueInterval: String
    var category: String
    
    public static func formatted(money value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter.string(from: value as NSNumber) ?? "?"
    }
    
    public static func formatted(money value: String) -> Double? {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        guard let number = formatter.number(from: value) else { return nil }
        
        return Double(number)
    }
    
    public static func formatted(percentile value: Double) -> String {
        if value <= 0 {
            return "!"
        }
        
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.positiveSuffix = "%"
        
        return formatter.string(from: value as NSNumber) ?? "?"
    }
    
    public static func formatted(date: String) -> String {
        return (date.split(separator: "T").first ?? "").split(separator: "-").reversed().joined(separator: "/")
    }
    
    init(from codableFund: CodableFund) {
        self.id = codableFund.id
        self.name = codableFund.name
        self.minimumInvestiment = FormattedFund.formatted(money: codableFund.minimumInitialInvestment)
        self.netEquity = FormattedFund.formatted(money: codableFund.netEquity)
        self.beginDate = FormattedFund.formatted(date: codableFund.beginDate)
        self.month = FormattedFund.formatted(percentile: codableFund.profitability.month)
        self.year = FormattedFund.formatted(percentile: codableFund.profitability.year ?? -1.0)
        self.twelveMonths = FormattedFund.formatted(percentile: codableFund.profitability.twelveMonths ?? -1.0)
        self.rescueInterval = codableFund.detail.rescueQuota
        self.category = codableFund.detail.categoryDescription
        
        if let risk = RiskLevel(rawValue: codableFund.riskName) {
            switch risk {
            case .conservador:
                self.riskColor = .btg_blue
            case .moderado:
                self.riskColor = .btg_orange
            case .sofisticado:
                self.riskColor = .btg_red
            }
        } else {
            self.riskColor = .black
        }
    }
}
