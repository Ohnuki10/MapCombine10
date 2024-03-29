//
//  NewDataSheet.swift
//  firebase3
//addボタン押したやつの位置情報を新たに登録　
//  Created by 大貫 伽奈 on 2023/01/19.
//

import SwiftUI
import MapKit
struct NewDataSheet: View {
    @ObservedObject var viewModel: AlbumViewModel
//    @ObservedObject var albumViewModel: AlbumViewModel
    
    @State var addnowBool = false
    @State var imageData : Data = .init(capacity:0)//@stateのイメージデータ
    @State var isActionSheet = false
    @State var isImagePicker = false
    @State var source:UIImagePickerController.SourceType = .photoLibrary
    
    @Binding var modal: Bool
    
    @State private var image = UIImage()
    
    @FocusState var focus: Bool
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)],animation: .spring()) var results : FetchedResults<Task>
    
    @Binding var region: MKCoordinateRegion
    @Binding var pin: [Pin]
    
    //コアデータから移植
       
        @Environment(\.managedObjectContext) var context
        @State private var image2 = Image(systemName: "photo")
    
    
    @State var isShowing = false
    
    let weight = UIScreen.main.bounds.width    //スマホの横
    let height = UIScreen.main.bounds.height//スマホの縦　比率維持できる
    
    var body: some View {
        
        ZStack {
            
            VStack{
              
                
                
                
                HStack{
                    
                    CameraView(image: $image2,viewModel: viewModel, imageData: $imageData, source: $source, isActionSheet: $isActionSheet, isImagePicker: $isImagePicker)
                       
                    
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
                
                
                
                Text("タイトル")
                    .opacity(0.8)
                TextEditor(text: $viewModel.content)//書き込む空白
                
                
                    
                    .frame(height: height/8)
                    .focused($focus)
                Text("詳細文")
                    .opacity(0.8)
                TextEditor(text: $viewModel.memoText)//書き込む空白
                    .frame(height: height/4)
                    .focused($focus)
                
                
                Button {
                    isShowing = true
                    addnowBool=true
                } label: {
                 Text("位置情報追加")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width:UIScreen.main.bounds.width - 30)
                        .background(Color.green)
                        .cornerRadius(5)
                    
                }
                .fullScreenCover(isPresented: $isShowing) {
                    Map2(albumViewModel: viewModel, gpsCheck: 2)
                }
                
                
                //線
                Divider()
                    .padding(.horizontal)
                
                
                HStack{

                    Text("")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                
                
                
                
                Button(action: {
                    viewModel.id = UUID()
                    viewModel.writeData(context: context)
                    viewModel.ForYou(results: results)
                    print("aaaaidosiいいいい")
                    print(results)
                    addnowBool = false
                    modal = false
                }, label: {
                    Label(title:{Text(viewModel.updateItem == nil ? "登録" : "編集完了")//新規か再編集か　updateItemの中身で判断
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
                    .background(Color.blue)
                    .cornerRadius(5)
//      
                })//button　追加
                .disabled(((viewModel.memoText == "")||(viewModel.content == "")||(viewModel.image == UIImage(systemName: "photo")||(addnowBool == false))) ? true : false)
                //contentが空白ならボタン押せないよ
                .opacity(((viewModel.memoText == "")||(viewModel.content == "")||(viewModel.image == UIImage(systemName: "photo")||(addnowBool == false))) ? 0.5 : 1)
                
                .padding()
               
                
            }//vs
            .background(Color.primary.opacity(0.06).ignoresSafeArea(.all, edges: .bottom))
            .onTapGesture {
                focus = false
            }
            //バックグラウンドの微妙グレー
        }
    }
    

    
    
    
}
