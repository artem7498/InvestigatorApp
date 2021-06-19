//
//  ViewController.swift
//  InvestigatorApp
//
//  Created by Артём on 6/8/21.
//

//import UserNotifications
import UIKit

class DashboardViewController: UIViewController {
    
//    var models = [OwnTask]()
    var ownTaskItems = OwnTaskItems.shared
    

    @IBOutlet weak var ownTaskTableView: UITableView!
    @IBOutlet weak var ownTaskTableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var workTaskTableView: UITableView!
    @IBOutlet weak var workTaskTableHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var topViewForCollection: UIView!
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MainScreenCollectionViewCell.nib(), forCellWithReuseIdentifier: MainScreenCollectionViewCell.reuseId)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupTableViews()
        
        LocalNotificationManager.autherizeLocalNotifications(viewController: self)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.ownTaskTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.ownTaskTableView.reloadData()
        self.workTaskTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.workTaskTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.workTaskTableView.removeObserver(self, forKeyPath: "contentSize")
        self.ownTaskTableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    func setupCollectionView(){
        topViewForCollection.addSubview(collectionView)
        collectionView.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        collectionView.topAnchor.constraint(equalTo: topViewForCollection.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: topViewForCollection.bottomAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: topViewForCollection.trailingAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: topViewForCollection.leadingAnchor).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupTableViews(){
        ownTaskTableView.register(MainScreenTableViewCell.nib(), forCellReuseIdentifier: MainScreenTableViewCell.reuseId)
        workTaskTableView.register(MainScreenTableViewCell.nib(), forCellReuseIdentifier: MainScreenTableViewCell.reuseId)
        self.ownTaskTableView.layer.cornerRadius = 10
        self.workTaskTableView.layer.cornerRadius = 10
    }
    
    @IBAction func didTapAddButton(_ sender: Any) {
        
        guard let vc = storyboard?.instantiateViewController(identifier: "TaskEditorTableViewController") as? TaskEditorTableViewController else {return}
        vc.title = "Личная задача"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = {[unowned self] newItem in
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
//                let new = OwnTask(title: title, body: body, date: date, reminderSet: push)
                print(newItem)
                self.ownTaskItems.itemsArray.append(newItem)
                ownTaskItems.setNotifications()
                self.ownTaskTableView.reloadData()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let obj = object as? UITableView,
           obj == self.ownTaskTableView && keyPath == "contentSize"{
            if let newValue = change?[.newKey]{
                let newSize = newValue as! CGSize
                self.ownTaskTableHeight.constant = newSize.height
//                print("adjust")
            }
        }
        
        if let obj = object as? UITableView,
           obj == self.workTaskTableView && keyPath == "contentSize"{
            if let newValue = change?[.newKey]{
                let newSize = newValue as! CGSize
                self.workTaskTableHeight.constant = newSize.height
//                print("adjusted")
            }
        }
    }


}

extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        print(collectionView.frame.width / 2.5, collectionView.frame.width / 2)
        return CGSize(width: topViewForCollection.frame.width / 2.5, height: topViewForCollection.frame.height * 0.95)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenCollectionViewCell.reuseId, for: indexPath) as! MainScreenCollectionViewCell
        
        cell.cellview.backgroundColor = .orange
        return cell
    }
    
    
}


extension DashboardViewController: UITableViewDelegate, UITableViewDataSource, MainScreenTableViewCellDelegate{
    
