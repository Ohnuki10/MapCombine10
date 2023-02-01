//
//  AuthViewModel.swift
//  firebase3
//
//  Created by 大貫 伽奈 on 2023/01/19.
//

import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    
    @Published var mailAddress = ""
    @Published var password = ""
    
    
    func user() {
        Auth.auth().createUser(withEmail: self.mailAddress, password: self.password) { authResult, error in
            if let user = authResult?.user {
                dump(user)
            } else {
                if let error = error {
                    print(error)
                }
            }
        }
    }
    
    
    func error() {
        Auth.auth().createUser(withEmail: self.mailAddress, password: self.password) { authResult, error in
            
        }
    }
    
    
}
