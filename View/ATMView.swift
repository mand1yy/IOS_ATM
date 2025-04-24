//
//  ATMView.swift
//  Bank
//
//  Created by Oleksii on 23.04.2025.
//
import SwiftUI

struct ATMView: View {
    @StateObject private var viewModel = ATMViewModel()
    @State private var amount: String = ""
    
    var body: some View {
        NavigationView {
            if viewModel.isAuthorized {
                mainScreen
            } else {
                AuthView(isAuthorized: $viewModel.isAuthorized) { pin in
                    viewModel.authenticate(pin: pin)
                }
            }
        }
    }
    
    private var mainScreen: some View {
        VStack(spacing: 20) {
            Text("ATM Balance: $\(viewModel.balance, specifier: "%.2f")")
                .font(.title)
                .padding()
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }
            
            TextField("Enter amount", text: $amount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .padding()
            
            HStack {
                Button("Withdraw") {
                    if let value = Double(amount) {
                        viewModel.withdraw(amount: value)
                    }
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                Button("Deposit") {
                    if let value = Double(amount) {
                        viewModel.deposit(amount: value)
                    }
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            
            NavigationLink(destination: TransactionHistoryView(transactions: viewModel.transactions)) {
                Text("View Transaction History")
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .navigationTitle("ATM")
    }
}

struct ATMView_Previews: PreviewProvider {
    static var previews: some View {
        ATMView()
    }
}
