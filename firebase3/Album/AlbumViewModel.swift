//
//  AlbumViewModel.swift
//  firebase3
//
//  Created by 大貫 伽奈 on 2023/01/31.
//
//最初に動くやつもこっち

import Foundation


class AlbumViewModel: ObservableObject {
   
    @Published var posts: [Post] = []//配列？データ入ってる？
//    @Published var imageData : Data = .init(capacity:0)
}
