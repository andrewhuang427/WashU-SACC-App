//
//  ResourcesViewController.swift
//  washu-sacc-app
//
//  Created by Joe Georger on 11/15/21.
//

import UIKit

class ResourcesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var resources_arr = ["CareerLink",
                         "TeamBuildr download",
                         "Event sign-Up",
                         "Training Room sign-up",
                         "Alumni Database",
                         "WashU Athletics Website",
                         "Nutritionist Appointments",
                         "RSVP Center"]

    var links_arr = ["https://wustl-csm.symplicity.com/students/index.php?s=home",
                     "https://www.teambuildr.com/en/?utm_term=teambuildr&utm_campaign=Brand&utm_source=adwords&utm_medium=ppc&hsa_acc=5368532431&hsa_cam=856468734&hsa_grp=44323215555&hsa_ad=526485359171&hsa_src=g&hsa_tgt=kwd-342081506345&hsa_kw=teambuildr&hsa_mt=e&hsa_net=adwords&hsa_ver=3&gclid=Cj0KCQiA47GNBhDrARIsAKfZ2rAFRVive2LIkHZ5w7aM-TToi_At6EtNKDZrjq9QSyli1x8fGqN5FBoaAssoEALw_wcB",
                     "https://docs.google.com/spreadsheets/d/1r-g2RZ3yAZMCDdm2wPyP0BqmtWBr8cioepwtquWTk6o/edit#gid=534087976",
                     "https://www.atsusers.com",
                     "https://www.linkedin.com/groups/12043062",
                     "https://washubears.com",
                     "https://students.wustl.edu/medical-health-care-appointments/",
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
}
