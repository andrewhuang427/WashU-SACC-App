//
//  ViewController.swift
//  washu-sacc-app
//
//  Created by Andrew Huang on 11/12/21.
//  Main screen cell
//  V1: create a colleciton veiw that can navigate user to different pages.

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var pageCollection: UICollectionView!
    
    var pageIcons: Array<UIImage>?
    var pageLabel: Array<String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pageCollection.dataSource = self
        pageIcons = [UIImage(named: "events")!, UIImage(named: "news")!, UIImage(named: "resources")!, UIImage(named: "teams")!]
        pageLabel = ["Events", "News", "Resources", "Teams"]
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pageCollection.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! PageCollectionViewCell
        cell.pageIcon.image = pageIcons?[indexPath.item]
        cell.pageLabel.text = pageLabel?[indexPath.item]
        return cell
        
    }


}

