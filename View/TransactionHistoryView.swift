//
//  TransactionHistoryView.swift
//  Bank
//
//  Created by Oleksii on 23.04.2025.
//
import SwiftUI

struct TransactionHistoryView: View {
    let transactions: [Transaction]
    
    var body: some View {
        List(transactions, id: \.date) { transaction in
            VStack(alignment: .leading) {
                Text("\(transaction.type): $\(transaction.amount, specifier: "%.2f")")
                Text(transaction.date, style: .date)
                    .font(.caption)
            }
        }
        .navigationTitle("Transaction History")
    }
}

struct TransactionHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionHistoryView(transactions: [])
    }
}
