//
//  NSObject+Extension.swift
//  TableViewExample
//
//  Created by Shaik, Suneelahammad (Cognizant) on 13/04/22.
//

import Foundation

extension NSObject {
    
    static var className: String {
        return String(describing: self)
    }
}
