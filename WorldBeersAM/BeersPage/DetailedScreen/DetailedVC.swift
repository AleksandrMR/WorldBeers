//
//  DetailedVC.swift
//  WorldBeersAM
//
//  Created by Aleksandr Milashevski on 28/02/21.
//

import UIKit

class DetailedVC: UIViewController {
    
    //    MARK: - Outlets
    @IBOutlet weak private var firstBrewedView: UIView!
    @IBOutlet weak private var foodPairingView: UIView!
    @IBOutlet weak private var brewersTipsVeiw: UIView!
    @IBOutlet weak private var foodTextView: UITextView!
    @IBOutlet weak private var brewersTextView: UITextView!
    @IBOutlet weak private var firstBrewedLabel: UILabel!
    @IBOutlet weak private var foodParingLabel: UILabel!
    @IBOutlet weak private var brewersLabel: UILabel!
    @IBOutlet weak private var firstBrewedValueLabel: UILabel!
    
    //    MARK: - var
    var detailBeer: BeerListElement = .init() {
        didSet {
            DispatchQueue.main.async {
                self.setupData()
            }
        }
    }
    
    //    MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
    }
    
    //    MARK: - Flow funcs
    private func setupUI() {
        firstBrewedView.layer.cornerRadius = Constants.viewCornerValue
        foodPairingView.layer.cornerRadius = Constants.viewCornerValue
        brewersTipsVeiw.layer.cornerRadius = Constants.viewCornerValue
        foodTextView.layer.cornerRadius = Constants.viewCornerValue
        brewersTextView.layer.cornerRadius = Constants.viewCornerValue
        
        firstBrewedView.myShadow()
        foodPairingView.myShadow()
        brewersTipsVeiw.myShadow()
        
        foodTextView.isEditable = false
        brewersTextView.isEditable = false
        
        firstBrewedLabel.text = Constants.firstBrewedLabelText
        foodParingLabel.text = Constants.foodParingLabelText
        brewersLabel.text = Constants.brewersLabelText
        
        DispatchQueue.main.async {
            self.navigationItem.title = self.detailBeer.name
        }
    }
    
    private func setupData() {
        guard let firstBr = detailBeer.firstBrewed else { return }
        guard let foodPair = detailBeer.foodPairing else { return }
        guard let brewers = detailBeer.brewersTips else { return }
        
        let joined = foodPair.joined(separator: ", ")
        
        self.foodTextView.text = joined
        self.firstBrewedValueLabel.text = "since \(firstBr)"
        self.brewersTextView.text = brewers
    }
}
