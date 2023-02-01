//
//  NewDataSheet.swift
//  firebase3
//
//  Created by 大貫 伽奈 on 2023/01/19.
//

import SwiftUI

struct NewDataSheet: View {
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var viewModel2 = AlbumViewModel()
    @ObservedObject var albumViewModel: AlbumViewModel
    
    @State var imageData : Data = .init(capacity:0)//@stateのイメージデータ
    @State var isActionSheet = false
    @State var isImagePicker = false
    @State var source:UIImagePickerController.SourceType = .photoLibrary
    
    @State private var image = UIImage()
    
    
    var body: some View {
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
                CameraView(viewModel: viewModel, imageData: $viewModel.imageData, source: $source, isActionSheet: $isActionSheet, isImagePicker: $isImagePicker)
                    .padding(.top,50)
                //後で必ず直す　2022
                NavigationLink(
                    destination: Imagepicker(show: $isImagePicker, image: $viewModel.imageData, sourceType: source),
                    isActive:$isImagePicker,
                    label: {
                        Text("")
                    })//navi
                
            }
                
                
                
                TextEditor(text: $viewModel.content)//書き込む空白
                    .padding()
                Divider()
                    .padding(.horizontal)
          
            
            HStack{
                Text("いつ行った？")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }
            .padding()
//            DatePicker("", selection:$viewModel.date, displayedComponents:.date)//日付も使用する場合は”displayedComponents:.date”をなくす
//                    .labelsHidden()
        
            
            //＋Addボタン writeDataデータ追加
            Button(action: {
                //メソッドデータ追加
                viewModel.uploadPost(title: viewModel.content, price: "テスト")
                viewModel.UploadImage()
                
            }, label: {
//                Label(title:{Text(viewModel.updateItem == nil ? "Add" : "Update")
                Label(title:{Text("Add")
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
            })// +Addボタン
            .padding()
//            .disabled(viewModel.content == "" ? true : false) //contentが空白ならボタン押せないよ
//            .opacity(viewModel.content == "" ? 0.5 : 1)//contentが空白ならボタン押せないから半透明
        }//vs
        .background(Color.primary.opacity(0.06).ignoresSafeArea(.all, edges: .bottom))
        //バックグラウンドの微妙グレー
    }
}
