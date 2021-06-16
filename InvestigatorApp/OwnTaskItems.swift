//
//  OwnTaskItems.swift
//  InvestigatorApp
//
//  Created by Артём on 6/16/21.
//

import Foundation
import UserNotifications

class OwnTaskItems {
    
    var itemsArray: [OwnTask] = []
    
    static let shared = OwnTaskItems()
    
//    TODO: REalm save and load data should be here
    
    func setNotifications(){
        guard itemsArray.count > 0 else { return }
//        remove all notifications
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
//        recreate them
        for index in 0..<itemsArray.count{
            if itemsArray[index].reminderSet && !itemsArray[index].isChecked{
                let taskItem = itemsArray[index]
                itemsArray[index].notificationID = LocalNotificationManager.setCalendarNotification(title: taskItem.title, subtitle: "", body: taskItem.body, badgeNumber: nil, sound: .default, date: taskItem.date)
            }
        }
        
    }
}
