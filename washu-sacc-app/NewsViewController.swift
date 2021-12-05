//
//  NewsViewController.swift
//  washu-sacc-app
//
//  Created by Joe Georger on 11/15/21.
//

import UIKit
import SafariServices

class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var newsTable: UITableView!
    
//    Global var for all data from call to api
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
//      set up tabel and call to fecth method
        newsTable.dataSource = self
        newsTable.delegate = self
        newsTable.register(UITableViewCell.self, forCellReuseIdentifier: "newsCell")
        fetchData()
    }
    
//    funcs to set up UITable
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = UITableViewCell(style: .default, reuseIdentifier: "newsCell")
        c.textLabel!.text = news[indexPath.row].title
        c.textLabel?.numberOfLines = 0
        return c
    }
    
//  func to handle action when an artical is selected. Will open the artical in a safari viewcontroller.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: news[indexPath.row].link ?? "https://washubears.com/landing/headlines-featured") {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true

                let vc = SFSafariViewController(url: url, configuration: config)
                present(vc, animated: true)
            }
    }
    
//    func to fetch data from api
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
