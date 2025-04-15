//
//  ViewController.swift
//  Alamofire+SwiftyJson
//
//  Created by Rahul Padmakumar on 15/04/25.
//

import UIKit

class ViewController: UIViewController {

    let wikiService = WikiService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        wikiService.fetchPost(query: "India")
    }


}

