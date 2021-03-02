//
//  HomeVC.swift
//  WorldBeersAM
//
//  Created by Aleksandr Milashevski on 28/02/21.
//

import UIKit

class HomeVC: UIViewController {

    //    MARK: - Outlets
    @IBOutlet weak private var brandNameLabel: UILabel!
    @IBOutlet weak private var infoBrandLabel: UILabel!
    
    //    MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    //    MARK: - Flow funcs
    private func configUI() {
        brandNameLabel.text = Constants.brandName
        infoBrandLabel.text = Constants.infoBrand
    }
}
