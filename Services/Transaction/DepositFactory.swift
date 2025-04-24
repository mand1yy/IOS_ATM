//
//  DepositFactory.swift
//  Bank
//
//  Created by Oleksii on 23.04.2025.
//
import Foundation

class DepositFactory: TransactionFactory {
    func createTransaction(amount: Double) -> Transaction {
        BasicTransaction(amount: amount, date: Date(), type: "Deposit")
    }
}
