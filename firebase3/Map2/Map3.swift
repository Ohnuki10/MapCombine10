//
//  Map3.swift　　ピン登録
//  Museum
//
//  Created by 大貫 伽奈 on 2023/03/03.
//

import SwiftUI
import MapKit

struct Map3: View {
    @State var timer :Timer?
    @ObservedObject var albumViewModel : AlbumViewModel
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)],animation: .spring()) var results : FetchedResults<Task>
    
    
    @State  var region = MKCoordinateRegion(
    )
    @ObservedObject  var manager = LocationManager()
    
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
    
    //    @State var pin = [Pin]()
    
    @Environment(\.dismiss) var dismiss
        
    
    
    var body: some View {
        // 地図を表示
        ZStack {
            
            Map(coordinateRegion: $region,
                showsUserLocation: true,
                userTrackingMode: $trackingMode,
                annotationItems: albumViewModel.pin,//変更
                annotationContent: { point in MapMarker(coordinate: point.locations, tint: point.color)}
                
            ).edgesIgnoringSafeArea(.bottom)
            
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 25,height: 25)
                    Spacer()
                }
                Spacer()
            }
            
            VStack {
                Spacer()
                
                HStack {
                    
                    Spacer()
                    
                    
                    let centerPin = region.center
                    
                    //                    if !manager.indexCount.isEmpty {
                    //
                    //                        Button {
                    //                            for i in 0..<manager.indexCount.count {
                    //                                if albumViewModel.mapData[manager.indexCount[i]].color != Color.white {
                    //                                albumViewModel.mapData[manager.indexCount[i]].color = Color.white
                    //
                    //                                albumViewModel.lonnum = albumViewModel.mapData[manager.indexCount[i]].locations.longitude
                    //                                albumViewModel.latnum = albumViewModel.mapData[manager.indexCount[i]].locations.latitude
                    //                                albumViewModel.color = 1
                    //                                albumViewModel.writeData(context: context)
                    //
                    //                                albumViewModel.pin = [Pin]()
                    //
                    //
                    //
                    //                                    for i in albumViewModel.mapData {
                    //
                    //                                        let newArray = albumViewModel.mapData.filter { $0.locations.longitude == i.locations.longitude && $0.locations.latitude == i.locations.latitude}
                    //                                        print("ああああああ\(newArray)")
                    //                                        if newArray.count > 1 {
                    //
                    //                                            var b = false
                    //                                            for j in a {
                    //                                                if j.latitude == newArray[0].locations.latitude && j.longitude == newArray[0].locations.latitude {
                    //                                                    b = true
                    //
                    //                                                }
                    //                                            }
                    //                                            if b {
                    //                                                continue
                    //                                            }
                    //                                            a.append(newArray[0].locations)
                    //                                            albumViewModel.pin.append(Pin(color: .white, locations: newArray[0].locations))
                    //
                    //
                    //                                        } else {
                    //
                    //                                            albumViewModel.pin.append(Pin(color: newArray[0].color, locations: newArray[0].locations))
                    //                                        }
                    //
                    //                                    }//
                    //                                }//for
                    //
                    //                                gpsButton = false
                    //
                    //                            }
                    //
                    //                        } label: {
                    //                            Text("ADD")
                    //                                .font(.title2)
                    //                                .background(Color.white.opacity(0.8))
                    //                                .cornerRadius(3)
                    //                                .padding()
                    //                        }
                    //
                    //                    }//if !manager.indexCount.isEmpty　もし近づいたら
                    
                    
                    
                    
                    //                    Button {
                    //
                    //                        isShowing = true
                    //                        gpsButton = true
                    //
                    //                        albumViewModel.latnum = region.center.latitude
                    //                        albumViewModel.lonnum = region.center.longitude
                    //
                    //
                    //                        albumViewModel.pin.append(Pin(color: .red, locations: CLLocationCoordinate2D(latitude: albumViewModel.latnum, longitude:  albumViewModel.lonnum)))
                    //
                    //                        albumViewModel.color = 1
                    //                        dismiss()
                    //
                    //                        gpsCheck = 0
                    //
                    //
                    //
                    //                    } label: {
                    //                        Text("GPS登録")
                    //                            .font(.title)
                    //                            .background(Color.white)
                    //                            .cornerRadius(10)
                    //                            .padding()
                    //                    }
                    //                    .fullScreenCover(isPresented: $isShowing) {
                    //                        Map2View(albumViewModel: albumViewModel, gpsCheck: 1)
                    //
                    //                    }
                    //
                    //
                    //                }//hs
                    
                    Button {
                        
                        albumViewModel.latnum = region.center.latitude
                        albumViewModel.lonnum = region.center.longitude
                        
                        
                        albumViewModel.mapData.append(MapData(id: UUID(), context: albumViewModel.content, color: .red, locations: CLLocationCoordinate2D(latitude: albumViewModel.latnum, longitude: albumViewModel.lonnum)))
                        albumViewModel.color = 0
                        dismiss()
                    } label: {
                        Text("ピン追加")
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(3)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                    }
                    
                    
                }//vs
                
            }
