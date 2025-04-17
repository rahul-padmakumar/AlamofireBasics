//
//  WikiService.swift
//  Alamofire+SwiftyJson
//
//  Created by Rahul Padmakumar on 15/04/25.
//

import Alamofire

let url = "http://en.wikipedia.org/w/api.php/"

protocol WikiServiceDelegate{
    func onSuccess(extract: String, image: String)
    func onFailure(error: Error?)
}

struct WikiService{
    
    var delegate: WikiServiceDelegate?
    
    func fetchPost(query: String){
        
        let parameter: [String:String] = [
            "format" : "json",
            "action" : "query",
            "prop" : "extracts|pageimages",
            "exintro" : "",
            "explaintext" : "",
            "titles" : query,
            "redirects" : "1",
            "indexpageids" : "",
            "pithumbsize": "500"
        ]
        
        AF.request(
            "\(url)&titles=\(query)",
            method: .get,
            parameters: parameter
        ).responseDecodable(of: WikiModel.self) { response in
            switch response.result{
            case .success(let data):
                if let safeQuery = data.query{
                    if let safeId = data.query?.pageids?[0]{
                        let extract = safeQuery.pages?[safeId]?.extract ?? ""
                        let imageUrl = safeQuery.pages?[safeId]?.thumbnail?.source ?? ""
                        delegate?.onSuccess(extract: extract, image: imageUrl)
                    }
                }
                
            case .failure(let error):
                delegate?.onFailure(error: error)
            }
        }
    }
}
