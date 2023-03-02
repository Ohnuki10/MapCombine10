//
//  MapModels.swift
//  Museum
//
//  Created by 大貫 伽奈 on 2023/02/27.
//


import MapKit
import SwiftUI
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)],animation: .spring()) var results : FetchedResults<Task>
    
    // CLLocationManagerをインスタンス化
    let manager = CLLocationManager()
    @Published var lastSeenLocation: CLLocation?
    @Published  var region =  MKCoordinateRegion()
    @Published var addDistance = false
    @Published var currentLocation = MKCoordinateRegion(
        
    )
    
    @Published var indexCount = [Int]()
    var coordinate: CLLocationCoordinate2D? {
        lastSeenLocation?.coordinate
    }
    
    /// 京都御所(紫宸殿)の緯度経度
    let imperialPalaceLocation = CLLocationCoordinate2D(latitude: 35.69735612272055124101, longitude: 139.6978333184864)
    
    override init() {
        super.init() // スーパクラスのイニシャライザを実行
        manager.delegate = self // 自身をデリゲートプロパティに設定
        manager.requestWhenInUseAuthorization() // 位置情報を利用許可をリクエスト
        manager.desiredAccuracy = kCLLocationAccuracyBest // 最高精度の位置情報を要求
        manager.distanceFilter = 3.0 // 更新距離(m)
        manager.startUpdatingLocation()
    }
    
    // 領域の更新をするデリゲートメソッド
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // 配列の最後に最新のロケーションが格納される
        // map関数を使って全要素にアクセス map{ $0←要素に参照 }
        locations.last.map {
            let center = CLLocationCoordinate2D(
                latitude: $0.coordinate.latitude,
                longitude: $0.coordinate.longitude)
            
            // 地図を表示するための領域を再構築
            region = MKCoordinateRegion(
                center: center,
                latitudinalMeters: 750.0,
                longitudinalMeters: 750.0
            )
        }
        
        //位置情報の座標取得  常に
        lastSeenLocation = locations.first
        
        print("===================")
        region.center = CLLocationCoordinate2D(latitude: coordinate!.latitude, longitude: coordinate!.longitude)
        print("経度：" + String(coordinate?.longitude ?? 0))
        print("緯度：" + String(coordinate?.latitude ?? 0))
        
        print("カウント")
        
    }
    
    
}
extension CLLocationCoordinate2D {
    
    func distance(
        to targetLocation: CLLocationCoordinate2D) -> CLLocationDistance {
        
        // 現在位置
        let location1 = CLLocation(
            latitude: latitude,
            longitude: longitude
        )
        // ピンの位置
        let location2 = CLLocation(
            latitude: targetLocation.latitude,
            longitude: targetLocation.longitude
        )
        // 二つの距離間を計算
        return location1.distance(from: location2)
    }
}
//let distance = manager.coordinate?.distance(to: CLLocationCoordinate2D(latitude: i.locations.latitude, longitude: i.locations.longitude))
