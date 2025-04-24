//
//  AuthView.swift
//  Bank
//
//  Created by Oleksii on 23.04.2025.
//
import SwiftUI

struct AuthView: View {
    @Binding var isAuthorized: Bool
    @State private var pin: String = ""
    var onAuthenticate: (String) -> Bool 
    @State private var errorMessage: String?
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Enter PIN")
                .font(.title)
            
            SecureField("PIN", text: $pin)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .padding()
            
            if let error = errorMessage {
                Text(error)
                    .foregroundColor(.red)
            }
            
            Button("Login") {
                if onAuthenticate(pin) {
                    isAuthorized = true
                } else {
                    errorMessage = "Invalid PIN"
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(isAuthorized: .constant(false), onAuthenticate: { _ in true })
    }
}
