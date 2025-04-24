//
//  ATM.swift
//  Bank
//
//  Created by Oleksii on 23.04.2025.
//
import Foundation

struct ATM: Codable {
    var balance: Double
    var transactionHistory: [AnyTransaction]
    var state: ATMState
    
    mutating func performOperation(_ operation: ATMOperation) -> Result<Void, ATMError> {
        return state.handleOperation(operation, atm: &self)
    }
    
    mutating func authorize() {
        self.state = .authorized
    }
}
