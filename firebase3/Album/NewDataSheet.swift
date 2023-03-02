//
//  NewDataSheet.swift
//  firebase3
//addボタン押したやつの位置情報を新たに登録　
//  Created by 大貫 伽奈 on 2023/01/19.
//

import SwiftUI

struct NewDataSheet: View {
    @ObservedObject var viewModel: AlbumViewModel
//    @ObservedObject var albumViewModel: AlbumViewModel
    
    @State var imageData : Data = .init(capacity:0)//@stateのイメージデータ
    @State var isActionSheet = false
    @State var isImagePicker = false
    @State var source:UIImagePickerController.SourceType = .photoLibrary
    
    @State private var image = UIImage()
    
    @FocusState var focus: Bool
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)],animation: .spring()) var results : FetchedResults<Task>
    
    //コアデータから移植
       
        @Environment(\.managedObjectContext) var context
        @State private var image2 = Image(systemName: "photo")
    
    let weight = UIScreen.main.bounds.width    //スマホの横
    let height = UIScreen.main.bounds.height//スマホの縦　比率維持できる
    
    var body: some View {
        
        ZStack {
            
            VStack{
                HStack{
                    //                Text("\(viewModel.updateItem == nil ? "Add New" : "Update") Memory")
                    //新規か再編集か　updateItemの中身で判断
                    
                    Text("Memory")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                }//hs
                .padding()
                
                
                
                HStack{
                    //                    CameraView(viewModel: viewModel, imageData: $viewModel.imageData, source: $source, isActionSheet: $isActionSheet, isImagePicker: $isImagePicker)
                    //                        .padding(.top,50)
                    
                    CameraView(image: $image2, viewModel: viewModel, imageData: $imageData, source: $source, isActionSheet: $isActionSheet, isImagePicker: $isImagePicker)
                        .padding(.top,50)
                    
                    //後で必ず直す　2022
                    NavigationLink(
                        destination: Imagepicker(show: $isImagePicker, image: $viewModel.imageData, viewModel: viewModel, sourceType: source),
                        isActive:$isImagePicker,
                        label: {
                            Text("")
                        })//navi
                    
                }
                .onTapGesture {
                    focus = false
                }
                
                
                
                TextEditor(text: $viewModel.content)//書き込む空白
                    .padding()
                    .frame(height: height/8)
                    .focused($focus)
                
                TextEditor(text: $viewModel.memoText)//書き込む空白
                    .padding()
                    .frame(height: height/4)
                    .focused($focus)
                
                
                //線
                Divider()
                    .padding(.horizontal)
                
                
                HStack{
                    //                Text("いつ行った？")
                    Text("")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                
                
                
                
                Button(action: {
                    viewModel.writeData(context: context)
                    viewModel.ForYou(results: results)
                }, label: {
                    Label(title:{Text(viewModel.updateItem == nil ? "Add Now" : "Update")//新規か再編集か　updateItemの中身で判断
                            .font(.title)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    },
                          icon: {Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.white)
                    })
                    .padding(.vertical)
                    .frame(width:UIScreen.main.bounds.width - 30)
                    .background(Color.orange)
                    .cornerRadius(50)
                })//button　追加
                .padding()
                //contentが空白ならボタン押せないから半透明
                
            }//vs
            .background(Color.primary.opacity(0.06).ignoresSafeArea(.all, edges: .bottom))
            .onTapGesture {
                focus = false
            }
            //バックグラウンドの微妙グレー
        }
    }
    

    
    
    
}
