//
//  RickMortyService.swift
//  Rick And Morty
//
//  Created by Burak AKCAN on 16.07.2022.
//

import Alamofire
import Foundation

enum RickMortyServiceEndPoint:String{
    case BASEURL = "https://rickandmortyapi.com/api"
    case PATH = "/character"
    static func urlPath()->String{
        return "\(BASEURL.rawValue)\(PATH.rawValue)"
    }
}

protocol IRickMortyService{
    func fetcAllData(response:@escaping ([Result]?)->())
}

struct RickMortyService:IRickMortyService{
    func fetcAllData(response:@escaping ([Result]?) ->Void ) {
        AF.request(RickMortyServiceEndPoint.urlPath()).responseDecodable(of: RickMortyModel.self) { (model) in
            guard let data = model.value else{return}
            
            response(data.results)
        }
    }
}

