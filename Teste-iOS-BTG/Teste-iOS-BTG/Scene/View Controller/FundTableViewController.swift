//
//  FundTableViewController.swift
//  Teste-iOS-BTG
//
//  Created by Julio Brazil on 02/12/18.
//  Copyright © 2018 BTG Pactual. All rights reserved.
//

import UIKit

private let reuseIdentifier: String = "cell"

class FundTableViewController: UITableViewController, UISearchBarDelegate {
    var funds = [FormattedFund]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var interactor: Interactor
    
    var filter = FundFilterOptions()
    
    public var errorMessage: String? {
        didSet {
            print(errorMessage)
        }
    }
    
    private var selectedIndexPath: IndexPath?
    
    required init?(coder aDecoder: NSCoder) {
        let presenter = Presenter()
        self.interactor = Interactor(presenter: presenter)
        
        super.init(coder: aDecoder)
        
        presenter.viewController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        interactor.fetchFunds(filteredBy: self.filter)
    }
    
    // MARK - Search bar delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.interactor.fetchFunds(filteredByText: searchText, and: self.filter)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.funds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! FundTableViewCell

        cell.configure(with: self.funds[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let selectedIndexPath = self.selectedIndexPath, selectedIndexPath == indexPath {
            return CGFloat(324)
        } else {
            return CGFloat(165)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedIndexPath = self.selectedIndexPath, selectedIndexPath == indexPath {
            self.tableView.deselectRow(at: indexPath, animated: true)
            self.selectedIndexPath = nil
        } else {
            self.selectedIndexPath = indexPath
        }
        
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFilter", let destination = segue.destination as? ViewController {
            destination.filterOptions = self.filter
        }
    }

}
