//
//  CreateEventViewController.swift
//  washu-sacc-app
//
//  Created by Andrew Huang on 12/4/21.
//

import UIKit

class CreateEventViewController: UIViewController {

    
    var dateString: String?
    @IBOutlet weak var eventTextLabel: UILabel!
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventDescriptionTextField: UITextField!
    @IBOutlet weak var eventTimeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshLabels()
    }
    
    @IBAction func createEvent(_ sender: UIButton) {
        let url = URL(string: "https://washu-sacc-app-api.herokuapp.com/events")!
        
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let encodedName = eventNameTextField.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "name"
        let encodedDescription = eventDescriptionTextField.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "description"
        let encodedDate = dateString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "12-08-2021"
        let encodedTime = eventTimeTextField.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)  ?? "time"
        let postString = "name=\(encodedName)&description=\(encodedDescription)&time=\(encodedTime)&date=\(encodedDate)"
    
        print(encodedDate)
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
    
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {
                return
            }
            guard (200 ... 299) ~= response.statusCode else {
                return
            }

            let responseString = String(data: data, encoding: .utf8)
            print(responseString ?? "no response")
            
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }

        task.resume()
    }    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let optimalEventVC = presentingViewController?.children[2].children[0]
        if (optimalEventVC is EventViewController) {
            let eventVC = optimalEventVC as! EventViewController
            eventVC.fetchEvents()
            print(dateString!)
            eventVC.setSelectedDate(dateString: dateString!)
            eventVC.calendar.reloadData()
        } else {
            print("failed to cast")
        }
    }
    
    func refreshLabels(){
        eventTextLabel.text = dateString
    }
    


}
