//
//  ServiceManager.swift
//  TableViewExample
//
//  Created by Shaik, Suneelahammad (Cognizant) on 13/04/22.
//

import Foundation

protocol ServiceManagerProtocol {
    func callService(completion: @escaping (Result<[Drink], Error>) -> Void)
    func parseResponseData(_ data: Data) -> [Drink]?
}

class ServiceManager: ServiceManagerProtocol {
    
    func callService(completion: @escaping (Result<[Drink], Error>) -> Void) {
        
        let urlString = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=margarita"
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            if let result = self.parseResponseData(data) {
                completion(.success(result))
            } else {
                completion(.failure(NSError()))
            }
        }.resume()
    }
    
    func parseResponseData(_ data: Data) -> [Drink]? {
        guard let result = try? JSONDecoder().decode(ResponseModel.self, from: data).drinks else { return nil }
        return result
    }
    
}

class MockServiceManager: ServiceManagerProtocol {
    
    var jsonString = ""
    
    func callService(completion: @escaping (Result<[Drink], Error>) -> Void) {
        let jsonData = Data(jsonString.utf8)
        if let result = self.parseResponseData(jsonData) {
            completion(.success(result))
        } else {
            completion(.failure(NSError()))
        }
    }
    
    func parseResponseData(_ data: Data) -> [Drink]? {
        guard let result = try? JSONDecoder().decode(ResponseModel.self, from: data).drinks else {
            return nil
        }
        return result
    }
}
