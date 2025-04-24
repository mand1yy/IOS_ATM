//
//  ATMOperation.swift
//  Bank
//
//  Created by Oleksii on 23.04.2025.
//
import Foundation

protocol ATMOperation {
    func execute(on atm: inout ATM) -> Result<Void, ATMError>
}
