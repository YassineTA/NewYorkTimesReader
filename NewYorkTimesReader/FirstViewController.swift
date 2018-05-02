//
//  FirstViewController.swift
//  NewYorkTimesReader
//
//  Created by Yassine on 30/04/2018.
//  Copyright © 2018 Yassine. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var articlesTableView: UITableView!
    
    var articles:[String] = [String]()
    var url:String?
    let apiKey:String = "e7d87a75285f4d5fa673d1521cc1afec"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        articlesTableView.dataSource = self
        
        
        
        //Fausses données
        for i in 1..<50 {
            let article = "article \(i)"
            self.articles.append(article)
            
        }
        
        url = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=\(apiKey)"
        telechargerArticles(urlStr: url!) { (array) in
            //code
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifiant:String = "articleCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifiant, for: indexPath)
        
        //Configurer cell
        cell.textLabel!.text = articles[indexPath.row]
        cell.detailTextLabel!.text = "Auteur \(indexPath.row + 1)"
        cell.imageView?.image = UIImage(named: "placeholder.jpeg")
        return cell
    }
    
    //MARK - NYT API
    
    func telechargerArticles(urlStr: String, completion:(_ Array:NSArray) -> ()){
        
        print("string url pour nyt " + urlStr)
        // a apprendre pour telecharger les données json
        var articlesArray: [NSDictionary] = [NSDictionary]()
        let url = URL(string: urlStr)
        let session = URLSession.shared
        let requete = session.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if let donnees = data {
                    do {
                        let jsonDictionnaire = try JSONSerialization.jsonObject(with: donnees, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                        if let items = jsonDictionnaire["results"] as? NSArray {
                            for item in items {
                                print(item)
                            }
                        }
                        
                    } catch{
                        
                    }
                }
            }
        }
        requete.resume()
        completion(articlesArray as NSArray)
        
        
    }

}

