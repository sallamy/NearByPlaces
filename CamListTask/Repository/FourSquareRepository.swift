//
//  FourSquareRepository.swift
//  CamListTask
//
//  Created by mohamed salah on 10/21/21.
//

import Foundation
import UIKit
import Alamofire

class FourSquareRepository {
    
    func getPlaces(lat: String,lang: String,
                   complete:@escaping(_ success: Bool,_ places: [Item]? , _ error: String?)->Void) {
        AF.request(APIRouter.getPlaces(lat: lat, lang: lang)).validate().responseDecodable { (response: DataResponse<RootModel, AFError>) in
            
            switch response.result {
            case .success(let response):
                complete(true,response.response?.groups?.first?.items  , nil)
                break
            case .failure(let error):
                complete(false,nil, error.errorDescription )
                break
            }
        }
    }
}

