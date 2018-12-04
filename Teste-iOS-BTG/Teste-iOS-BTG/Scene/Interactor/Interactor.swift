//
//  Interactor.swift
//  Teste-iOS-BTG
//
//  Created by Julio Brazil on 02/12/18.
//  Copyright © 2018 BTG Pactual. All rights reserved.
//

import Foundation

public class Interactor {
    var presenter: Presenter
    private var apiWorker: APIWorker
    private var filterWorker: FilterWorker
    
    init(presenter: Presenter) {
        self.presenter = presenter
        self.apiWorker = APIWorker()
        self.filterWorker = FilterWorker()
    }
    
    private func handleResponse(_ response: ResponseType<[CodableFund]>, completion block: @escaping ([CodableFund]) -> Void) {
        switch response {
        case .result(let funds):
            block(funds)
        case .error(let description):
            self.presenter.presentError(description ?? "")
        }
    }
    
    func fetchFunds(filteredBy filterOptions: FundFilterOptions? = nil) {
        apiWorker.getFunds { [weak self](response) in
            self?.handleResponse(response, completion: { [weak self](input) in
                    guard let self = self else { return }
                    
                    var funds = input
                    
                    if let filterOptions = filterOptions {
                        funds = self.filterWorker.filterFunds(funds, by: filterOptions)
                    }
                    
                    self.presenter.present(funds)
            })
        }
    }
    
    func fetchFunds(filteredByText searchText: String, and filterOptions: FundFilterOptions? = nil) {
        apiWorker.getFunds { [weak self](response) in
            self?.handleResponse(response, completion: { [weak self](input) in
                guard let self = self else { return }
                
                var funds = input
                
                if let filterOptions = filterOptions {
                    funds = self.filterWorker.filterFunds(funds, by: filterOptions)
                }
                
                funds = self.filterWorker.filterFunds(funds, byText: searchText.uppercased())
                
                self.presenter.present(funds)
            })
        }
    }
}
