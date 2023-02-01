//
//  ContentView.swift
//  firebase3
//@Published var posts: [Post] = []//配列？データ入ってる？
//  Created by 大貫 伽奈 on 2023/01/19.
//

import SwiftUI
import Firebase

struct TabMainView: View {
    //1継承
    @StateObject var albumViewModel = AlbumViewModel()
    init() {
        UITabBar.appearance().backgroundColor = .white
        
    }
    

    var body: some View {
        
        TabView {
            //2継承
            Map1View(albumViewModel: albumViewModel)
                .tabItem {
                    Label("Map1", systemImage: "pawprint.fill")
                    
                }
            
            Map2View()
                .tabItem {
                    Label("Map2", systemImage: "pawprint.fill")
                    
                }
            
            AlbumView(albumViewModel: albumViewModel)
                .tabItem {
                    Label("Collection", systemImage: "pawprint.fill")
                    
                }
            
        }
  
    }
}



struct TabMainView_Previews: PreviewProvider {
    static var previews: some View {
        TabMainView()
    }
}
