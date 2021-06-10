//
//  ViewController.swift
//  InvestigatorApp
//
//  Created by Артём on 6/8/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ownTaskTableView: UITableView!
    @IBOutlet weak var ownTaskTableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var workTaskTableView: UITableView!
    @IBOutlet weak var workTaskTableHeight: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ownTaskTableView.layer.cornerRadius = 10
        self.workTaskTableView.layer.cornerRadius = 10
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.ownTaskTableView.addObserver(self, forKeyPath: "Size", options: .new, context: nil)
        self.ownTaskTableView.reloadData()
        self.workTaskTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.workTaskTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.workTaskTableView.removeObserver(self, forKeyPath: "contentSize")
        self.ownTaskTableView.removeObserver(self, forKeyPath: "Size")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "Size"{
            print("adjust")
            if object is UITableView{
                if let newValue = change?[.newKey]{
                    let newSize = newValue as! CGSize
                    self.ownTaskTableHeight.constant = newSize.height
                    print("adjust")
                }
            }
        }
        
        if keyPath == "contentSize"{
            if object is UITableView{
                if let newValue = change?[.newKey]{
                    let newSize = newValue as! CGSize
                    self.workTaskTableHeight.constant = newSize.height
                    print("adjusted")
                }
            }
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1{
            return 10
        } else if tableView.tag == 2{
            return 10
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell") as! TestCell
            
            if tableView.tag == 1{
                
                cell.textLabel?.text = "hggg"
                
            } else if tableView.tag == 2{
                cell.testLabel.text = "Test TestTest \(indexPath.row)"
                
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
    
}

