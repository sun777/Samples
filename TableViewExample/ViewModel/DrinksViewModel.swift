//
//  DrinksViewModel.swift
//  TableViewExample
//
//  Created by Shaik, Suneelahammad (Cognizant) on 13/04/22.
//

import Foundation

enum DrinkFor {
    case all
    case few
}

enum DrinkType: Equatable {
    case alcohol(DrinkFor)
}

class DrinksViewModel {
    
    let service: ServiceManagerProtocol
    var drinks: [Drink]?
    
    init(service: ServiceManagerProtocol) {
        self.service = service
    }
    
    func callService(completion: @escaping ((Bool) -> Void)) {
        self.service.callService { [weak self] result in
            switch result {
            case .success(let drinks):
                self?.drinks = drinks
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }
    
    func getNoOfRows() -> Int {
        return self.drinks?.count ?? 0
    }
    
    func getDrink(index: Int) -> Drink? {
        return self.drinks?[index]
    }
    
    func getHeaderTitle() -> String {
        return "Drinks"
    }
    
    func getDrinkType(index: Int) -> DrinkType {
        switch index {
        case 0...5: return DrinkType.alcohol(.few)
        default: return DrinkType.alcohol(.all)
        }
    }
}
