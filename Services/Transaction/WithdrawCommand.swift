//
//  WithdrawCommand.swift
//  Bank
//
//  Created by Oleksii on 23.04.2025.
//
import Foundation

struct WithdrawCommand: ATMOperation {
    let amount: Double
    let factory: TransactionFactory
    
    func execute(on atm: inout ATM) -> Result<Void, ATMError> {
        guard amount > 0 else { return .failure(.invalidAmount) }
        guard atm.balance >= amount else { return .failure(.insufficientFunds) }
        atm.balance -= amount
        let transaction = factory.createTransaction(amount: amount)
        atm.transactionHistory.append(AnyTransaction(transaction))
        return .success(())
    }
}
