//
//  AuthTestEmailPasswordUpdateView.swift
//  firebase3
//
//  Created by 大貫 伽奈 on 2023/01/19.
//

import SwiftUI
import FirebaseAuth

struct AuthTestEmailPasswordUpdateView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var confirm = ""
    
    @State private var isShowEmailUpdateAlert = false
    @State private var isShowPasswordUpdateAlert = false
    @State private var isError = false
    @State private var errorMessage = ""
    
    var body: some View {
        HStack {
            Spacer().frame(width: 50)
            VStack {
                Text("新しいメールアドレス")
                TextField("mail@example.com", text: $email).textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    if self.email.isEmpty {
                        self.isShowEmailUpdateAlert = true
                        self.isError = true
                        self.errorMessage = "メールアドレスが入力されていません"
                    } else {
                        Auth.auth().currentUser?.updateEmail(to: self.email) { error in
                            self.isShowEmailUpdateAlert = true
                            if let error = error {
                                print(error)
                            }
                        }
                    }
                }) {
                    Text("メールアドレス変更")
                }
                .alert(isPresented: $isShowEmailUpdateAlert) {
                    if self.isError {
                        return Alert(title: Text(""), message: Text(self.errorMessage), dismissButton: .destructive(Text("OK")))
                    } else {
                        return Alert(title: Text(""), message: Text("メールアドレスが更新されました"), dismissButton: .default(Text("OK")))
                    }
                }
                Spacer().frame(height: 50)
                Text("新しいパスワード")
                SecureField("半角英数字", text: $password).textFieldStyle(RoundedBorderTextFieldStyle())
                Text("パスワード確認")
                SecureField("半角英数字", text: $confirm).textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    if self.password.isEmpty {
                        self.isShowPasswordUpdateAlert = true
                        self.isError = true
                        self.errorMessage = "パスワードが入力されていません"
                    } else if self.confirm.isEmpty {
                        self.isShowPasswordUpdateAlert = true
                        self.isError = true
                        self.errorMessage = "確認パスワードが入力されていません"
                    } else if self.password.compare(self.confirm) != .orderedSame {
                        self.isShowPasswordUpdateAlert = true
                        self.isError = true
                        self.errorMessage = "パスワードと確認パスワードが一致しません"
                    } else {
                        Auth.auth().currentUser?.updatePassword(to: self.password) { error in
                            self.isShowPasswordUpdateAlert = true
                            if let error = error {
                                print(error)
                            }
                        }
                    }
                }) {
                    Text("パスワード変更")
                }
                .alert(isPresented: $isShowPasswordUpdateAlert) {
                    if self.isError {
                        return Alert(title: Text(""), message: Text(self.errorMessage), dismissButton: .destructive(Text("OK")))
                    } else {
                        return Alert(title: Text(""), message: Text("パスワードが更新されました"), dismissButton: .default(Text("OK")))
                    }
                }
            }
            Spacer().frame(width: 50)
        }
    }
}

struct AuthTestEmailPasswordUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        AuthTestEmailPasswordUpdateView()
    }
}
