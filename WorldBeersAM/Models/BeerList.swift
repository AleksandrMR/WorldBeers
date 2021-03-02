//
//  BeerList.swift
//  WorldBeersAM
//
//  Created by Aleksandr Milashevski on 28/02/21.
//

import Foundation

// MARK: - BeerListElement
struct BeerListElement: Codable {
    var id: Int?
    var name, tagline, firstBrewed, beerListDescription: String?
    var imageURL: String?
    var abv, ibu: Double?
    var targetFg: Double?
    var targetOg: Double?
    var ebc: Double?
    var srm: Double?
    var ph, attenuationLevel: Double?
    var volume, boilVolume: BoilVolume?
    var method: Method?
    var ingredients: Ingredients?
    var foodPairing: [String]?
    var brewersTips: String?

    enum CodingKeys: String, CodingKey {
        case id, name, tagline
        case firstBrewed = "first_brewed"
        case beerListDescription = "description"
        case imageURL = "image_url"
        case abv, ibu
        case targetFg = "target_fg"
        case targetOg = "target_og"
        case ebc, srm, ph
        case attenuationLevel = "attenuation_level"
        case volume
        case boilVolume = "boil_volume"
        case method, ingredients
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
    }
}

// MARK: - BoilVolume
struct BoilVolume: Codable {
    var value: Double?
    var unit: String?
}

// MARK: - Ingredients
struct Ingredients: Codable {
    var malt: [Malt]?
    var hops: [Hop]?
    var yeast: String?
}

// MARK: - Hop
struct Hop: Codable {
    var name: String?
    var amount: BoilVolume?
    var add: String?
    var attribute: String?
}
// MARK: - Malt
struct Malt: Codable {
    var name: String?
    var amount: BoilVolume?
}

// MARK: - Method
struct Method: Codable {
    var mashTemp: [MashTemp]?
    var fermentation: Fermentation?
    var twist: String?

    enum CodingKeys: String, CodingKey {
        case mashTemp = "mash_temp"
        case fermentation, twist
    }
}

// MARK: - Fermentation
struct Fermentation: Codable {
    var temp: BoilVolume?
}

// MARK: - MashTemp
struct MashTemp: Codable {
    var temp: BoilVolume?
    var duration: Int?
}
