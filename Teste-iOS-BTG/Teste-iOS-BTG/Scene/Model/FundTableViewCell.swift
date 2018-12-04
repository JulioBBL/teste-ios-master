//
//  FundTableViewCell.swift
//  Teste-iOS-BTG
//
//  Created by Julio Brazil on 03/12/18.
//  Copyright © 2018 BTG Pactual. All rights reserved.
//

import UIKit

class FundTableViewCell: UITableViewCell {
    @IBOutlet weak var riskColorView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var twelveMonthsLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var beginDateLabel: UILabel!
    @IBOutlet weak var minimumApplicationLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var netEquityLabel: UILabel!
    @IBOutlet weak var resqueLabel: UILabel!
    
    @IBOutlet weak var showMoreView: UIView!
    @IBOutlet weak var showMoreImage: UIImageView!

    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            //selected
            UIView.animate(withDuration: 0.3, animations: {
                self.showMoreImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi*2)
                self.showMoreImage.tintColor = .btg_neonGreen
                self.showMoreView.backgroundColor = .white
            })
        } else {
            //not selected
            UIView.animate(withDuration: 0.3, animations: {
                self.showMoreImage.transform = CGAffineTransform(rotationAngle: -CGFloat(CGFloat.pi/4))
                self.showMoreImage.tintColor = .white
                self.showMoreView.backgroundColor = .btg_gray
            })
        }
    }
    
    func configure(with fund: FormattedFund) {
        self.nameLabel.text = fund.name
        self.categoryLabel.text = fund.category
        self.twelveMonthsLabel.text = fund.twelveMonths
        self.monthLabel.text = fund.month
        self.beginDateLabel.text = fund.beginDate
        self.minimumApplicationLabel.text = fund.minimumInvestiment
        self.yearLabel.text = fund.year
        self.netEquityLabel.text = fund.netEquity
        self.resqueLabel.text = fund.rescueInterval
        
        self.riskColorView.backgroundColor = fund.riskColor
        
        self.showMoreImage.tintColor = .white
    }

}
