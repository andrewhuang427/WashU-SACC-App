//
//  TeamViewController.swift
//  washu-sacc-app
//
//  Created by Joe Georger on 11/15/21.
//

import UIKit

class TeamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        theTableView.delegate = self
        theTableView.dataSource = self
        theTableView.register(UITableViewCell.self, forCellReuseIdentifier: "myIdentifier")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        theTableView.reloadData()
    }
    
    var genderSelected: String = "male" // keeps track of what gender we have selected with the segmented control
    
    @IBOutlet weak var theTableView: UITableView!
    
    @IBAction func genderSelectMethod(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
               if(sender.selectedSegmentIndex == 0){
                   genderSelected = "male"
                   theTableView.reloadData()
               }
               else if(sender.selectedSegmentIndex == 1){
                   genderSelected = "female"
                   theTableView.reloadData()
               }
    }
    
    var maleSportsArray: [[String]] = [["Baseball", "bsb", "0"],
                           ["Basketball", "mbkb", "0"],
                           ["Cross Country", "xc", "0"],
                           ["Football", "fball", "0"],
                           ["Soccer", "msoc", "0"],
                           ["Swimming & Diving", "swimdive", "0"],
                           ["Tennis", "mten", "0"],
                           ["Track & Field", "track", "0"]]
    
    var femaleSportsArray: [[String]] = [["Basketball","wbkb", "1"],
                                           ["Cross Country","xc", "1"],
                                           ["Golf", "wgolf", "1"],
                                           ["Soccer", "wsoc", "1"],
                                           ["Softball","sball", "1"],
                                           ["Swimming & Diving","swimdive", "1"],
                                           ["Tennis","wten", "1"],
                                           ["Track & Field","track", "1"],
                                           ["Volleyball","wvball", "1"]]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(genderSelected == "male"){
            return maleSportsArray.count
        }
        else {
            return femaleSportsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(genderSelected == "male"){
            let myCell = UITableViewCell(style: .default, reuseIdentifier: "myIdentifier")
            myCell.textLabel!.text = maleSportsArray[indexPath.row][0]
            return myCell
        }
        else {
            let myCell = UITableViewCell(style: .default, reuseIdentifier: "myIdentifier")
            myCell.textLabel!.text = femaleSportsArray[indexPath.row][0]
            return myCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = theTableView.indexPathForSelectedRow
        var t: [String] = ["Baseball", "bsb"]
        if(genderSelected == "male"){
            print("you selected \(maleSportsArray[indexPath.row])")
            t = maleSportsArray[index!.row]
        }
        else{
            print("you seleced \(femaleSportsArray[indexPath.row])")
            t = femaleSportsArray[index!.row]
        }
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "RosterVC") as! RosterViewController
        nextVC.apiTeam = t
        self.navigationController?.pushViewController(nextVC, animated: true)
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
