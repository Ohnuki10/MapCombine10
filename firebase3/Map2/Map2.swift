//
//  Map1.swift  通常表示
//  Museum
//
//  Created by 大貫 伽奈 on 2023/03/03.
//

import SwiftUI
import MapKit

struct Map2: View {
    @State var timer :Timer?
    @ObservedObject var albumViewModel : AlbumViewModel
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)],animation: .spring()) var results : FetchedResults<Task>
    
    
    @StateObject  var manager1 = LocationManager()
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
    
    @State var region = MKCoordinateRegion()
    
    var body: some View {
        
        
        
        
        
        
        ZStack {
            Map(coordinateRegion: $region,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: $trackingMode,
                annotationItems: albumViewModel.mapData,//変更
                annotationContent: { point in MapMarker(coordinate: point.locations, tint: point.color)}
                
            ).edgesIgnoringSafeArea(.bottom)
            
            
            
            
            // 地図を表示　　最初の画面
            //        if gpsCheck == 0 {
            
            
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
                
                VStack {
                    
                    Spacer()
                    
                    
                    let centerPin = albumViewModel.region.center
                    
                  
                    
                    Button {
                        
                        albumViewModel.latnum = region.center.latitude + 0.0000000000001
                        albumViewModel.lonnum = region.center.longitude
                        
                        albumViewModel.color = 0
                        dismiss()
                    } label: {
                        Text("位置情報追加")
                            .font(.title3)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(3)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
                    }
                    
                    
                    Button {
                        
                        dismiss()
                    } label: {
                        Image(systemName: "multiply.circle")
                            .resizable()
                            .frame(width: 25,height: 25)
                            .foregroundColor(.red)
                    }
                    
                    
                }//vs
                
            }
            
        }
        .onAppear {
            region = albumViewModel.region
        }
    }
}

