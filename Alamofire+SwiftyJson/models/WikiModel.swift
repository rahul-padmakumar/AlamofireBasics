//
//  WikiModel.swift
//  Alamofire+SwiftyJson
//
//  Created by Rahul Padmakumar on 15/04/25.
//

struct WikiModel:Decodable{
    let batchcomplete: String?
    let query: WikiQuery?
}

struct WikiQuery:Decodable{
    let pageids: [String]?
    let pages: [String:WikiPage]?
}

struct WikiPage:Decodable{
    let title: String?
    let extract: String?
    let thumbnail: Thumbnail?
}

struct Thumbnail: Decodable{
    let height: Int?
    let source: String?
    let width: Int?
}
