//
//  WithdrawalFactory.swift
//  Bank
//
//  Created by Oleksii on 23.04.2025.
//
import Foundation

class WithdrawalFactory: TransactionFactory {
    func createTransaction(amount: Double) -> Transaction {
        BasicTransaction(amount: amount, date: Date(), type: "Withdrawal")
    }
}
