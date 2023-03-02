//
//  ContentView.swift
//  firebase3
//@Published var posts: [Post] = []//配列？データ入ってる？
//  Created by 大貫 伽奈 on 2023/01/19.


//urlをpost型のところにある配列に入れる

import SwiftUI

struct TabMainView: View {
   
    //1継承
    @StateObject var albumViewModel = AlbumViewModel()


    
   
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)],animation: .spring()) var results : FetchedResults<Task>
    let width = UIScreen.main.bounds.width    //スマホの横
    let height = UIScreen.main.bounds.height//スマホの縦　比率維持できる
    
      

    var body: some View {
        
        TabView {
            //2継承
            
//            MapView(albumViewModel:albumViewModel)
//                .tabItem {
//                    Label("Map1", systemImage: "mappin.and.ellipse")
//                    
//                }
            Map2View(albumViewModel:albumViewModel)
                .tabItem {
                    Label("Map2", systemImage: "mappin.and.ellipse")
                    
                }
            
            AlbumView(viewModel: albumViewModel)
                .tabItem {
                    Label("Collection", systemImage: "building.columns")
                 
                }

            
        }
        .onAppear(perform: {
            print(results)
        })
        .navigationBarBackButtonHidden(true)
       
  
    }
}


//
//struct TabMainView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabMainView()
//    }
//}
