//
//  HeaderTableViewCell.swift
//  TableViewExample
//
//  Created by Shaik, Suneelahammad (Cognizant) on 13/04/22.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func infoButtonPressed(_ sender: Any) {
        
        
    }
    
}
