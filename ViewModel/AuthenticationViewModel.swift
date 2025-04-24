//
//  AuthenticationViewModel.swift
//  Bank
//
//  Created by Oleksii on 23.04.2025.
//
import Foundation
import Combine

class AuthenticationViewModel: ObservableObject {
    @Published var errorMessage: String?
    private let authenticationStrategy: AuthenticationStrategy
    
    init(strategy: AuthenticationStrategy = PinAuthentication()) {
        self.authenticationStrategy = strategy
    }
    
    func authenticate(credential: String) -> Bool {
        let isAuthenticated = authenticationStrategy.authenticate(credential)
        if !isAuthenticated {
            errorMessage = "Invalid credential"
        }
        return isAuthenticated
    }
}
