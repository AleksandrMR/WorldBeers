//
//  ServerPaths.swift
//  WorldBeersAM
//
//  Created by Aleksandr Milashevski on 28/02/21.
//

import Foundation

var indexOfPageToRequest = 1
var limitElementForPage = 25

var apiURL: String {
    return "https://api.punkapi.com/v2/"
}

enum ServerPaths: String {
    case allBeerList = "beers"
}

enum ServerParam: String {
    case numberOfPage = "page"
    case limitElement = "per_page"
}
