//
//  BeersVC.swift
//  WorldBeersAM
//
//  Created by Aleksandr Milashevski on 28/02/21.
//

import UIKit
import Network

class BeersVC: UIViewController {
    
    //    MARK: - Outlets
    @IBOutlet weak private var beersTableView: UITableView!
    @IBOutlet weak private var beerSearchBar: UISearchBar!
    @IBOutlet weak private var containerSearchBarView: UIView!
    @IBOutlet weak private var checkConnectView: UIView!
    
    //    MARK: - var
    private var viewModel: BeersViewModel = .init()
    internal var filteredArray = [BeerListElement]()
    
    var beerList: [BeerListElement] = .init() {
        didSet {
            DispatchQueue.main.async {
                self.beersTableView.reloadData()
            }
        }
    }
    
    private var searchBarIsEmpty: Bool {
        guard let text = beerSearchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return !searchBarIsEmpty
    }
    
    //    MARK: - Lifecycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindUI()
        configUI()
        configTableView()
        configSearchBar()
        monitorNetwork()
        viewModel.getBeerList()
    }
    
    //    MARK: - Flow funcs
    private func bindUI() {
        viewModel.beerList.bind { [weak self] list in
            self?.beerList = list
        }
    }
    
    private func configUI() {
        containerSearchBarView.myShadowTopBar()
        navigationItem.title = "Beers".localized
    }
    
    private func configTableView() {
        beersTableView.delegate = self
        beersTableView.dataSource = self
        beersTableView.separatorStyle = .none
    }
    
    private func configSearchBar() {
        beerSearchBar.searchBarStyle = .minimal
        beerSearchBar.scopeButtonTitles = ["BeerName", "BeerDescript"]
        beerSearchBar.delegate = self
    }
    
    private func monitorNetwork() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self.checkConnectView.isHidden = true
                    print("internet connection is present")
                }
            } else {
                DispatchQueue.main.async {
                    self.checkConnectView.isHidden = false
                    print("no internet connection")
                }
            }
        }
        let queue = DispatchQueue.global()
        monitor.start(queue: queue)
    }
}

//MARK: - UITableViewDelegate + UITableViewDataSource
extension BeersVC: UITableViewDelegate, UITableViewDataSource {
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredArray.count
        }
        return beerList.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeersViewCell") as? BeersViewCell else {
            return UITableViewCell()
        }
        
        if isFiltering {
            cell.configCell(with: filteredArray[indexPath.row])
        } else {
            cell.configCell(with: beerList[indexPath.row])
        }
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if #available(iOS 13.0, *) {
            guard let controller = UIStoryboard(name: "Detailed", bundle: nil).instantiateViewController(identifier: "DetailedVC") as? DetailedVC else { return }
            controller.detailBeer = beerList[indexPath.row]
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
            // Fallback on earlier versions
            func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                guard segue.identifier == "showDetails" else { return }
                guard let destination = segue.destination as? DetailedVC else { return }
                destination.detailBeer = beerList[indexPath.row]
            }
        }
    }
}

//MARK: - UIScrollViewDelegate
extension BeersVC: UIScrollViewDelegate {
    
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // calculates where the user is in the y-axis
        let headerViewhight = containerSearchBarView.frame.size.height
        let position = scrollView.contentOffset.y + headerViewhight
        let contentHeight = view.bounds.size.height
        let scrollViewHight = scrollView.frame.size.height
        
        if position > (contentHeight - scrollViewHight) {
            
            // increments the number of the page and send request
            indexOfPageToRequest += 1
            viewModel.getBeerList()
        }
    }
}

//MARK: - UISearchBarDelegate
extension BeersVC: UISearchBarDelegate {
    
    internal func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredArray = beerList.filter {(beerList: BeerListElement) -> Bool in
            return (beerList.name?.lowercased().contains(searchText.lowercased()) ?? false &&
                        beerList.beerListDescription?.lowercased().contains(searchText.lowercased()) ?? false)
        }
        self.beersTableView.reloadData()
    }
    
    internal func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    internal func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        
        DispatchQueue.main.async {
            self.beersTableView.reloadData()
        }
    }
}
