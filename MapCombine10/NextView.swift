//
//  NextView.swift
//  MyCombine4
//
//  Created by 大貫 伽奈 on 2022/09/18.
//

import SwiftUI
import MapKit


struct NextView: View {
    @State var name: String = "Hello World"
    
    
    
    
    @State var inputText:String = ""
    @State var location:String = ""
    @State var dispMapType:MKMapType = .standard
    
    var body: some View {
        VStack{
            
            Text(name).font(.system(size: 20))
            
            
            TextField("検索",
                      text: $inputText , onCommit: {
                        name = inputText
                        print("入力したキーワード：" + location)
                      })

            ZStack(alignment: .bottomTrailing){
                MapView(searchKey: name,mapType: dispMapType)
                
                HStack{
                    
    
                    
                Button(action: {
                    if dispMapType == .standard {
                        dispMapType = .satellite
                    } else if dispMapType == .satellite {
                        dispMapType = .hybrid
                    } else if dispMapType == .hybrid {
                        dispMapType = .satelliteFlyover
                    } else if dispMapType ==
                                .satelliteFlyover{
                        dispMapType = .hybridFlyover
                    } else if dispMapType ==
                                .hybridFlyover {
                        dispMapType = .mutedStandard
                    } else {
                        dispMapType = .standard
                    }
                }){
                    Image(systemName: "map")
                        .resizable()
                        .frame(width: 35.0, height:35.0, alignment: .leading)
                    
                }
                .padding(.trailing, 20.0)
                .padding(.bottom, 30.0)
                    
                
                }//HS
            }//ZStavk
            Text("--MEMO--")
            MemoView()
        }//VS
    }
}

struct NextView_Previews: PreviewProvider {
    static var previews: some View {
        NextView()
    }
}
