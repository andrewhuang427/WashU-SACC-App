//
//  NewsViewController.swift
//  washu-sacc-app
//
//  Created by Joe Georger on 11/15/21.
//

import UIKit

class NewsViewController: UIViewController {
    
    var theNews: [News] = []
    
    
    struct News: Decodable{
        var title: String?
        var link: String?
        var team_abbreviation: String?
        var image_url: String?
        var date_posted: String?
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("running")
        fetchData()

        // Do any additional setup after loading the view.
    }
    
    func fetchData(){
        let url = URL(string: "https://washu-sacc-app-api.herokuapp.com/news")
        let data = try! Data(contentsOf: url!)
        let response = try! JSONDecoder().decode([News].self, from: data)
//        print(response)
        theNews = Array(response[0 ..< 30])
        for j in theNews{
            print(j.title ?? "No News")
            
        }
        print(theNews.count)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
