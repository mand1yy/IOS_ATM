//
//  DepositCommand.swift
//  Bank
//
//  Created by Oleksii on 23.04.2025.
//
import Foundation

struct DepositCommand: ATMOperation {
    let amount: Double
    let factory: TransactionFactory
    
    func execute(on atm: inout ATM) -> Result<Void, ATMError> {
        guard amount > 0 else { return .failure(.invalidAmount) }
        atm.balance += amount
        let transaction = factory.createTransaction(amount: amount)
        atm.transactionHistory.append(AnyTransaction(transaction))
        return .success(())
    }
}
