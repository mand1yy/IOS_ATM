//
//  ATMState.swift
//  Bank
//
//  Created by Oleksii on 23.04.2025.
//
import Foundation

enum ATMState: String, Codable {
    case unauthorized
    case authorized
    
    func handleOperation(_ operation: ATMOperation, atm: inout ATM) -> Result<Void, ATMError> {
        switch self {
        case .unauthorized:
            return .failure(.unauthorized)
        case .authorized:
            return operation.execute(on: &atm)
        }
    }
}
