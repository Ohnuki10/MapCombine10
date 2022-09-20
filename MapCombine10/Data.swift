//
//  Data.swift
//  MapCombine10
//
//  Created by cmStudent on 2022/09/20.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable  {
    let prefecture: [String]
}

