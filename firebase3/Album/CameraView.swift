//
//  CameraView.swift
//  firebase3
//
//  Created by 大貫 伽奈 on 2023/01/26.
//museum2にカメラのモデルあるよ
// 画像は複数予定？

import Foundation
import SwiftUI

struct CameraView: View {
    
    @Binding var image: Image
    
    @ObservedObject var viewModel : AlbumViewModel
    
    @Binding var imageData : Data//どこに使われているか探そう
    @Binding var source:UIImagePickerController.SourceType
    
    //取り出した写真
    
    @Binding var isActionSheet:Bool
    @Binding var isImagePicker:Bool
    @FocusState var focus:Bool

    
    @State var isShowing = false
    
    
    var body: some View {
        NavigationView {            
            VStack(spacing:0){
                ZStack{
//                    NavigationLink(
//                        destination: Imagepicker(show: $isImagePicker, image: $imageData, viewModel: viewModel, sourceType: source),
//                        isActive:$isImagePicker,
//                        label: {
//                            Text("")
//                        })
                    VStack{
                        HStack(spacing:30){
                            
                            Image(uiImage:viewModel.image ?? UIImage(systemName: "photo")!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60)
                                .cornerRadius(10)
                            Button("ライブラリー"){
                                self.source = .photoLibrary
                                self.isImagePicker.toggle()
                            } .fullScreenCover(isPresented: $isImagePicker) {
                                Imagepicker(show: $isImagePicker, image: $imageData, viewModel: viewModel, sourceType: source)
                            }
                            
                            
                            
                            Button("写真を撮る"){
                                self.source = .camera
                                self.isImagePicker.toggle()
                            }.fullScreenCover(isPresented: $isImagePicker) {
                                Imagepicker(show: $isImagePicker, image: $imageData, viewModel: viewModel, sourceType: source)
                            }
                            
                            
                            
                            //if分でボタンの有無をわける変数
                            Button("位置情報") {
                                isShowing = true
                            }
                            .disabled(viewModel.content == "" ? true : false)
                            //contentが空白ならボタン押せないよ
                            .opacity(viewModel.content == "" ? 0.5 : 1)
                            //contentが空白ならボタン押せないから半透明
                            .fullScreenCover(isPresented: $isShowing) {
                                MapView(albumViewModel: viewModel, gpsCheck: false)
                                
                            }
                            
                            Spacer()
                        }
                        .padding()
                    }
                }
            }
                    
            .onAppear(){
                loadImage()
            }
            .navigationBarTitle("PHOTO", displayMode: .inline)
        }
        
        
    }
    
    var id = UUID()
    //画像のやつ  image
    func loadImage() {
        if imageData.count != 0{
            viewModel.imageData = imageData
            self.viewModel.image = UIImage(data: imageData) ?? UIImage(systemName: "photo")!
        }else{
            self.viewModel.image = UIImage(data: imageData) ?? UIImage(systemName: "photo")!
        }
    }
}


// カメラ　アルバム　画面遷移

//カメラフォルダ開く関係？
struct Imagepicker : UIViewControllerRepresentable {
    
    @Binding var show:Bool
    @Binding var image:Data
    @ObservedObject var viewModel: AlbumViewModel
    
    var sourceType:UIImagePickerController.SourceType
    
    func makeCoordinator() -> Imagepicker.Coodinator {
        
        return Imagepicker.Coordinator(parent: self, viewModel: viewModel)
    }
    
    
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<Imagepicker>) -> UIImagePickerController {
        
        let controller = UIImagePickerController()
        controller.sourceType = sourceType
        controller.delegate = context.coordinator
        
        return controller
    }
    
    
    
    
    
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<Imagepicker>) {
    }
    
    class Coodinator: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
        
        var parent : Imagepicker
        var viewModel: AlbumViewModel
        
        init(parent : Imagepicker, viewModel : AlbumViewModel){
            self.parent = parent
            self.viewModel = viewModel
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.parent.show.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            let image = info[.originalImage] as! UIImage
            let data = image.pngData()
            
            self.parent.image = data!
            loadImage()
            self.parent.show.toggle()
        }
        
        func loadImage() {
            if self.parent.image.count != 0{
                viewModel.imageData = self.parent.image
                viewModel.image = UIImage(data: self.parent.image) ?? UIImage(systemName: "photo")!
            }else{
                viewModel.image = UIImage(data: self.parent.image) ?? UIImage(systemName: "photo")!
            }
        }
    }
    
    
}

