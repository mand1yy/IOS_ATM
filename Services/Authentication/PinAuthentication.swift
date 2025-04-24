//
//  PinAuthentication.swift
//  Bank
//
//  Created by Oleksii on 23.04.2025.
//
import Foundation

class PinAuthentication: AuthenticationStrategy {
    func authenticate(_ credential: String) -> Bool {
        return credential == "1234"
    }
}
