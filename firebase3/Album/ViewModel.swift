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
import MapKit

struct Post: Codable, Identifiable{
    var id: UUID //id取得
    var post2: [Post2]
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

struct Point: Identifiable {
    let id = UUID()
    let latitude: Double // 緯度
    let longitude: Double // 経度
    
    var color: Color
    
    // 座標
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct MapData: Identifiable {
    var id: UUID
    var context: String
    var color: Color
    var locations: CLLocationCoordinate2D
}

struct Pin: Identifiable{
    var id = UUID()
    var color: Color
    var locations: CLLocationCoordinate2D
}

struct For: Identifiable{
    var id: UUID
    var image: Data
    var date: Date
    var memoText: String
    var title: String
    
}



