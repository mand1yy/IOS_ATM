//
//  Transaction.swift
//  Bank
//
//  Created by Oleksii on 23.04.2025.
//
import Foundation

protocol Transaction: Codable {
    var amount: Double { get }
    var date: Date { get }
    var type: String { get }
}

struct BasicTransaction: Transaction {
    let amount: Double
    let date: Date
    let type: String
}
