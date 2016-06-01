//
//  ViewController.swift
//  IOS8SwiftAddEventTutorial
//
//  Created by iGuest on 5/31/16.
//  Copyright © 2016 iGuest. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UIViewController {

    /*static let sharedInstance = EventController ()
    let eventStore = EKEventStore()
    
    override init() {
        
        //grants permission to access calendar
        
        if EKEventStore.authorizationStatusForEntityType(.Event) != (EKAuthorizationStatus.Authorized) {
            
            eventStore.requestAccessToEntityType(.Event, completion: { (granted, error) -> Void in
                
                
            })
        } else {
            
            
        }
        
    }
    
    func createEvent(title: String, startDate: NSDate) {
        
        let eventStore = EKEventStore()
        let event = EKEvent(eventStore: eventStore)
        
        if (EKEventStore.authorizationStatusForEntityType(.Event) != EKAuthorizationStatus.Authorized) {
            
            eventStore.requestAccessToEntityType(.Event, completion: { (granted, error) -> Void in
                
                event.title = title
                event.startDate = startDate
                //        event.endDate = endDate
                event.calendar = eventStore.defaultCalendarForNewEvents
                
                do {
                    
                    try eventStore.saveEvent(event, span: .FutureEvents)
                    
                } catch {
                    print("bad things happened")
                }
                
            })
        }
    }*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*var eventStore : EKEventStore = EKEventStore()
         
         // 'EKEntityTypeReminder' or 'EKEntityTypeEvent'
         
         eventStore.requestAccessToEntityType(EKEntityType.Event, completion: {
         (granted, error) in
         
         if (granted) && (error == nil) {
         print("granted \(granted)")
         print("error \(error)")
         
         var event:EKEvent = EKEvent(eventStore: eventStore)
         
         event.title = "Test Title"
         event.startDate = NSDate()
         event.endDate = NSDate()
         event.notes = "This is a note"
         event.calendar = eventStore.defaultCalendarForNewEvents
         
         eventStore.saveEvent(event, span: EKSpan.ThisEvent, commit: false)
         
         print("Saved Event")
         } 
         })*/
        
        
        // 1
    }
    
    @IBAction func addEvent(sender: AnyObject) {
        let eventStore = EKEventStore()
        var event: EKEvent = EKEvent(eventStore: eventStore)
        // 2
        switch EKEventStore.authorizationStatusForEntityType(.Event) {
        case .Authorized:
            insertEvent(eventStore)
        case .Denied:
            print("Access denied")
        case .NotDetermined:
            // 3
            eventStore.requestAccessToEntityType(.Event, completion:
                {[weak self] (granted: Bool, error: NSError?) -> Void in
                    if granted {
                        self!.insertEvent(eventStore)
                        
                    } else {
                        print("Access denied")
                    }
                })
        default:
            print("Case Default")
        }
    }
    
    
    func insertEvent(store: EKEventStore) {
        // 1
        let calendars = store.calendarsForEntityType(.Event)
            as! [EKCalendar]
        
        for calendar in calendars {
            // 2
            if calendar.title == "ioscreator" {
                // 3
                let startDate = NSDate()
                // 2 hours
                let endDate = startDate.dateByAddingTimeInterval(2 * 60 * 60)
                
                // 4
                // Create Event
                var event = EKEvent(eventStore: store)
                event.calendar = calendar
                
                event.title = "New Meeting"
                event.startDate = startDate
                event.endDate = endDate
                
                // 5
                // Save Event in Calendar
                var error: NSError?
                var result: ()
                do {
                    result = try store.saveEvent(event, span: EKSpan.ThisEvent, commit: true)
                } catch {
                    print("it doesn't work")
                }
                
                //if result == false {
                    if let theError = error {
                        print("An error occured \(theError)")
                    }
                //}
            }
        }
    }
    
    
}

