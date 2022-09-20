//
//  ContentView.swift
//  MyCombine4
//
//  Created by cmStudent on 2022/07/12.
//

import SwiftUI
import Foundation


struct ContentView: View {
    @State var showSafari = false
    @StateObject var viewModel = ArticleViewModel()
    
    var body: some View {
        VStack{
            Text("都道府県リスト")
        NavigationView {
            VStack{
                
                List(viewModel.prefectureInputs.prefecture, id: \.self) { item in
                    NavigationLink(destination: NextView(name: item)) {
                        Text(item)
                    }
                }
            }//vs
        }//navi
        }
    }//View
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
