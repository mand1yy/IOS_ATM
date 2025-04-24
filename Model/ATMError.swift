//
//  ATMError.swift
//  Bank
//
//  Created by Oleksii on 23.04.2025.
//
import Foundation

enum ATMError: Error, LocalizedError {
    case insufficientFunds
    case invalidAmount
    case unauthorized
    
    var errorDescription: String? {
        switch self {
        case .insufficientFunds: return "Insufficient funds"
        case .invalidAmount: return "Invalid amount"
        case .unauthorized: return "Please authorize"
        }
    }
}
