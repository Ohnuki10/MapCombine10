//
//  AuthTestSignUpView.swift
//  firebase3
//
//  Created by 大貫 伽奈 on 2023/01/19.
//

import SwiftUI
import FirebaseAuth

struct AuthTestSignUpView: View {
    
    @State private var mailAddress = ""
    @State private var password = ""
    @State private var passwordConfirm = ""
    
    @State private var isShowAlert = false
    @State private var isError = false
    @State private var errorMessage = ""
    
    
    var body: some View {
        NavigationStack {
            HStack {
                Spacer()
                    .frame(width: 50)
                VStack {
                    TextField("メールアドレス", text: $mailAddress).textFieldStyle(RoundedBorderTextFieldStyle())
                    SecureField("パスワード", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
                    SecureField("パスワード確認", text: $passwordConfirm).textFieldStyle(RoundedBorderTextFieldStyle())
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
                        } else if self.passwordConfirm.isEmpty {
                            self.errorMessage = "確認パスワードが入力されていません"
                            self.isError = true
                            self.isShowAlert = true
                        } else if self.password.compare(self.passwordConfirm) != .orderedSame {
                            self.errorMessage = "パスワードと確認パスワードが一致しません"
                            self.isError = true
                            self.isShowAlert = true
                        } else {
                            self.signUp()
                        }
                    }) {
                        Text("ユーザー登録")
                    }
                    .alert(isPresented: $isShowAlert) {
                        if self.isError {
                            return Alert(title: Text(""), message: Text(self.errorMessage), dismissButton: .destructive(Text("OK"))
                            )
                        } else {
                            return Alert(title: Text(""), message: Text("登録されました"), dismissButton: .default(Text("OK")))
                        }
                    }
                    NavigationLink(destination: AuthTestSignInView()) {
                        Text("login")
                    }
                    NavigationLink(destination: AuthTestEmailPasswordUpdateView()) {
                        Text("update")
                    }
                    
                }//vs
                Spacer().frame(width: 50)
            }
        }
        
         
    }
    
    
    //ユーザ登録 新規
    func signUp() {
        Auth.auth().createUser(withEmail: self.mailAddress, password: self.password) { authResult, error in
            if let error = error {
                print(error)
            }
            
            if let user = authResult?.user {
                self.isError = false
                self.isShowAlert = true
                
                user.sendEmailVerification { error in
                    if error == nil {
                        print("send mail success.")
                    }
                }
            }
        }
    }
    
    
}
    
    struct AuthTestSignUpView_Previews: PreviewProvider {
        static var previews: some View {
            AuthTestSignUpView()
        }
    }
