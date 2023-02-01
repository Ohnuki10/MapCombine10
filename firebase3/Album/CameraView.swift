//
//  CameraView.swift
//  firebase3
//
//  Created by 大貫 伽奈 on 2023/01/26.

// 画像は複数予定？

import Foundation
import FirebaseStorage
import Firebase
import SwiftUI

struct CameraView: View {
   
   @ObservedObject var viewModel : ViewModel
    @ObservedObject var viewModel2 = AlbumViewModel()
    
   @Binding var imageData : Data//どこに使われているか探そう
   @Binding var source:UIImagePickerController.SourceType
   
    //取り出した写真

   @Binding var isActionSheet:Bool
   @Binding var isImagePicker:Bool
    
    
    
   
   var body: some View {
       NavigationView {
           VStack(spacing:0){
               ZStack{
                   NavigationLink(
                    destination: Imagepicker(show: $isImagePicker, image: $imageData, sourceType: source),
                    isActive:$isImagePicker,
                    label: {
                        Text("")
                    })
                   VStack{
                       HStack(spacing:30){
                           Text("photo")
                           Image(uiImage: viewModel.image ?? UIImage(systemName: "photo")!)
                               .resizable()
                               .aspectRatio(contentMode: .fill)
                               .frame(width: 60, height: 60)
                               .cornerRadius(10)
                           Button(action: {
                               self.source = .photoLibrary
                               self.isImagePicker.toggle()
                           }, label: {
                               Text("ライブラリー")
                           })
                           Button(action: {
                               self.source = .camera
                               self.isImagePicker.toggle()
                           }, label: {
                               Text("写真を撮る")
                           })
                           Spacer()
                       }
                       .padding()
                   }
               }
           }
           .onAppear(){
               loadImage()
           }
           .navigationBarTitle("Add Task", displayMode: .inline)
       }
   }
   
   func loadImage() {
       if imageData.count != 0{
           viewModel.imageData = imageData
           viewModel.image = UIImage(data: imageData) ?? UIImage(systemName: "photo")!
       }else{
           viewModel.image = UIImage(data: imageData) ?? UIImage(systemName: "photo")!
       }
   }
    
    var id = UUID()
    //画像のやつ  image
     
    
}


//カメラフォルダ開く関係？
struct Imagepicker : UIViewControllerRepresentable {
   
   @Binding var show:Bool
   @Binding var image:Data
   
   var sourceType:UIImagePickerController.SourceType

   func makeCoordinator() -> Imagepicker.Coodinator {
       
       return Imagepicker.Coordinator(parent: self)
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
       
       init(parent : Imagepicker){
           self.parent = parent
       }
       
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           self.parent.show.toggle()
       }
       
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           
           let image = info[.originalImage] as! UIImage
           let data = image.pngData()
           
           self.parent.image = data!
           self.parent.show.toggle()
       }
   }
}

