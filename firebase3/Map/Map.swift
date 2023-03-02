
//
//  Map2View.swift
//  firebase3
//
//  Created by 大貫 伽奈 on 2023/01/31.
//



import SwiftUI
import MapKit



struct MapView: View {
    
    
    @State var selectColor = 0
    
    @ObservedObject var albumViewModel : AlbumViewModel
    
    
    @ObservedObject var conversionSpot = ConversionSpot()
    
    @State private var location: CLLocationCoordinate2D?  //緯度経度　表示
    //    @State private var locations: [CLLocationCoordinate2D] = []//緯度経度登録　配列　リストとか
    @State private var showingSheet: Bool = false   //画面遷移に
    
    @State var inputText:String = ""
    //    @State var saveinput:String = ""
    
    let weight = UIScreen.main.bounds.width    //スマホの横
    let height = UIScreen.main.bounds.height//スマホの縦　比率維持できる
    
    //継承3
    
    var gpsCheck: Bool
    
    
    var conversionspot = ConversionSpot()
    
    
    @Environment(\.dismiss) var dismiss
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)],animation: .spring()) var results : FetchedResults<Task>
    
    
    
    
    var body: some View {
        ZStack{
            
            LocationSelecterView(selectColor: $selectColor, locations: albumViewModel.mapData) { location in
                self.location = location
            }
            
            VStack{
                
                Spacer()
                if !gpsCheck {
                    
                    
                    Button {
                        selectColor = 1
                        
                        if let location = location {
                            albumViewModel.mapData.append(MapData(id: UUID(), context: albumViewModel.content, color: .red, locations: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)))
                            albumViewModel.latnum = location.latitude
                            albumViewModel.lonnum = location.longitude
                            albumViewModel.color = 0
                            dismiss()
                        }
                        
                    } label: {
                        Text("ピン追加")
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(3)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                    }
                    
                }//if !gpsCheck
                else {
                    
                    
                    Button {
                        selectColor = 1
                        
                        if let location = location {
                            albumViewModel.pin.append(Pin(color: .red, locations: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)))
                            
                            albumViewModel.color = 1
                            dismiss()
                            
                            albumViewModel.gpsLat = location.latitude
                            albumViewModel.gpsLon = location.longitude
                            
                            //ここで追加
                        }
                        
                    } label: {
                        Text("GPSの追加")
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(3)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                    }
                    
                    
                }
                
                
            }//vs
            
            
        }//zs
        
        .sheet(isPresented: $showingSheet) {
            LocationListView(locations: $albumViewModel.locations)
        }//画面遷移　ピンのリスト
        .ignoresSafeArea(.all, edges: .all)
        
        .onAppear {
            
            var x = [CLLocationCoordinate2D]()
            var place : CLLocationCoordinate2D = CLLocationCoordinate2D()
            //for文
            for i in results {
                place.latitude = i.lat
                place.longitude = i.lon
                x.append(place)
                
                guard let content = i.content else { continue }
                
                
            }
            
            albumViewModel.locations=x
            print("========")
            print(results)
            print("========")
            
            
        }
        
        
    }
}

