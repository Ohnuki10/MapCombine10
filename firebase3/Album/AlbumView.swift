//
//  AlbumView.swift
//  firebase3
//
//  Created by 大貫 伽奈 on 2023/01/31.
//

import SwiftUI
import Firebase

struct AlbumView: View {
    
    @StateObject var viewModel = ViewModel()
    @ObservedObject var albumViewModel: AlbumViewModel
    
    
//    @State var tableDatas:[TableData] = [TableData(id: 0, message:"this is 0"),TableData(id: 1, message:"this is 1")]
    


    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)){
            
            Color.primary.opacity(0.6)
                .ignoresSafeArea()
            //多分背景の微妙グレー
            
            VStack(spacing:0){
                HStack{
                    Text("アルバム一覧")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    Spacer(minLength: 0)
                }//hs
                .padding()
                .background(Color.white)
                
                
                
//                GeometryReader {geometry in
//
//                    ScrollViewReader{ proxy in
//                        ScrollView {
//                            ForEach(0..<tableDatas.count,id:\.self){ number in
//                                TableView(tableData: tableDatas[number])
//                            }
//                        }
//                    }//なんか知らないけど縦に表示してくれる
//                }//GeometryReader
                
                if albumViewModel.posts.isEmpty{
                    Text("No Memory")
                        .font(.title)
                        .foregroundColor(.primary)
                        .fontWeight(.heavy)
                    Spacer()
                }else{
                    Text("データあるよ")
                        .font(.title)
                        .foregroundColor(.primary)
                        .fontWeight(.heavy)
                    
                                        NavigationView {
                                            List(albumViewModel.posts) { message in
                                                HStack{
                                                    
                                                    if viewModel.nowFilteredImage != nil {
                                                        Image(uiImage: viewModel.nowFilteredImage!)
                                                            .resizable()
                                                            .frame(width: 200, height: 200)
                                                    } else {
                                                        Image("test")
                                                            .resizable()
                                                    }
                                                    
                                            
                                                    
                                                    VStack(alignment: .leading) {
                                                        Text(message.price).font(.title)
                                                        Text(message.title)
                                                     
                                                    }//vs
                                                }//hs
                                            }
                                            .navigationBarTitle("Chat")
//                                                .onAppear() {
//                                                    self.viewModel.fetchData()
//                                                }
                                        }//navi
                    
                }//else
                
                HStack{
                    Spacer()
                   //データとってくるボタンなくせたら良いな
                    Button(action: {
                        viewModel.fetchData(viewModel: albumViewModel)
                    }, label: {
                        Image(systemName: "仮")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(20)
                            .background(Color.green)
                            .clipShape(Circle())
                    })//ボタン
                    
                 
                    
                    //追加画面へいく ＋ボタン　isNewDataがtrueになって画面出現
                    Button(action: {
                        viewModel.isNewData.toggle()
                        //                    tableDatas.append(TableData(id: 2, message: "Good Work"))
                        
                    }, label: {
                        Image(systemName: "plus")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(20)
                            .background(Color.green)
                            .clipShape(Circle())
                    })//ボタン
                    
                }//Hs
                .padding()
            }//vs
            .sheet(isPresented: $viewModel.isNewData, content: {
                NewDataSheet(viewModel: viewModel, albumViewModel: albumViewModel)//画面遷移　データ登録画面へ
            })
        }
        
        
       
        .onAppear{
            print(viewModel.a as Any)// as Anyつけないとワーニング
            if viewModel.a == nil {
                
            } else {
                viewModel.download(url: viewModel.a!) { image in
                    viewModel.nowFilteredImage = image
                }
            }
        }//
    
    }
    
    
    
}


////一行ずつviewとして表示
//struct TableView:View{
//    @State var tableData:TableData
//
//    var onClick:some Gesture{
//        TapGesture(count: 1)
//            .onEnded{_ in
//                print("\(tableData.id) is Clicked ")
//            }
//    }
//
//    var  body: some View{
//        VStack{
//            Text(tableData.message)
//        }
//        .frame(height: 50)
//        .background(Color.green)
//        .gesture(onClick)
//
//
//    }
//
//}
////表示する型の指定
//struct TableData:Codable,Identifiable{
//    var id: Int
//    var message:String
//}




struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView(albumViewModel: AlbumViewModel())
    }
}
