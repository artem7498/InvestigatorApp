//
//  AllCasesViewController.swift
//  InvestigatorApp
//
//  Created by Артём on 6/19/21.
//

import UIKit

class AllCasesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var rowHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.rowHeight = UIScreen.main.traitCollection.userInterfaceIdiom == .phone ? 152 : 75
        self.tableView.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        self.tableView.rowHeight = self.rowHeight
        
        
    }
    
    
    
    
}

extension AllCasesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! AllCasesTableViewCell
        
        cell.caseImage.image = indexPath.section % 2 == 0 ? UIImage(named: "case_closed") : UIImage(named: "judge")
        cell.nameLabel.text = indexPath.section % 2 == 0 ? "Иванов Петр Олегович" : "Ольга Ивановна, Олег Валерьянович Петровна, Олег Вознякович"
        cell.dateLabel.text = "04.12.2019 - 17.03.2022"
        
        cell.caseImage.layer.cornerRadius = cell.caseImage.frame.width / 2
        cell.caseImage.layer.borderWidth = 1
        cell.caseImage.layer.borderColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        cell.caseImage.layer.masksToBounds = true
        
        if(UIScreen.main.traitCollection.userInterfaceIdiom == .pad){
           cell.caseImage.layer.cornerRadius = cell.caseImage.frame.width / 4
           cell.caseImage.layer.masksToBounds = true
        }
//        cell.layer.cornerRadius = 10
//        cell.layer.borderWidth = 1
//        cell.layer.borderColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
//        cell.backgroundColor = indexPath.section % 2 == 0 ? UIColor.lightGray : UIColor.white
        cell.backgroundColor = #colorLiteral(red: 0.9455942512, green: 0.9434236884, blue: 1, alpha: 1)
        cell.clipsToBounds = true
        
        return cell
    }
    
    
}
