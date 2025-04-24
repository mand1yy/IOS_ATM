//
//  AuthenticationStrategy.swift
//  Bank
//
//  Created by Oleksii on 23.04.2025.
//
import Foundation

protocol AuthenticationStrategy {
    func authenticate(_ credential: String) -> Bool
}
