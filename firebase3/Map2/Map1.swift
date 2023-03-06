//
//  Map1.swift  通常表示
//  Museum
//
//  Created by 大貫 伽奈 on 2023/03/03.
//

import SwiftUI
import MapKit

struct Map1: View {
    @State var timer :Timer?
    @ObservedObject var albumViewModel : AlbumViewModel
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)],animation: .spring()) var results : FetchedResults<Task>
    
    
    @StateObject var manager = LocationManager()
    @State  var a = [CLLocationCoordinate2D]()
    
    
    // 0: 通常 1: GPS登録 2: ピン登録
    @State var gpsCheck: Int
    
    // ユーザートラッキングモードを追従モードにするための変数を定義
    @State  var trackingMode = MapUserTrackingMode.follow
    
    
    @State var pointList = [
        Point(latitude: 35.69735612272055,  longitude: 139.6978333184864, color: .orange),
        Point(latitude: 35.711554715026265, longitude: 139.81371829999996, color: .orange),
        Point(latitude: 35.712527719026265, longitude: 139.81071829999996, color: .orange)
    ]
    
    @State var isShowing = false
    
    @State var gpsButton =  false
    
    //        @State var pin = [Pin]()
    
    @Environment(\.dismiss) var dismiss
    
    
    
    var body: some View {
        
        
        
        
        
        
        ZStack {
            Map(coordinateRegion: $albumViewModel.region,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: $trackingMode,
                annotationItems: albumViewModel.mapData,//変更
                annotationContent: { point in MapMarker(coordinate: point.locations, tint: point.color)}
                
            ).edgesIgnoringSafeArea(.bottom)
            
            
            
            
            // 地図を表示　　最初の画面
            //        if gpsCheck == 0 {
            
            
            VStack {
                Spacer()
                
                HStack {
                    
                    Spacer()
                    
                    
                    if !manager.indexCount.isEmpty {
                        
                        Button {
                            for i in 0..<manager.indexCount.count {
                                if albumViewModel.mapData[manager.indexCount[i]].color != Color.white {
                                    albumViewModel.color = 1
                                    albumViewModel.fetchRequests(results: results, context: context, id: albumViewModel.mapData[manager.indexCount[i]].id)
                                }//for
                            }
                            
                            albumViewModel.mapData = [MapData]()
                            for i in results {
                                
                                if i.color == 1 {
                                    albumViewModel.mapData.append(MapData(id: i.id ?? UUID(), context: i.content ?? "", color: .white, locations: CLLocationCoordinate2D(latitude: i.lat, longitude: i.lon)))
                                } else {
                                    albumViewModel.mapData.append(MapData(id: i.id ?? UUID(), context: i.content ?? "", color: .blue, locations: CLLocationCoordinate2D(latitude: i.lat, longitude: i.lon)))
                                }
                                print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
                                print(albumViewModel.mapData)
                            }
                            
                            gpsButton = false
                            
                            
                        } label: {
//                            Text("WhitePin")
//                                .font(.title2)
//                                .background(Color.white.opacity(0.8))
//                                .cornerRadius(3)
//                                .padding()
                            
                            Image(systemName: "mappin.circle")
                                .resizable()
                                .foregroundColor(.white)
                                .background(.blue)
                                .frame(width: 30,height: 30)
                                .cornerRadius(50)
                        }
                        
                    }//if !manager.indexCount.isEmpty　もし近づいたら
                    
                    
                    
                    
                    Button {
                        
                        isShowing = true
                        gpsButton = true
                        //
                        //                            albumViewModel.latnum = albumViewModel.region.center.latitude
                        //                            albumViewModel.lonnum = albumViewModel.region.center.longitude
                        //
                        //
                        //
                        //
                        //                            albumViewModel.color = 1
                        
                        
                        
                        albumViewModel.color = 0
                        dismiss()
                        manager.indexCount = [Int]()
                        
                        
                    } label: {
                        Text("仮現在地を追加")
                            .font(.title)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding()
                    }
                    .fullScreenCover(isPresented: $isShowing) {
                        
                        Map3(albumViewModel: albumViewModel, gpsCheck: 1)
                    }
                    
                    
                }//hs
                
                
                
            }//vs
            .onAppear  {
                
                albumViewModel.mapData = [MapData]()
                for i in results {

                    if i.color == 1 {
                        albumViewModel.mapData.append(MapData(id: i.id ?? UUID(), context: i.content ?? "", color: .white, locations: CLLocationCoordinate2D(latitude: i.lat, longitude: i.lon)))
                    } else {
                        albumViewModel.mapData.append(MapData(id: i.id ?? UUID()
                                                              , context: i.content ?? "", color: .blue, locations: CLLocationCoordinate2D(latitude: i.lat, longitude: i.lon)))
                    }
                }
                print(albumViewModel.mapData)
                timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                    print("あああ\(albumViewModel.mapData)")
                    var Count = -1
                    manager.indexCount = [Int]()
                    for i in albumViewModel.mapData {
                        // 距離を

                        //coordinate をピンに変更

                        var distance = 0.0

                        if gpsButton{


                            distance = CLLocationCoordinate2D(latitude: albumViewModel.gpsLat, longitude: albumViewModel.gpsLon).distance(to: CLLocationCoordinate2D(latitude: i.locations.latitude, longitude: i.locations.longitude))


                        } else{
                            distance = (manager.coordinate?.distance(to: CLLocationCoordinate2D(latitude: i.locations.latitude, longitude: i.locations.longitude))) ?? 500
                        }

                        Count += 1
                        // ピンの範囲に入ったらaddボタンを表示できるようにする
                        if distance <= 50 && distance > 0 {
                            if albumViewModel.mapData[Count].color == .blue {
                                manager.addDistance = true
                                manager.indexCount.append(Count)
                            }
                            print("おいおおおおお")
                        } else {
                            manager.addDistance = false
                        }


                    }
                }

            }
        }
    }
    
}
