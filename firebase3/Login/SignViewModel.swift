//
//  SignViewModel.swift
//  firebase3
//
//  Created by 大貫 伽奈 on 2023/02/07.
//

import Foundation

class SignViewModel : ObservableObject{
    
    @Published var isSignedIn = false
    @Published var mailAddress = ""
    @Published var password = ""
    @Published var isShowAlert = false
    @Published var isError = false
    @Published var isShowSignedOut = false
    
    
    
    
}
