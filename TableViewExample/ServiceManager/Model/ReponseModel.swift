//
//  ResponseModel.swift
//  TableViewExample
//
//  Created by Shaik, Suneelahammad (Cognizant) on 13/04/22.
//

import Foundation

class ResponseModel: Decodable {
    var drinks: [Drink]
}

class Drink: Decodable {
    var strDrink: String
    var strCategory: String
    var strAlcoholic: String
    var strDrinkThumb: String
}
