//
//  DrinksTableViewCell.swift
//  TableViewExample
//
//  Created by Shaik, Suneelahammad (Cognizant) on 13/04/22.
//

import UIKit

protocol DrinksTableViewCellProtocol: AnyObject {
    func tappedCell(index: Int)
}

class DrinksTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var drinkNameLbl: UILabel!
    @IBOutlet weak var drinkCategoryLbl: UILabel!
    @IBOutlet weak var drinkAlcoholicLbl: UILabel!
    @IBOutlet weak var drinkImageView: UIImageView!
    
    weak var cellDelegate: DrinksTableViewCellProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.containerView.layer.cornerRadius = 10.0
        self.containerView.layer.borderWidth = 1.0
        self.containerView.layer.borderColor = UIColor.gray.cgColor
        self.containerView.layer.masksToBounds = true
        
        
        self.drinkImageView.layer.cornerRadius = self.drinkImageView.bounds.height / 2
        self.drinkImageView.layer.masksToBounds = true
        
        self.drinkImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(getRowTapped)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDrink(_ drink: Drink, indexPath: IndexPath) {
        
        self.drinkNameLbl.text = drink.strDrink
        self.drinkCategoryLbl.text = drink.strCategory
        self.drinkAlcoholicLbl.text = drink.strAlcoholic
        
        let imageURLString = drink.strDrinkThumb
        if let url = URL(string: imageURLString), let data = try? Data(contentsOf: url) {
            self.drinkImageView.image = UIImage(data: data)
        }
        
        self.tag = indexPath.row
    }
    
    @objc func getRowTapped() {
        cellDelegate?.tappedCell(index: self.tag)
    }

}
