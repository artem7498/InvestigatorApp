//
//  AllCasesTableViewCell.swift
//  InvestigatorApp
//
//  Created by Артём on 6/19/21.
//

import UIKit

class AllCasesTableViewCell: UITableViewCell {

    @IBOutlet weak var caseImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
