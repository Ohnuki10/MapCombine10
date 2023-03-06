//最新　これ使う
//  AlbumView.swift
//  firebase3
//
//  Created by 大貫 伽奈 on 2023/01/31.
//

import SwiftUI
import MapKit




struct AlbumView: View {
    
    //    @StateObject var viewModel = AlbumViewModel()
    @ObservedObject var albumViewModel: AlbumViewModel
    
    @State var isNewData2 = false
    
    @Binding var region: MKCoordinateRegion
    @Binding var pin: [Pin]
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)],animation: .spring()) var results : FetchedResults<Task>
    //ここにデータ入ってる　Foreachで回している
    
    
    @State var nowDate = Date()
    @State var dateText = ""
    private let dateFormatter = DateFormatter()
    
    @Environment(\.managedObjectContext) var context
    
    
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
            
            NavigationView{
                VStack(spacing:0){
                    if albumViewModel.foryou.isEmpty{
                        Spacer()
                        Text("-NO DATA-")
                            .font(.title)
                            .foregroundColor(.primary)
                            .fontWeight(.heavy)
                        Spacer()
                    }else{
                        
                        //ForYou
                        
                        Divider()
                        Text("-Pickup-")
                            .foregroundColor(.green)
                        VStack(alignment: .leading, spacing: 5, content: {
                            
                            Divider()
                            HStack{
                                Spacer()
                                //イメージデータの表示
                                if !albumViewModel.foryou.isEmpty {
                                    if let image = albumViewModel.foryou[albumViewModel.random].image {
                                        Image(uiImage: UIImage(data: image) ?? UIImage(cgImage: "Tab3" as! CGImage))
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 80, height: 80)
                                            .cornerRadius(10)
                                        
                                            
                                    }
                                }
                                
                                
                                
                                VStack{
                                    Text(albumViewModel.foryou[albumViewModel.random].date ,style: .date)//日付表示
                                        .fontWeight(.bold)
                                    
                                    HStack {
//                                        Text("メモテキスト：")
//                                            .fontWeight(.bold)
//                                        Text(albumViewModel.foryou[albumViewModel.random].memoText )
//                                            .fontWeight(.bold)
                                        Text(albumViewModel.foryou[albumViewModel.random].title )
                                            .fontWeight(.bold)
                                    }
                                    
                                }//vs
                                
                                
                                Spacer()
                                
                            }//hs
                            //
                            
                            Divider()
                        })
                        .foregroundColor(.primary)
                        .background(.green.opacity(0.1))
                        
                        
                        
                        
                        
                        ScrollView(.vertical,showsIndicators: false, content:{
                            LazyVStack(alignment: .leading, spacing: 20){//LazyVStack　必要なとこだけ読み込む?
                                
                                ForEach(results){task in
                                    if task.imageData != nil && task.content != ""{
                                        VStack(alignment: .leading, spacing: 5, content: {
                                            HStack{
                                                //イメージデータの表示
                                                if task.imageData?.count ?? 0 != 0{
                                                    Image(uiImage: UIImage(data: task.imageData ?? Data.init())!)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 80, height: 80)
                                                        .cornerRadius(10)
                                                }
                                                VStack{
                                                    Text(task.date ?? Date(),style: .date)//日付表示
                                                        .font(.subheadline)
                                                    //                                                Text("優先度?：\(task.priority)")
                                                    //                                                    .fontWeight(.bold)
                                                    HStack {
                                                        Text("メモ：")
                                                            .fontWeight(.bold)
                                                        Text(task.memoText ?? "")
                                                            .fontWeight(.bold)
                                                    }
                                                }//vs
                                            }//hs
                                            .padding(.horizontal)
                                            
                                            Text(task.content ?? "")//content(書き込み内容)表示
                                                .font(.title)
                                                .fontWeight(.bold)
                                                .padding(.horizontal)
                                            Divider()
                                        })
                                        .foregroundColor(.primary)
                                        .contextMenu{//長押ししたら出現
                                            Button(action: {
                                                albumViewModel.EditItem(item: task)
                                                isNewData2.toggle()
                                                
                                            }, label: {
                                                Text("編集")
                                            })
                                            Button(action: {
                                                context.delete(task)
                                                try! context.save()
                                                albumViewModel.ForYou(results: results)
                                            }, label: {
                                                Text("削除")
                                            })
                                        }//長押しで出てくるボタン
                                    }
                                }
                            }
                            .padding()
                        })//scrollview
                    }
                }///vs
                .navigationBarTitle("アルバム一覧", displayMode: .inline)
                
            }//navigationView
            
            //追加画面へいく ＋ボタン　isNewDataがtrueになって画面出現
            Button(action: {albumViewModel.isNewData.toggle()}, label: {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .padding()
            })
            
        })
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.primary.opacity(0.06).ignoresSafeArea(.all, edges: .all))
        
        .sheet(isPresented: $albumViewModel.isNewData,//画面遷移
               onDismiss:{  //sheet閉じたら処理実行
            viewModelValueReset()
        },
               content: {
            NewDataSheet(viewModel: albumViewModel, modal: $isNewData2, region: $region, pin: $pin)//画面遷移データ登録画面へ
        })
        .sheet(isPresented: $isNewData2,//画面遷移
               onDismiss:{  //sheet閉じたら処理実行
            viewModelValueReset()
        },
               content: {
            EditDataSheet(viewModel: albumViewModel, content: albumViewModel.content, memoText: albumViewModel.memoText, modal: $isNewData2, region: $albumViewModel.region, image2: Image(systemName: "photo"))
        })
        .onAppear {
            albumViewModel.ForYou(results: results)
            print(results)
            print(albumViewModel.foryou)
        }
    }
    
    //一時的なデータは削除　　また記入できるように削除
    func viewModelValueReset(){
        albumViewModel.updateItem = nil
        albumViewModel.content = ""
        albumViewModel.date = Date()
        albumViewModel.imageData = Data.init()
        albumViewModel.memoText = ""
    }
    
}





//List {
//    ForEach(0 ..< locations.count, id: \.self) { index in
//        VStack(alignment: .leading) {
//            Text("lat: \(locations[index].latitude.description)")
//            Text("lon: \(locations[index].longitude.description)")
//        }
//    }
//}
