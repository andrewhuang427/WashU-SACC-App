//
//  RosterViewController.swift
//  washu-sacc-app
//
//  Created by Joe Georger on 12/4/21.
//

import UIKit

class RosterViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    struct Player: Decodable {
        var first_name: String?
        var last_name: String?
        var height: String?
        var weight: String?
        var team: String?
        var team_abbreviation: String?
        var hometown: String?
        var high_school: String?
        var number: String?
        var grade: String?
        var image_url: String?
    }
    
    var apiTeam: [String]?
    
    var thePlayers: [Player] = []
    
    @IBOutlet weak var myTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.dataSource = self
        myTable.delegate = self
        if apiTeam?[2] == "0"{
            title = "Men's \(apiTeam?[0] ?? "No Team Entered")"
        }
        else{
            title = "Women's \(apiTeam?[0] ?? "No Team Entered")"
        }
        fetchMethod()
        // Do any additional setup after loading the view.
    }
    
    
    var rosterData: [String] = ["athlete1", "athlete2", "athlete3"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thePlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = UITableViewCell(style: .default, reuseIdentifier: "myIdentifier")
        myCell.textLabel!.text = (thePlayers[indexPath.row].first_name ?? "") + " " +  (thePlayers[indexPath.row].last_name ?? "")
        return myCell
    }
    
    /*
    // MARK: - Detail View Controller
     */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "PlayerVC") as! PlayerDetailViewController
        let index = myTable.indexPathForSelectedRow
        print(thePlayers[index!.row])
        nextVC.first_name = thePlayers[index!.row].first_name
        nextVC.last_name = thePlayers[index!.row].last_name
        nextVC.hometown = thePlayers[index!.row].hometown
        nextVC.grade = thePlayers[index!.row].grade
        nextVC.image_url = thePlayers[index!.row].image_url
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func fetchMethod(){
        let url: String = "https://washu-sacc-app-api.herokuapp.com/athletes?team=\(apiTeam?[1] ?? "")"
        let newURL = URL(string: url)
        if newURL != nil {
            let theData = try? Data(contentsOf: newURL!)
            if theData != nil{
                let response = try! JSONDecoder().decode([Player].self, from: theData!)
                if apiTeam?[2] == "0"{
                    if apiTeam?[1] == "swimdive"{
                        thePlayers = Array(response[..<34])
                    }
                    if apiTeam?[1] == "xc"{
                        thePlayers = Array(response[..<39])
                    }
                    if apiTeam?[1] == "track"{
                        thePlayers = Array(response[..<80])
                    }
                }
                else{
                    if apiTeam?[1] == "swimdive"{
                        thePlayers = Array(response[34...])
                    }
                    if apiTeam?[1] == "xc"{
                        thePlayers = Array(response[39...])
                    }
                    if apiTeam?[1] == "track"{
                        thePlayers = Array(response[80...])
                    }
                }
            }
        }
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
