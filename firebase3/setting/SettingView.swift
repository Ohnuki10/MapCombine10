//
//  SettingView.swift
//  firebase3
//
//  Created by 大貫 伽奈 on 2023/02/07.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var album = AlbumViewModel()
    var body: some View {


        Button(action: {
//            signviewModel.signOut()
        }) {
            Text("ログアウト")
        }
//        .alert(isPresented: $isShowSignedOut) {
//            Alert(title: Text(""), message: Text("ログアウトしました"), dismissButton: .default(Text("OK")))
//        }
    }
}

//struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingView()
//    }
//}
