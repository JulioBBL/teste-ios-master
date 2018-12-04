//
//  PickerTableViewController.swift
//  Teste-iOS-BTG
//
//  Created by Julio Brazil on 03/12/18.
//  Copyright © 2018 BTG Pactual. All rights reserved.
//

import UIKit

class PickerTableViewController: UITableViewController {
    public var options = [String]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    var selectedOption: String?
    
    public var optionPrefix: String = ""
    
    public var completionAction: (String?) -> Void = {_ in}
    
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func confirm(_ sender: Any) {
        self.completionAction(self.selectedOption)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.options.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let option = indexPath.row == 0 ? "Todos(as)" : self.options[indexPath.row - 1]
        cell.textLabel?.text = option == "Todos(as)" ? option : self.optionPrefix + option
        cell.accessoryType = self.selectedOption != option ? .none : .checkmark
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = indexPath.row == 0 ? "Todos(as)" : self.options[indexPath.row - 1]
        
        self.selectedOption = self.selectedOption == option ? nil :  option
        
        self.tableView.reloadData()
    }

}
