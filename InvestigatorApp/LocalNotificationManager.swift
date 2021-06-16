//
//  LocalNotificationManager.swift
//  InvestigatorApp
//
//  Created by Артём on 6/16/21.
//

import UIKit
import UserNotifications

struct LocalNotificationManager {
    
    static func autherizeLocalNotifications(viewController: UIViewController){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            guard error == nil else {
                print("ERROR: \(error!.localizedDescription)")
                return
            }
            if granted {
                print("Notification Authorization Granted!")
            } else {
                print("!!! The User Has Denied Notifications!")
                DispatchQueue.main.async {
                    viewController.oneButtonAlert(title: "Push отключены", message: "Чтобы получать напоминания и уведомления о предстоящих событиях, перейдите в Настройки, выберите Ежедневник Следователя > Уведомления > Разрешить уведомления ")
                    //                TODO: Put an alert here tellingthe user what to do
                }
            }
        }
    }
    
    static func isAuthorized(completed: @escaping (Bool)->() ){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            guard error == nil else {
                print("ERROR: \(error!.localizedDescription)")
                completed(false)
                return
            }
            if granted {
                print("Notification Authorization Granted!")
                completed(true)
            } else {
                print("!!! The User Has Denied Notifications!")
                completed(false)
            }
        }
    }
    
    static func setCalendarNotification(title: String, subtitle: String, body: String, badgeNumber: NSNumber?, sound: UNNotificationSound?, date: Date) -> String {
        //TODO:        добавить в функцию по сохранению данных let item = models.first setCalendarNotification(title: item.title, subtitle: "Subtitle goes here", body: item.body, badgeNumber: nil, sound: .default, date: item.date)
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = sound
        content.badge = badgeNumber
        
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        dateComponents.second = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let notificationID = UUID().uuidString
        let request = UNNotificationRequest(identifier: notificationID, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("ERROR ading notification: \(error.localizedDescription) ")
            } else {
                print("Notification Scheduled \(notificationID), \(content.title)")
            }
        }
        return notificationID
    }
    
    
}
