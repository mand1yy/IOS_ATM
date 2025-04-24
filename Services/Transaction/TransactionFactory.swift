//
//  TransactionFactory.swift
//  Bank
//
//  Created by Oleksii on 23.04.2025.
//
import Foundation

protocol TransactionFactory {
    func createTransaction(amount: Double) -> Transaction
}
