////
////  File.swift
////  firebase3
////
////  Created by 大貫 伽奈 on 2023/01/26.
////
//
//.actionSheet(isPresented: $viewModel.isShowActionSheet){
//            actionSheet
//        }
//        .sheet(isPresented: $viewModel.isShowImagePickerView){
//            ImagePicker(isShown: $viewModel.isShowImagePickerView,
//                        image: $viewModel.image,
//                        sourceType: viewModel.selectedSourceType)
//        }
//        .alert(isPresented: $viewModel.isShowAlert) {
//            Alert(title: Text(viewModel.alertTitle))
//        }
//
//
//
//
//
//
//
//
//import SwiftUI
//import Combine
//import Firebase
//import FirebaseAuth
//import FirebaseStorage
//
//final class FilterContentViewModel: NSObject, ObservableObject {
//    enum Inputs {
//        case onAppear
//        case tappedActionSheet(selectType: UIImagePickerController.SourceType)
//        case tappedSaveIcon
//    }
//    
//    
//    @Published var image: UIImage?
//    @Published var isShowActionSheet = false
//    @Published var isShowImagePickerView = false
//    @Published var isShowBanner = false
//    @Published var startFilteredImage: UIImage?
//    @Published var nowFilteredImage: UIImage?
//    
//    @Published var filterImage = false
//    // フィルターバナー表示用フラグ
//    @Published var selectedSourceType: UIImagePickerController.SourceType = .camera
//    
//    
//    
//    var cancellables: [Cancellable] = []
//    
//    var alertTitle: String = ""
//    // アラートを表示するためのフラグ
//    @Published var isShowAlert = false
//    
//    @AppStorage("first") var firstStart = true
//    @AppStorage("start") var startDownloadURL: URL?
//    @AppStorage("now") var nowDownloadURL: URL?
//    
//    override init() {
//        super.init()
//        // $をつけている（状態変数として使う→今回はPublished→Publisher）
//        let imageCancellable = $image.sink { [weak self]
//            (String) in
//            guard let self = self, let string = String else { return }
//            
//            if self.filterImage {
//                self.nowFilteredImage = string
//            } else {
//                self.startFilteredImage = string
//            }
//        }
//        // applyingFilterが更新されたら？
//        
//        cancellables.append(imageCancellable)
//    }
//    
//    func UploadImage(){
//        guard let uid = Auth.auth().currentUser?.uid else {
//            return print("ログインできてません")
//        }
//        let startPath = "\(uid)/startPhoto.png"
//        let nowPath = "\(uid)/nowPhoto.png"
//        let storage = Storage.storage()
//        let reference = storage.reference()
//        let startImageRef = reference.child(startPath)
//        let nowImageRef = reference.child(nowPath)
//        
//        guard let startData = startFilteredImage!.pngData() else {
//            return
//        }
//        guard let nowData = nowFilteredImage!.pngData() else {
//            return
//        }
//        let startUploadTask = startImageRef.putData(startData)
//        let nowUploadTask = nowImageRef.putData(nowData)
//        
//        
//        startUploadTask.observe(.success) { _ in
//            startImageRef.downloadURL { url, error in
//                if let url = url {
//                    self.startDownloadURL = url
//                    
//                }
//            }
//        }
//        startUploadTask.observe(.failure) { snapshot in
//            if let message = snapshot.error?.localizedDescription {
//                print(message)
//            }
//        }
//        nowUploadTask.observe(.success) { _ in
//            nowImageRef.downloadURL { url, error in
//                if let url = url {
//                    self.nowDownloadURL = url
//                }
//            }
//        }
//        nowUploadTask.observe(.failure) { snapshot in
//            if let message = snapshot.error?.localizedDescription {
//                print(message)
//            }
//        }
//        
//        print(nowDownloadURL)
//    }
//    
//    func downloadImageAsync(url: URL, completion: @escaping (UIImage?) -> Void) {
//        let session = URLSession(configuration: .default)
//        let _ = "3"
//        let task = session.dataTask(with: url) { (data, _, _) in
//            var image: UIImage?
//            if let imageData = data {
//                image = UIImage(data: imageData)
//            }
//            DispatchQueue.main.async {
//                completion(image)
//            }
//        }
//        task.resume()
//    }
//    
//    func apply(_ inputs: Inputs) {
//        switch inputs {
//        case .onAppear:
//            if image == nil {
//                isShowActionSheet = true
//            }
//        case .tappedActionSheet(let sourceType):
//            selectedSourceType = sourceType
//            isShowImagePickerView = true
//        case .tappedSaveIcon:
//            // 画像を保存する処理
//            if filterImage {
//                UIImageWriteToSavedPhotosAlbum(nowFilteredImage!, self, #selector(imageSaveCompletion(_: didFinishSavingWithError:contextInfo: )), nil)
//            } else {
//                UIImageWriteToSavedPhotosAlbum(startFilteredImage!, self, #selector(imageSaveCompletion(_: didFinishSavingWithError:contextInfo: )), nil)
//            }
//            break
//        }
//    }
//    
//    @objc func imageSaveCompletion(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
//        alertTitle = error == nil ? "画像が保存されました" : error?.localizedDescription ?? ""
//        isShowAlert = true
//    }
//}
//
//struct ImagePicker {
//    @Binding var isShown: Bool
//    @Binding var image: UIImage?
//    
//    var sourceType: UIImagePickerController.SourceType
//}
//
//extension ImagePicker: UIViewControllerRepresentable{
//    typealias UIViewControllerType = UIImagePickerController
//    
//    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>)
//    -> UIImagePickerController {
//        
//        // ImagePickerを作成
//        let imagePicker = UIImagePickerController()
//        // sourceTypeを代入
//        imagePicker.sourceType = sourceType
//        // coordinatorをdelegateに代入
//        imagePicker.delegate = context.coordinator
//        return imagePicker
//    }
//    
//    func updateUIViewController(_ uiViewController: UIImagePickerController,
//                                context: UIViewControllerRepresentableContext<ImagePicker>) {}
//    
//    // 任意のインスタンスをCoordinatorとして返すことができる
//    // UIImagePickerControllerDelegateを準拠する型のインスタンスを返している
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(parent: self)
//    }
//    
//}
//
//final class Coordinator: NSObject,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
//    // ImagePickerのプロパティにアクセスするため
//    let parent: ImagePicker
//    
//    init(parent: ImagePicker) {
//        self.parent = parent
//    }
//    // UIImagePickerControllerDelegateメソッドを実装
//    // Image Pickerで画像が選ばれた場合に呼ばれるメソッド
//    func imagePickerController(_ picker: UIImagePickerController,
//                               didFinishPickingMediaWithInfo info:
//                               [UIImagePickerController.InfoKey : Any]) {
//        guard let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
//        else { return }
//        // imageを更新
//        parent.image = originalImage
//        // Image Pickerを閉じる
//        parent.isShown = false
//    }
//    
//    
//    
//    // 閉じるボタンがタップされたときに呼ばれるメソッド
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        // Image Pickerを閉じる
//        parent.isShown = false
//    }
//}


//写真の正常な表示
//ログインログアウトの画面
//写真複数枚に変更
//日付表示


