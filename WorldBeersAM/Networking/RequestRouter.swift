//
//  RequestRouter.swift
//  WorldBeersAM
//
//  Created by Aleksandr Milashevski on 28/02/21.
//

import Foundation
import Alamofire

enum RequestRouter: URLRequestBuilder {
    case getListOfBeers(pagen: Int, limit: Int)
    
    var path: String {
        switch self {
        case .getListOfBeers:
            return ServerPaths.allBeerList.rawValue
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        default:
            return nil
        }
    }
    
    var parametrs: Parameters? {
        var param = Parameters()
        switch self {
        case .getListOfBeers(pagen: let pagen, limit: let limit):
            param[ServerParam.numberOfPage.rawValue] = pagen
            param[ServerParam.limitElement.rawValue] = limit
        }
        return param
    }
    
    var method: HTTPMethod {
        switch self {
        case .getListOfBeers:
            return .get
        }
    }
}
