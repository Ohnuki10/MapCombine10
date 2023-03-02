//
//  ViewModel.swift
//  firebase3
//画像のURLをfirebaseから取ってきてPostのやつに追加
//  Created by 大貫 伽奈 on 2023/01/19.
//strinGとURLの変換

import Foundation
import SwiftUI
import Combine
import CoreData

struct Post: Codable, Identifiable{
    var id: UUID //id取得
    var post2: [Post2]
    //    var lat : Double//追加
    //    var lon : Double//追加
    
    
}

//ひとまとまり 投稿用
struct Post2: Codable, Identifiable{
    var id: UUID
    var title : String
    var memo : String
    let timeStamp: String
    var picture : URL?
    var lat : Double
    var lon : Double
    
}

//
struct Post3: Identifiable{
    var id: UUID
    var title : String
    var memo : String
    let timeStamp: String
    var picture : UIImage
    var lat : Double
    var lon : Double
}



