//
//  ViewController.swift
//  Alamofire+SwiftyJson
//
//  Created by Rahul Padmakumar on 15/04/25.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var uiSearchBar: UISearchBar!
    @IBOutlet weak var imageText: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    var wikiService = WikiService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        wikiService.delegate = self
        uiSearchBar.delegate = self
        wikiService.fetchPost(query: "India")
        setUpDismissKeyboardGesture()
    }
    
    func setUpDismissKeyboardGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

extension ViewController: WikiServiceDelegate{
    func onSuccess(extract: String, image: String) {
        imageText.text = extract
        imageView.sd_setImage(with: URL(string: image))
    }
    func onFailure(error: (any Error)?) {
        print(error?.localizedDescription ?? "")
    }
}

extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let safeText = searchBar.text{
            print(safeText)
            wikiService.fetchPost(query: safeText)
            searchBar.endEditing(true)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

