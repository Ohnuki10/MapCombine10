//
//  Map2View.swift
//  firebase3
//
//  Created by 大貫 伽奈 on 2023/01/31.
//

import SwiftUI
import MapKit


struct Map2View: View {
    @State private var location: CLLocationCoordinate2D?  //緯度経度　表示
    @State private var locations: [CLLocationCoordinate2D] = []//緯度経度登録　配列　リストとか
    @State private var showingSheet: Bool = false   //画面遷移に

    //継承3
    @ObservedObject var viewModel2 = Map2ViewModel()
    
    
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            LocationSelecterView(locations: locations) { location in
                self.location = location
                
               
            }
            
            HStack {
                VStack(alignment: .leading) {
                    if let location = location {
                        Text("latitude: \(location.latitude)")
                        Text("longitude: \(location.longitude)")
                    }
                }//vs
                
                Spacer()
                                
                Button {
                    //登録途中
                    locations = []
                    
                } label: {
                    Text("Clear")
                }
                
                Button {
                    if let location = location {
                        locations.append(location)
                    }
                } label: {
                    Text("Add")
                }

                Button {
                    showingSheet = true
                } label: {
                    Text("List")
                }
            }//hs
            .padding(.horizontal, 16)
            .padding(.bottom, 60)
           
           
        }//zs
        .sheet(isPresented: $showingSheet) {
            LocationListView(locations: $locations)
        }//画面遷移　ピンのリスト
        .ignoresSafeArea(.all, edges: .all)
    }
}
