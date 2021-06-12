//
//  TaskModel.swift
//  InvestigatorApp
//
//  Created by Артём on 6/10/21.
//

import Foundation


struct WorkTask: Hashable {
    var title: String
    var date: Date?
    var isChecked = false
}

struct OwnTask: Hashable {
    var title: String
    var body: String
    var date: Date
    var identifier: String
    var isChecked = false
}

struct Case: Hashable {
    var caseTitle: String
}



class Section {
    
//    var ownItem = [
//        OwnTask(title: "My task1"),
//        OwnTask(title: "My task2"),
//        OwnTask(title: "My task3"),
//        OwnTask(title: "My task4"),
//        OwnTask(title: "My task5"),
//        OwnTask(title: "My task6"),
//        OwnTask(title: "My task7"),
//        OwnTask(title: "My task8")
//
//    ]
    
    var workTask = [
        WorkTask(title: "Work task1"),
        WorkTask(title: "Work task2"),
        WorkTask(title: "Work task3"),
        WorkTask(title: "Work task4"),
        WorkTask(title: "Work task5"),
        WorkTask(title: "Work task6")
    ]
    
    var cases = [
        Case(caseTitle: "123"),
        Case(caseTitle: "435"),
        Case(caseTitle: "432"),
        Case(caseTitle: "21"),
        Case(caseTitle: "2211")
    ]
    
}
