//
//  AuthTestSignInView.swift
//  firebase3
//
//  Created by 大貫 伽奈 on 2023/01/19.
//

import SwiftUI
import FirebaseAuth

struct AuthTestSignInView: View {
    
    //これでログイン状況分ける
    @State private var isSignedIn = false
        
        @State private var mailAddress = ""
        @State private var password = ""
        
        @State private var isShowAlert = false
        @State private var isError = false
        @State private var errorMessage = ""
        
        @State private var isShowSignedOut = false
    
    var body: some View {
        HStack {
//                   Spacer().frame(width: 50)
            VStack(spacing: 16) {
                if self.isSignedIn {
                    TabMainView()
                } else {
                    Text("ログインしていません").foregroundColor(.gray)
                    
                    TextField("メールアドレス", text: $mailAddress).textFieldStyle(RoundedBorderTextFieldStyle())
                    SecureField("パスワード", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        self.errorMessage = ""
                        if self.mailAddress.isEmpty {
                            self.errorMessage = "メールアドレスが入力されていません"
                            self.isError = true
                            self.isShowAlert = true
                        } else if self.password.isEmpty {
                            self.errorMessage = "パスワードが入力されていません"
                            self.isError = true
                            self.isShowAlert = true
                        } else {
                            self.signIn()
                        }
                    }) {
                        Text("ログイン")
                    }
                    .alert(isPresented: $isShowAlert) {
                        if self.isError {
                            return Alert(title: Text(""), message: Text(self.errorMessage), dismissButton: .destructive(Text("OK"))
                            )
                        } else {
                            return Alert(title: Text(""), message: Text("ログインしました"), dismissButton: .default(Text("OK")))
                        }
                    }
//                    Button(action: {
//                        self.signOut()
//                    }) {
//                        Text("ログアウト")
//                    }
//                    .alert(isPresented: $isShowSignedOut) {
//                        Alert(title: Text(""), message: Text("ログアウトしました"), dismissButton: .default(Text("OK")))
//                    }
                }//else
//                Spacer().frame(width: 50)
                Button(action: {
                    self.signOut()
                }) {
                    Text("ログアウト")
                }
                .alert(isPresented: $isShowSignedOut) {
                    Alert(title: Text(""), message: Text("ログアウトしました"), dismissButton: .default(Text("OK")))
                }
            }//vs
            
            
            
            
               }
               .onAppear() {
                   self.getCurrentUser()
               }
           }//view

           
           private func getCurrentUser() {
               if let _ = Auth.auth().currentUser {
                   self.isSignedIn = true
               } else {
                   self.isSignedIn = false
               }
           }
           
           private func signIn() {
               Auth.auth().signIn(withEmail: self.mailAddress, password: self.password) { authResult, error in
                   if authResult?.user != nil {
                       self.isSignedIn = true
                       self.isShowAlert = true
                       self.isError = false
                   } else {
                       self.isSignedIn = false
                       self.isShowAlert = true
                       self.isError = true
                       if let error = error {
                           print(error)
                       }
                   }
               }
           }
    
           private func signOut() {
               do {
                   try Auth.auth().signOut()
                   self.isShowSignedOut = true
                   self.isSignedIn = false
               } catch let signOutError as NSError {
                   print("SignOut Error: %@", signOutError)
               }
    }
}

struct AuthTestSignInView_Previews: PreviewProvider {
    static var previews: some View {
        AuthTestSignInView()
    }
}
