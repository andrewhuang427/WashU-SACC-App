//
//  ResourcesViewController.swift
//  washu-sacc-app
//
//  Created by Joe Georger on 11/15/21.
//

import UIKit

class ResourcesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //need to connect to resources button on main view controller
    //right now have just temporarily set this as default view controller
    
    //can probably put this data somewhere better but it works for now
    //need to get links for event sign up, ats, alumni db, nutritionist
    var resources_arr = ["CareerLink",
                         "TeamBuildr download",
                         "Event sign-Up",
                         "Training Room sign-up",
                         "Alumni Database",
                         "WashU Athletics Website",
                         "Nutritionist Appointments",
                         "RSVP Center"]

    //teambuildr link not working
    var links_arr = ["https://wustl-csm.symplicity.com/students/index.php?s=home",
                     "https://apps.apple.com/us/app/teambuildr/id1148960445",
                     "http://google.com",
                     "https://www.atsusers.com",
                     "https://www.linkedin.com/groups/12043062",
                     "https://washubears.com",
                     "https://google.com",
                     "https://students.wustl.edu/relationship-sexual-violence-prevention-center/"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resources_arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = UITableViewCell(style: .default, reuseIdentifier: nil)
        myCell.textLabel!.text = resources_arr[indexPath.row]
        return myCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row at \(indexPath.row)")
        if let url = URL(string: links_arr[indexPath.row]) {
            UIApplication.shared.open(url, completionHandler: nil)
        }
    }
    
    @IBOutlet weak var header: UIImageView!
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        header.image = UIImage(named: "washu-saac")!
        tableview.dataSource = self
        tableview.delegate = self
        
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
