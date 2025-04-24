//
//  ATMViewModel.swift
//  Bank
//
//  Created by Oleksii on 23.04.2025.
//
import Foundation
import Combine

class ATMViewModel: ObservableObject {
    @Published var balance: Double
    @Published var transactions: [Transaction]
    @Published var errorMessage: String?
    @Published var isAuthorized: Bool = false
    
    private var atm: ATM
    private let authenticationStrategy: AuthenticationStrategy
    private let persistenceManager = PersistenceManager.shared
    
    init() {
        if let loadedATM = persistenceManager.load() {
            self.atm = loadedATM
            self.isAuthorized = loadedATM.state == .authorized
        } else {
            self.atm = ATM(balance: 1000.0, transactionHistory: [], state: .unauthorized)
        }
        self.balance = atm.balance
        self.transactions = atm.transactionHistory.map { $0.transaction }
        self.authenticationStrategy = PinAuthentication()
    }
    
    func authenticate(pin: String) -> Bool {
        if authenticationStrategy.authenticate(pin) {
            atm.authorize()
            isAuthorized = true
            persistenceManager.save(atm)
            return true
        } else {
            errorMessage = "Invalid PIN"
            return false
        }
    }
    
    func withdraw(amount: Double) {
        let command = WithdrawCommand(amount: amount, factory: WithdrawalFactory())
        let result = atm.performOperation(command)
        handleResult(result)
    }
    
    func deposit(amount: Double) {
        let command = DepositCommand(amount: amount, factory: DepositFactory())
        let result = atm.performOperation(command)
        handleResult(result)
    }
    
    private func handleResult(_ result: Result<Void, ATMError>) {
        switch result {
        case .success:
            self.balance = atm.balance
            self.transactions = atm.transactionHistory.map { $0.transaction }
            self.errorMessage = nil
            persistenceManager.save(atm)
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
    }
}
