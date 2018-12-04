//
//  ViewController.swift
//  Teste-iOS-BTG
//
//  Created by BTG Pactual digital on 30/11/18.
//  Copyright © 2018 BTG Pactual. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var conservadorButton: UIButton!
    @IBOutlet weak var moderadoButton: UIButton!
    @IBOutlet weak var sofisticadoButton: UIButton!
    
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var minimumApplicationButton: UIButton!
    @IBOutlet weak var rescueIntervalButton: UIButton!
    
    private var action: (String?) -> Void = {_ in}
    private var options = [String]()
    private var pickerTitle: String = ""
    private var optionPrefix: String = ""
    private var option: String = ""
    
    public var filterOptions: FundFilterOptions?
    
    var risk = [RiskLevel]() {
        didSet {
            self.filterOptions?.risk = self.risk
            
            self.conservadorButton.backgroundColor = self.risk.contains(.conservador) ? .btg_blue : .white
            self.moderadoButton.backgroundColor = self.risk.contains(.moderado) ? .btg_blue : .white
            self.sofisticadoButton.backgroundColor = self.risk.contains(.sofisticado) ? .btg_blue : .white
        }
    }
    var category: FundCategory? {
        didSet {
            self.filterOptions?.category = self.category
            
            if let category = self.category {
                self.categoryButton.setTitle("CATEGORIA: " + category.rawValue, for: .normal)
            } else {
                self.categoryButton.setTitle("CATEGORIA: Todos(as)", for: .normal)
            }
        }
    }
    var minimumApplication: ApplicationInterval? {
        didSet {
            self.filterOptions?.minimumApplication = self.minimumApplication
            
            if let minimumApplication = self.minimumApplication {
                self.minimumApplicationButton.setTitle("APLICAÇÃO MÍNIMA: " + FormattedFund.formatted(money: minimumApplication.rawValue), for: .normal)
            } else {
                self.minimumApplicationButton.setTitle("APLICAÇÃO MÍNIMA: Todos(as)", for: .normal)
            }
        }
    }
    var rescueInterval: RescueInterval? {
        didSet {
            self.filterOptions?.rescueInterval = self.rescueInterval
            
            if let rescueInterval = self.rescueInterval {
                self.rescueIntervalButton.setTitle("RESGATE EM: " + rescueInterval.rawValue, for: .normal)
            } else {
                self.rescueIntervalButton.setTitle("RESGATE EM: Todos(as)", for: .normal)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.conservadorButton.layer.borderWidth = 3
        self.conservadorButton.layer.borderColor = UIColor.btg_blue.cgColor
        
        self.moderadoButton.layer.borderWidth = 3
        self.moderadoButton.layer.borderColor = UIColor.btg_blue.cgColor
        
        self.sofisticadoButton.layer.borderWidth = 3
        self.sofisticadoButton.layer.borderColor = UIColor.btg_blue.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.optionPrefix = ""
        self.option = ""
        
        self.risk = self.filterOptions?.risk ?? []
        self.category = self.filterOptions?.category
        self.minimumApplication = self.filterOptions?.minimumApplication
        self.rescueInterval = self.filterOptions?.rescueInterval
    }
    
    @IBAction func exitFilterScreen(_ sender: Any) {
        self.cleanFilter(sender)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func applyFilter(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cleanFilter(_ sender: Any) {
        self.risk = []
        self.category = nil
        self.minimumApplication = nil
        self.rescueInterval = nil
    }
    
    @IBAction func clickedCategoria(_ sender: UIButton) {
        self.action = { [weak self](selection) in
            guard let self = self, let selection = selection else { return }
            
            if let value = FundCategory(rawValue: selection) {
                self.category = value
            } else {
                self.category = nil
            }
        }
        
        self.options = FundCategory.allCases.map({ $0.rawValue })
        self.option = self.category?.rawValue ?? "Todos(as)"
        self.pickerTitle = "CATEGORIA"
        
        performSegue(withIdentifier: "toPicker", sender: nil)
    }
    
    @IBAction func clickedMinimumApplication(_ sender: UIButton) {
        self.action = { [weak self](selection) in
            guard let self = self else { return }
            guard let selection = selection, let value = FormattedFund.formatted(money: selection) else {
                self.minimumApplication = nil
                return
            }
            
            if let value = ApplicationInterval(rawValue: value) {
                self.minimumApplication = value
            } else {
                self.minimumApplication = nil
            }
        }
        
        self.options = ApplicationInterval.allCases.map({ FormattedFund.formatted(money: $0.rawValue) })
        self.optionPrefix = "até R$ "
        self.option = FormattedFund.formatted(money: self.minimumApplication?.rawValue ?? -1.0)
        self.pickerTitle = "APLICAÇÃO MÍNIMA"
        
        performSegue(withIdentifier: "toPicker", sender: nil)
    }
    
    @IBAction func clickedRescueInterval(_ sender: UIButton) {
        self.action = { [weak self](selection) in
            guard let self = self, let selection = selection else { return }
            
            if let value = RescueInterval(rawValue: selection) {
                self.rescueInterval = value
            } else {
                self.rescueInterval = nil
            }
        }
        
        self.options = RescueInterval.allCases.map({ $0.rawValue })
        self.option = self.rescueInterval?.rawValue ?? "Todos(as)"
        self.pickerTitle = "RESGATE EM"
        
        performSegue(withIdentifier: "toPicker", sender: nil)
    }
    
    @IBAction func toggleConservador(_ sender: Any) {
        if let index = self.risk.firstIndex(of: .conservador) {
            self.risk.remove(at: index)
        } else {
            self.risk.append(.conservador)
        }
    }
    
    @IBAction func toggleModerado(_ sender: Any) {
        if let index = self.risk.firstIndex(of: .moderado) {
            self.risk.remove(at: index)
        } else {
            self.risk.append(.moderado)
        }
    }
    
    @IBAction func toggleSofisticado(_ sender: Any) {
        if let index = self.risk.firstIndex(of: .sofisticado) {
            self.risk.remove(at: index)
        } else {
            self.risk.append(.sofisticado)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPicker", let destination = segue.destination as? PickerTableViewController {
            destination.completionAction = self.action
            destination.options = self.options
            destination.selectedOption = self.option
            destination.title = self.pickerTitle
            destination.optionPrefix = self.optionPrefix
        }
    }
}

