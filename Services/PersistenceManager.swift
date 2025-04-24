//
//  PersistenceManager.swift
//  Bank
//
//  Created by Oleksii on 23.04.2025.
//
import Foundation

class PersistenceManager {
    static let shared = PersistenceManager()
    private let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("atm.json")
    
    func save(_ atm: ATM) {
        do {
            let data = try JSONEncoder().encode(atm)
            try data.write(to: fileURL)
        } catch {
            print("Error saving: \(error)")
        }
    }
    
    func load() -> ATM? {
        do {
            let data = try Data(contentsOf: fileURL)
            let atm = try JSONDecoder().decode(ATM.self, from: data)
            return atm
        } catch {
            print("Error loading: \(error)")
            return nil
        }
    }
}
