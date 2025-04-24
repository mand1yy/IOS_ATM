//
//  BiometricAuthentication.swift
//  Bank
//
//  Created by Oleksii on 23.04.2025.
//
import Foundation

class BiometricAuthentication: AuthenticationStrategy {
    func authenticate(_ credential: String) -> Bool {
        return true
    }
}
