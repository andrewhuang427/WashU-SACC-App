//
//  PlayerDetailViewController.swift
//  washu-sacc-app
//
//  Created by Joe Georger on 12/4/21.
//

import UIKit

class PlayerDetailViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hometownLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    
    var first_name: String!
    var last_name: String!
    var height: String!
    var weight: String!
    var hometown: String!
    var high_school: String!
    var number: String!
    var grade: String!
    var image_url: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPlayerImage()
        labelGenerator()
        // Do any additional setup after loading the view.
    }
    
    func getPlayerImage(){
        let imagePath = URL(string: image_url)
        let theData = try? Data(contentsOf: imagePath!)
        let thePlayerPicture = UIImage(data: theData!)
        img.image = thePlayerPicture
    }

//     function to generate players information
    func labelGenerator() {
        nameLabel.text = first_name + " " + last_name
        hometownLabel.text = hometown
        gradeLabel.text = grade
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
