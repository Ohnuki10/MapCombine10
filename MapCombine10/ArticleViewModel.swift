//
//  DataModel.swift
//  MyCombine4
//
//  Created by cmStudent on 2022/07/12.
//https://qiita.com/api/v2/items
//https://connpass.com/api/v1/event/
//https://pythonchannel.com/media/codecamp/201902/JSON-Sample1.json
//http://express.heartrails.com/api/json?method=getPrefectures

import SwiftUI
import Combine
import Foundation

class ArticleViewModel: ObservableObject {
    

    
    @Published private(set) var prefectureInputs: Response = Response(prefecture: [])
    
    var disposable : Set<AnyCancellable> = []
//    @Published var eventData
    
    
    init() {
        
        fetchArticleEvents()
       
    }
    
    func fetchArticleEvents() {
       
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let url2 = URL(string: "http://express.heartrails.com/api/json?method=getPrefectures")!
       
       
        let request = URLRequest(url: url2)
        
        let cancellable = URLSession.shared.dataTaskPublisher(for: request)
           .map({(data, res) in
               return data
           })
           .decode(type: Welcome.self, decoder: decoder)
           .sink(receiveCompletion: {completion in
                   switch completion{
                   case .failure(let error):
                       print("error")
                   case .finished:
                       print("終了")
                   }
           }
           , receiveValue: {weather in
               print(weather.response)
               self.prefectureInputs = weather.response
           })
           .store(in: &disposable)

    }//fetchArticleEvents
    
    
    
}
