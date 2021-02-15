//
//  ListTableViewCell.swift
//  Shaadi.com Assignment
//
//  Created by Aman on 29/01/21.
//

import UIKit

protocol ListTableViewCellProtocol {
    func userFavoriteDidUpdate(starred: Bool)
}

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- Cell Setup
    func setupCell(userModel: UserModel) {
        nameLabel.text = userModel.name ?? "Guest"
        phoneLabel.text = (userModel.phone ?? "") + (userModel.website ?? "")
        companyNameLabel.text = userModel.companyModel?.name ?? "Not Available"
        starButton.setImage(userModel.starred ? UIImage(named: "starred") : UIImage(named: "star") , for: .normal)
    }
    
}
