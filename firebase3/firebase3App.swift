//
//  firebase3App.swift
//  firebase3
//
//  Created by 大貫 伽奈 on 2023/01/19.
//

import SwiftUI
import Firebase

@main
struct firebase3App: App {
    var body: some Scene {
        WindowGroup {
            AuthTestSignUpView()
//            TabMainView()
        }
    }
    init() {
        FirebaseApp.configure()
    }
    
}