//            .onAppear  {
//                
//                albumViewModel.mapData = [MapData]()
//                for i in results {
//                    
//                    if i.color == 1 {
//                        albumViewModel.mapData.append(MapData(context: i.content ?? "", color: .white, locations: CLLocationCoordinate2D(latitude: i.lat, longitude: i.lon)))
//                    } else {
//                        albumViewModel.mapData.append(MapData(context: i.content ?? "", color: .blue, locations: CLLocationCoordinate2D(latitude: i.lat, longitude: i.lon)))
//                    }
//                }
//                print(albumViewModel.mapData)
//                albumViewModel.fetchRequests(results: results, context:context, lat: 34.38551650988948, lon: 138.7407744967148)
//                timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
//                    
//                    var Count = -1
//                    manager.indexCount = [Int]()
//                    for i in albumViewModel.mapData {
//                        // 距離を
//                        
//                        //coordinate をピンに変更
//                        
//                        var distance = 0.0
//                        
//                        if gpsButton{
//                            
//                            
//                            distance = CLLocationCoordinate2D(latitude: albumViewModel.gpsLat, longitude: albumViewModel.gpsLon).distance(to: CLLocationCoordinate2D(latitude: i.locations.latitude, longitude: i.locations.longitude))
//                            
//                            
//                        } else{
//                            distance = (manager.coordinate?.distance(to: CLLocationCoordinate2D(latitude: i.locations.latitude, longitude: i.locations.longitude))) ?? 500
//                        }
//                        
//                        Count += 1
//                        // ピンの範囲に入ったらaddボタンを表示できるようにする
//                        if distance <= 50 && distance > 0 {
//                            manager.addDistance = true
//                            manager.indexCount.append(Count)
//                            print("おいおおおおお")
//                        } else {
//                            manager.addDistance = false
//                        }
//                        
//                        
//                    }
//                }
//                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                    
//                    albumViewModel.pin = [Pin]()
//                    
//                    print("あああああああああ")
//                    for i in albumViewModel.mapData {
//                        
//                        let newArray = albumViewModel.mapData.filter { $0.locations.longitude == i.locations.longitude && $0.locations.latitude == i.locations.latitude}
//                        print("ああああああ\(newArray)")
//                        if newArray.count > 1 {
//                            
//                            var b = false
//                            for j in a {
//                                if j.latitude == newArray[0].locations.latitude && j.longitude == newArray[0].locations.latitude {
//                                    b = true
//                                    
//                                }
//                            }
//                            if b {
//                                continue
//                            }
//                            a.append(newArray[0].locations)
//                            albumViewModel.pin.append(Pin(color: .white, locations: newArray[0].locations))
//                            
//                            
//                        } else {
//                            
//                            albumViewModel.pin.append(Pin(color: newArray[0].color, locations: newArray[0].locations))
//                        }
//                        
//                        
//                    }//for
//                    
//                }
//                print(albumViewModel.pin)
//                
//                
//                
//            }
            
            
            
        }
    }
    
}
