//
//  EventViewController.swift
//  washu-sacc-app
//
//  Created by Andrew Huang on 12/2/21
//

import FSCalendar
import UIKit

class EventViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, UITableViewDataSource, UITableViewDelegate {
    
    var selectedDate: String!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var tableView: UITableView!
    
    struct Event: Decodable{
        var name: String?
        var description: String?
        var date: String?
        var time: String?
    }
    
    var events: [Event] = []
    var dateToEvents: [String: [Event]] = [:]
    var tableEvents: [Event] = []

    fileprivate lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.dataSource = self
        calendar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        fetchEvents()
        let today = calendar.today
        let todaysDateAsString = formatter.string(from: today ?? Date())
        setSelectedDate(dateString: todaysDateAsString)
    }
    
    func setSelectedDate(dateString: String){
        selectedDate = dateString
        if (dateToEvents[selectedDate] != nil){
            tableEvents = dateToEvents[selectedDate] ?? []
        } else {
            tableEvents = []
        }
        tableView.reloadData()
    }
    
    
    func fetchEvents(){
        print("fetching events")
        let url = URL(string: "https://washu-sacc-app-api.herokuapp.com/events")
        let data = try! Data(contentsOf: url!)
        let response = try! JSONDecoder().decode([Event].self, from: data)
        /// Store events in map, mapping date string to array of events
        events = response
        dateToEvents = [:]
        for event in events {
            let dateString = String(event.date?.split(separator: "T")[0] ?? "No date")
            if (dateToEvents[dateString] != nil){
                var currentEvents = dateToEvents[dateString]
                currentEvents?.append(event)
                dateToEvents[dateString] = currentEvents
            } else {
                dateToEvents[dateString] = [event]
            }
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateString = formatter.string(from: date)
        selectedDate = dateString
        if (dateToEvents[dateString] != nil){
            tableEvents = dateToEvents[dateString] ?? []
        } else {
            tableEvents = []
        }
        tableView.reloadData()
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = self.formatter.string(from: date)
        if (dateToEvents[dateString] != nil){
            return dateToEvents[dateString]?.count ?? 0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = UITableViewCell(style: .subtitle, reuseIdentifier: "eventCell")
        c.textLabel!.text = tableEvents[indexPath.row].name
        c.detailTextLabel?.text = tableEvents[indexPath.row].time
        return c
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.destination)
        if (segue.destination is CreateEventViewController){
            let vc = segue.destination as! CreateEventViewController
            vc.dateString = selectedDate!
        }
    }
}
