//
//  BeersViewCell.swift
//  WorldBeersAM
//
//  Created by Aleksandr Milashevski on 28/02/21.
//

import UIKit
import Kingfisher

class BeersViewCell: UITableViewCell {

    //    MARK: - Outlets
    @IBOutlet weak var contentSubView: UIView!
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var ibuIndexLabel: UILabel!
    @IBOutlet weak var abvIndexLabel: UILabel!
    
    //    MARK: - let
    let noDataValue = "N/A"
    
    //    MARK: - Flow funcs
    override func awakeFromNib() {
        super.awakeFromNib()
        descriptionTextView.isEditable = false
        contentSubView.layer.cornerRadius = Constants.viewCornerValue
        contentSubView.myShadow()
        beerImageView.layer.cornerRadius = Constants.viewCornerValue
    }

    func configCell(with beerList: BeerListElement) {
        guard let imageURL = beerList.imageURL else { return }
        guard let myURL = URL(string: imageURL) else { return }
        beerImageView.kf.indicatorType = .activity
        beerImageView.kf.setImage(with: myURL)
            
        guard let beerName = beerList.name else { return }
        guard let beerDescription = beerList.beerListDescription else { return }
        guard let indexABV = beerList.abv else { return }
        guard let indexIBU = beerList.ibu else { return }
        
        nameLabel.text = beerName
        descriptionTextView.text = beerDescription
        
        if indexABV == 0.0 && indexIBU == 0.0 {
            abvIndexLabel.text = noDataValue
            ibuIndexLabel.text = noDataValue
        } else {
            abvIndexLabel.text = String(indexABV)
            ibuIndexLabel.text = String(indexIBU)
        }
    }
}
