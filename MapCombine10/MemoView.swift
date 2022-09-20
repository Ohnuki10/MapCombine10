//
//  MemoView.swift
//  MyCombine4
//
//  Created by 大貫 伽奈 on 2022/09/20.
//

import SwiftUI
let w = UIScreen.main.bounds.width

struct MemoView: View {
    @State var items = ["北海道", "新宿駅", "東京タワー", "東京スカイツリー"]
    @State var inputMemo:String = ""
    @State var Memo:String = ""
    
   
    
    var body: some View {
        VStack{
  
            
            ScrollView {
                ForEach(items, id: \.self) { item in
                    Text(item)
                }
            }
            
            HStack{
                Spacer().frame( width: w*0.05)
                TextField("Memo",
                          text: $inputMemo , onCommit: {
                    
                })
                
                
                
                Button{
                    Memo = inputMemo
                    print(Memo)
                    items.append(Memo)
                   
                    inputMemo = ""
                }label: {
                    Text("保存")
                }
                Spacer().frame( width: w*0.05)
            }//HS
        }//VS
        
    }
}

struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoView()
    }
}