    func checkBoxToggle(sender: MainScreenTableViewCell) {
        if let selectedIndexPath = ownTaskTableView.indexPath(for: sender){
            ownTaskItems.itemsArray[selectedIndexPath.row].isChecked = !ownTaskItems.itemsArray[selectedIndexPath.row].isChecked
            print("CHECKED \(ownTaskItems.itemsArray[selectedIndexPath.row].isChecked)")
            
            if ownTaskItems.itemsArray[selectedIndexPath.row].isChecked && ownTaskItems.itemsArray[selectedIndexPath.row].reminderSet {
                ownTaskItems.itemsArray[selectedIndexPath.row].reminderSet = false
                UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [ownTaskItems.itemsArray[selectedIndexPath.row].notificationID!])
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [ownTaskItems.itemsArray[selectedIndexPath.row].notificationID!])
                
//                setNotifications()
            }
            ownTaskTableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        }
        
        if let selectedIndexPath = workTaskTableView.indexPath(for: sender){
//            models[selectedIndexPath.row].isChecked = !models[selectedIndexPath.row].isChecked
            workTaskTableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1{
//            let today = models.filter{ item in item.date > Date().endOfDay}
            return ownTaskItems.itemsArray.count
        } else if tableView.tag == 2{
            return 5
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 51
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell") as! TestCell
        let cell = tableView.dequeueReusableCell(withIdentifier: MainScreenTableViewCell.reuseId, for: indexPath) as! MainScreenTableViewCell

            if tableView.tag == 1{
                
//                let today = models.filter{ item in item.date > Date().endOfDay}
                
                cell.delegate = self
                cell.titleLabel?.text = ownTaskItems.itemsArray[indexPath.row].title
                cell.subtitleLabel.text = ownTaskItems.itemsArray[indexPath.row].body
                cell.dateLabel.text = ownTaskItems.itemsArray[indexPath.row].date.toString()
                cell.checkBoxButton.isSelected = ownTaskItems.itemsArray[indexPath.row].isChecked
                
            } else if tableView.tag == 2{
                
                cell.delegate = self
                cell.titleLabel?.text = "Test TgggggestTestTestTest \(indexPath.row)"
                cell.subtitleLabel.text = "Test TestTestgggTestTestTest \(indexPath.row)"
                cell.dateLabel.text = "04.04.2021"
                
            }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("MainScreenHeaderView", owner: self, options: nil)?.first as! MainScreenHeaderView
        
        if tableView.tag == 1{
            headerView.headerImageView.image = UIImage(systemName: "pencil.circle")
            headerView.headerLabel.text = "Личные дела"

        } else if tableView.tag == 2{
            headerView.headerImageView.image = UIImage(systemName: "pencil.circle.fill")
            headerView.headerLabel.text = "Рабочие дела"

        }

        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.tag == 1{
            
            let selectedIndexPath = ownTaskTableView.indexPathForSelectedRow
            
            guard let vc = storyboard?.instantiateViewController(identifier: "TaskEditorTableViewController") as? TaskEditorTableViewController else {return}
            vc.title = "Личная задача"
            vc.navigationItem.largeTitleDisplayMode = .never
//            vc.titleTextField.text = models[selectedIndexPath!.row].title
            vc.toDoItem = ownTaskItems.itemsArray[selectedIndexPath!.row]
            
            vc.completion = {[unowned self] newItem in
                DispatchQueue.main.async {
                    self.navigationController?.popToRootViewController(animated: true)
//                    let new = OwnTask(title: title, body: body, date: date, reminderSet: push)
                    print(newItem)
//                    проверить старые уведомления здесь со старыми значениями
//                    добавить проверку на выполнение isChecked
                    self.ownTaskItems.itemsArray[selectedIndexPath!.row] = newItem
                    self.ownTaskItems.setNotifications()
                    self.ownTaskTableView.reloadData()

//                    if push == true{
//                        let content = UNMutableNotificationContent()
//                        content.title = title
//                        content.sound = .default
//                        content.body = body
//
//                        let targetDate = date
//                        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: targetDate), repeats: false)
//                        let request = UNNotificationRequest(identifier: new.identifier, content: content, trigger: trigger)
//                        UNUserNotificationCenter.current().add(request) { error in
//                            if error != nil {
//                                print("something went wrong \(error.debugDescription)")
//                            }
//                        }
//                    }
                }
            }
            navigationController?.pushViewController(vc, animated: true)
            
        } else if tableView.tag == 2{
            
        }

        
//        performSegue(withIdentifier: "ShowDetail", sender: self)
    }
    
}

