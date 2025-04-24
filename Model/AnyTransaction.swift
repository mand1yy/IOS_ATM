//
//  AnyTransaction.swift
//  Bank
//
//  Created by Oleksii on 23.04.2025.
//
import Foundation

struct AnyTransaction: Codable {
    let transaction: Transaction
    
    enum CodingKeys: String, CodingKey {
        case type
        case data
    }
    
    init(_ transaction: Transaction) {
        self.transaction = transaction
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        switch type {
        case "BasicTransaction":
            let data = try container.decode(BasicTransaction.self, forKey: .data)
            self.transaction = data
        case "LoggingTransaction":
            let data = try container.decode(LoggingTransaction.self, forKey: .data)
            self.transaction = data
        default:
            throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Unknown transaction type")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch transaction {
        case let basic as BasicTransaction:
            try container.encode("BasicTransaction", forKey: .type)
            try container.encode(basic, forKey: .data)
        case let logging as LoggingTransaction:
            try container.encode("LoggingTransaction", forKey: .type)
            try container.encode(logging, forKey: .data)
        default:
            throw EncodingError.invalidValue(transaction, EncodingError.Context(codingPath: [CodingKeys.type], debugDescription: "Unknown transaction type"))
        }
    }
}
