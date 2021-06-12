//
//  MainScreenTableViewCell.swift
//  InvestigatorApp
//
//  Created by Артём on 6/12/21.
//

import UIKit

protocol  MainScreenTableViewCellDelegate: class {
    func checkBoxToggle(sender: MainScreenTableViewCell)
}

class MainScreenTableViewCell: UITableViewCell {
    
    weak var delegate: MainScreenTableViewCellDelegate?
    
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    static let reuseId = "MainScreenTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "MainScreenTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func checkToggled(_ sender: UIButton) {
        delegate?.checkBoxToggle(sender: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
