//
//  CreateEventViewController.swift
//  washu-sacc-app
//
//  Created by Andrew Huang on 12/4/21.
//

import UIKit

class CreateEventViewController: UIViewController {

    
    var dateString: String!
    @IBOutlet weak var eventTextLabel: UILabel!
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventDescriptionTextField: UITextField!
    @IBOutlet weak var eventTimeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshLabels()
    }
    
    @IBAction func createEvent(_ sender: UIButton) {
        let url = URL(string: "http://localhost:3000/events")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "name=\(eventNameTextField.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "name")&description=\(eventDescriptionTextField.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "description" )&time=\(eventTimeTextField.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "time")&date=\(dateString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "12-08-2021")"
    
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
    
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {
                // check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
            }

            guard (200 ... 299) ~= response.statusCode else {
                // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }

            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString ?? "response")")
        }

        task.resume()
    }
    
    
    func refreshLabels(){
        eventTextLabel.text = dateString
    }
    


}
