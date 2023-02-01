//
//  LocationSelecterView.swift
//  firebase3
//
//  Created by 大貫 伽奈 on 2023/01/31.
//

import SwiftUI
import MapKit


public struct LocationSelecterView: UIViewRepresentable {
    let locations: [CLLocationCoordinate2D]
    let locationDidSet: (_ location: CLLocationCoordinate2D) -> Void
    
    final public class Coordinator: NSObject, LocationSelecterViewDelegate {
        private var mapView: LocationSelecterView
        let locationDidSet: (_ location: CLLocationCoordinate2D) -> Void
        

        init(_ mapView: LocationSelecterView, locationDidSet: @escaping (_ location: CLLocationCoordinate2D) -> Void) {
            self.mapView = mapView
            self.locationDidSet = locationDidSet
           
            
        }

        public func locationDidSet(location: CLLocationCoordinate2D) {
            locationDidSet(location)
        
        }
    }

    
    
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self, locationDidSet: locationDidSet)
    }

    
    //多分地図表示
    public func makeUIView(context: Context) -> UILocationSelecterView {
        let locationsSelectView = UILocationSelecterView()
        locationsSelectView.delegate = context.coordinator
        return locationsSelectView
        
    
        
    }

    
    
    //ピンの追加
    public func updateUIView(_ uiView: UILocationSelecterView, context: Context) {
        
        // clear
        uiView.removeAllAnnotations()
        
        // add
        for location in locations {
            uiView.addAnotation(location: location)
        }
    }
}



