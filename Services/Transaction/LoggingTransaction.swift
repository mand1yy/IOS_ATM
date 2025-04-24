//
//  LoggingTransaction.swift
//  Bank
//
//  Created by Oleksii on 23.04.2025.
//
import Foundation

struct LoggingTransaction: Transaction {
    let wrapped: AnyTransaction
    
    var amount: Double { wrapped.transaction.amount }
    var date: Date { wrapped.transaction.date }
    var type: String { wrapped.transaction.type }
    
    init(wrapped: Transaction) {
        self.wrapped = AnyTransaction(wrapped)
        print("Transaction logged: \(type) of $\(amount) at \(date)")
    }
    
    enum CodingKeys: String, CodingKey {
        case wrapped
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.wrapped = try container.decode(AnyTransaction.self, forKey: .wrapped)
        print("Transaction logged: \(type) of $\(amount) at \(date)")
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(wrapped, forKey: .wrapped)
    }
}
