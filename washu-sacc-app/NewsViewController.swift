//
//  NewsViewController.swift
//  washu-sacc-app
//
//  Created by Joe Georger on 11/15/21.
// https://www.youtube.com/watch?v=TZ3-iQ462Q8
//

import UIKit
import SafariServices

class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    @IBOutlet weak var newsTable: UITableView!
    
    var news: [News] = []
    
    private var showSafari: Bool = false
    
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
        newsTable.dataSource = self
        newsTable.delegate = self
        fetchData()
        newsTable.register(UITableViewCell.self, forCellReuseIdentifier: "newsCell")
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = UITableViewCell(style: .default, reuseIdentifier: "newsCell")
        c.textLabel!.text = news[indexPath.row].title
        c.textLabel?.numberOfLines = 0
        return c
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(news[indexPath.row].link!)
        if let url = URL(string: news[indexPath.row].link ?? "https://washubears.com/landing/headlines-featured") {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true

                let vc = SFSafariViewController(url: url, configuration: config)
                present(vc, animated: true)
            }
    }
    
    func fetchData(){
        let url = URL(string: "https://washu-sacc-app-api.herokuapp.com/news")
        let data = try! Data(contentsOf: url!)
        let response = try! JSONDecoder().decode([News].self, from: data)
//        print(response)
        news = Array(response[0 ..< 30])
        for j in news{
            print(j.title ?? "No News")
            
        }
        print(news.count)
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
