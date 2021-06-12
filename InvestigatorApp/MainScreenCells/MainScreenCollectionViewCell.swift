//
//  mainScreenCollectionViewCell.swift
//  InvestigatorApp
//
//  Created by Артём on 6/11/21.
//

import UIKit

class MainScreenCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "MainScreenCollectionViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "MainScreenCollectionViewCell", bundle: nil)
    }
    
    @IBOutlet weak var cellview: UIImageView!
    @IBOutlet weak var caseNameLabel: UILabel!
    @IBOutlet weak var caseNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellview.layer.cornerRadius = 10
        // Initialization code
    }
    
//    func configureCell(with item: MSection) {
//        caseNameLabel.text = "\(item.price)"
//        caseNumberLabel.text = item.name
//    }


}
