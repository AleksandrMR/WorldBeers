//
//  BeersViewModel.swift
//  WorldBeersAM
//
//  Created by Aleksandr Milashevski on 28/02/21.
//

import Foundation
import Alamofire

class BeersViewModel: UIViewController {
    
    //    MARK: - let
    let requestManager: RequestManager<RequestRouter> = .init()
    
    //    MARK: - var
    var beerList: Bindable<[BeerListElement]> = Bindable([BeerListElement]())
    
    //    MARK: - Flow funcs
    func getBeerList() {
        requestManager.send(service: .getListOfBeers(pagen: indexOfPageToRequest, limit: limitElementForPage), decodeType: [BeerListElement].self) { list in
            switch list {
            case .success(let data):
                self.beerList.value.append(contentsOf: data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
