//
//  WikiService.swift
//  Alamofire+SwiftyJson
//
//  Created by Rahul Padmakumar on 15/04/25.
//

import Alamofire

let url = "http://en.wikipedia.org/w/api.php/"

struct WikiService{
    func fetchPost(query: String){
        
        let parameter: [String:String] = [
            "format" : "json",
            "action" : "query",
            "prop" : "extracts",
            "exintro" : "",
            "explaintext" : "",
            "titles" : query,
            "redirects" : "1",
            "indexpageids" : ""
        ]
        
        AF.request(
            "\(url)&titles=\(query)",
            method: .get,
            parameters: parameter
        ).responseDecodable(of: WikiModel.self) { response in
            switch response.result{
            case .success(let data):
                if let safeQuery = data.query{
                    print("I am here")
                    if let safeId = data.query?.pageids?[0]{
                        print("I am here 1")
                        let extract = safeQuery.pages[safeId]?.extract ?? ""
                        print("Success data: \(extract)")
                    }
                }
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
