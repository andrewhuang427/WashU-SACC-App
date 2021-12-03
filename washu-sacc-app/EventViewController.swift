//
//  EventViewController.swift
//  washu-sacc-app
//
//  Created by Andrew Huang on 12/2/21
//

import FSCalendar
import UIKit

class EventViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {

    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var eventTitle: UILabel!
    
    struct Event: Decodable{
        var name: String?
        var description: String?
        var date: String?
        var time: String?
    }
    
    var events: [Event] = []
    var dateToEvents: [String: [Event]] = [:]

    fileprivate lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.dataSource = self
        calendar.delegate = self
        fetchEvents()
    }
    
    func fetchEvents(){
        let url = URL(string: "https://washu-sacc-app-api.herokuapp.com/events")
        let data = try! Data(contentsOf: url!)
        let response = try! JSONDecoder().decode([Event].self, from: data)
        /// Store events in map, mapping date string to array of events
        events = response
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
        if (dateToEvents[dateString] != nil){
            eventTitle.text = dateToEvents[dateString]?[0].name ?? "Failed to unwrap optional"
        } else {
            eventTitle.text = "No Events Today"
        }
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = self.formatter.string(from: date)
        if (dateToEvents[dateString] != nil){
            return dateToEvents[dateString]?.count ?? 0
        } else {
            return 0
        }
    }
}
