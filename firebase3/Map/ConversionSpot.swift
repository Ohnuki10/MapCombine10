//
//  ConversionSpot.swift
//  firebase3
//
//  Created by 大貫 伽奈 on 2023/02/14.
//

import Foundation
import MapKit

class ConversionSpot : ObservableObject{
    
    @Published var saveinput = ""
    // ジオコーディング
    func geocoding(adress: String){
        var address = adress // 東京スカイツリーの住所
        
        print("値きてる？"+adress) //座標はとれてる　あと表示
        var geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let lat = placemarks?.first?.location?.coordinate.latitude {
                print("緯度 : \(lat)")
            }
            if let long = placemarks?.first?.location?.coordinate.longitude {
                print("経度 : \(long)")
            }
        }
    }
}
