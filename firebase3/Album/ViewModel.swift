//
//  ViewModel.swift
//  firebase3
//
//  Created by 大貫 伽奈 on 2023/01/19.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase
import SwiftUI
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore
import Combine



struct Post: Identifiable,Decodable{
    
    var id: UUID //id取得
    var title : String
    var price : String
//    var lat : Double//追加
//    var lon : Double//追加
    
    
}

class ViewModel: ObservableObject {
    
    @ObservedObject var viewModel = AlbumViewModel()
    @ObservedObject var viewModel2 = AlbumViewModel()
    
    //とりあえず書いた
//    @Published var content = ""  //Attributeにある
    
//    @Published var posts: [Post] = []//配列？データ入ってる？ 移動した
    
    @Published var isNewData = false
    
    @Published var content = ""

    @Published var imageData:Data = Data.init() 
    
    @Published var image: UIImage?
    @AppStorage ("String" ) var a :URL?
    
    @Published var nowFilteredImage : UIImage?
    
    
    
    private var db = Firestore.firestore()
    
    
    //登録　写真以外の
    func uploadPost(title: String, price: String){
//    func uploadPost(title: String, price: String, lat: Double, lon: Double){
        // 登録するデータをまとめる
        let data = ["title": title,
                    "price": price,
//                    "lat": lat,//追加
//                    "lon": lon//追加
        ] as [String: Any]
        
        //.addDocument(data: ---)...---をFirebaseに追加したい！
        COLLECTION_POSTS.addDocument(data: data) { error in
            // エラーだったからここで終了
            if let error = error {
                print(error.localizedDescription)
                print("エラーだよ")
                return
            }
            // 登録できた！何します?
            print("登録完了")
        }
    }
    
    func UploadImage(){
        //保存場所と保存名
        let storageref = Storage.storage().reference(forURL: "gs://sampleproject-45a6f.appspot.com").child("Item\(id)")
        
        //保存したいイメージ  image　Image(uiImage: image)
        let image = image
        
        
        //pngに変換
        guard let data = image!.pngData() else {
            return
        }
        
        // firebasestorageに保存
        let uploadTask = storageref.putData(data)
                
        //　成功したら実行
        uploadTask.observe(.success) { _ in
            // firebasestorageにある写真のURLをダウンロード
            storageref.downloadURL { url, error in
                if let url = url {
                    // 端末に保存
                    self.a = url
                    print("")
                }
            }
        }//uploadTask
    }//uploadImage

    
    //戻り値がimage そのまま
    func download(url: URL, completion: @escaping (UIImage?) -> Void) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, _, _) in
            
            if let imageData = data{
                self.nowFilteredImage = UIImage(data: imageData)
            }
            DispatchQueue.main.async {
                completion(self.nowFilteredImage)
            }
            
        }
        task.resume()
    }//
    
    var id = UUID()
    
    func fetchData(viewModel: AlbumViewModel) {
        guard let uid = Auth.auth().currentUser?.uid else {
            return print("ログイン")
        }
        
        db.collection("memoTest").document(uid).addSnapshotListener { DocumentSnapshot, error in
            print("OK")
            
            if error != nil {
                print("NG")
            }else {
                
                if let snapshot = DocumentSnapshot {
                    viewModel.posts = try? snapshot.data(as: Post.self)
                } else{
                    //
                }
                
            }
        
        }
    }
    
    
    
    func add(_main: Post){
        guard let uid = Auth.auth().currentUser?.uid else {
            return print("ログインできない")
        }
        do {
            let _ = try db.collection("memodata").document(uid).setData(from: main)
        }
        catch {
            print ("")
        }
    }
    
  
    
    
    
}
