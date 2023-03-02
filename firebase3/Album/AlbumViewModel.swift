//
//  AlbumViewModel.swift
//  firebase3
//
//  Created by 大貫 伽奈 on 2023/01/31.
//
//最初に動くやつもこっち

import Foundation
import SwiftUI
import UIKit
import MapKit
import CoreData


class AlbumViewModel: ObservableObject {
    
    @AppStorage("subject") var strageDate: String = ""


    
    @Published var posts: Post?//配列？データ入ってる？
    @Published var posts2: [Post2] = []//    @Published var imageData : Data = .init(capacity:0)
    
    @Published var locations: [CLLocationCoordinate2D] = []//緯度経度登録　配列　リストとか
    
    
    //これをappstorageに
    @Published var mapData = [MapData]()
    
    @Published var foryou = [For]()
    
//    @ObservedObject var viewModel = AlbumViewModel()

    
    @Published var isNewData = false
    
    @Published var content = ""
    @Published var memoText = ""
    @Published var color = 0
    
    
    @Published var imageData:Data = Data()//
    
    @Published var image = UIImage()
    
    //移植
    @Published var updateItem : Task!
     @Published var image3: Image?
     @Published var date = Date()
    
    var gpsLat = 0.0
    var gpsLon = 0.0
    
    //仮
    var latnum = 1.11111
    var lonnum = 1.11111
    
    
   @Published var appStrage :URL?
    //    userDefaults.standard.array(forKey: "キー") -> [Any]?
    @Published var nowFilteredImage : UIImage?
    
    
    @Published var pin = [Pin]()

    
    @Published var random = 0

    init(){
        UITabBar.appearance().backgroundColor = .white
        
    }
    
    
    
    
    
    
    
    func writeData(context : NSManagedObjectContext){
    
        let newTask = Task(context: context)
        newTask.date = date
        newTask.content = content
        
         newTask.imageData = imageData
        newTask.memoText = memoText
        newTask.lat = latnum
        newTask.lon = lonnum
        newTask.color = Int64(color)
        print("あああああああああああああ")
        print(color)
        
        do{
            try context.save()
            isNewData = false
            
            content = ""
            date = Date()
            memoText = ""
            
             imageData = Data()
            locations = []
            color = 0
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    
    
    
    // resultsをforeachで回して取り出したimageDataを戻り値で返す
    
    
    func ForYou(results: FetchedResults<Task>){
      
            for i in results {
                guard let imageData = i.imageData else { continue }
                foryou.append(For(id: UUID(), image: imageData, date: i.date ?? Date(), memoText: i.memoText ?? "", title: i.content ?? ""))
                
            }
        if foryou.count > 0 {
            random = Int.random(in: 0..<foryou.count)
        }
    }
        
    
     
     
//    func EditItem(item:Task){
//        updateItem = item
//
//        date = item.date!
//        content = item.content!
//         imageData = item.imageData ?? Data.init()
//        memoText = item.memoText!
//        lat = item.lat!
//        lon = item.lon!
//
//        isNewData.toggle()
//    }
}
