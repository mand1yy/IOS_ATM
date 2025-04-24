//
//  TransactionComponent.swift
//  Bank
//
//  Created by Oleksii on 23.04.2025.
//
import Foundation

protocol TransactionComponent: Codable {
    var totalAmount: Double { get }
}

struct TransactionLeaf: TransactionComponent {
    let transaction: AnyTransaction
    
    var totalAmount: Double { transaction.transaction.amount }
    
    enum CodingKeys: String, CodingKey {
        case transaction
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.transaction = try container.decode(AnyTransaction.self, forKey: .transaction)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(transaction, forKey: .transaction)
    }
}

struct TransactionGroup: TransactionComponent {
    let transactions: [TransactionComponent]
    
    var totalAmount: Double { transactions.reduce(0) { $0 + $1.totalAmount } }
    
    enum CodingKeys: String, CodingKey {
        case transactions
        case type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        switch type {
        case "TransactionLeaf":
            let transaction = try container.decode(TransactionLeaf.self, forKey: .transactions)
            self.transactions = [transaction]
        case "TransactionGroup":
            let transactions = try container.decode([TransactionLeaf].self, forKey: .transactions)
            self.transactions = transactions
        default:
            throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Unknown transaction component type")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if transactions.count == 1, let leaf = transactions.first as? TransactionLeaf {
            try container.encode("TransactionLeaf", forKey: .type)
            try container.encode(leaf, forKey: .transactions)
        } else {
            try container.encode("TransactionGroup", forKey: .type)
            try container.encode(transactions as! [TransactionLeaf], forKey: .transactions)
        }
    }
}
