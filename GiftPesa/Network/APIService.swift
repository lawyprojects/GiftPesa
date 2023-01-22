//
//  APIService.swift
//  GiftPesa
//
//  Created by Lawrence Magerer on 18/01/2023.
//

import Foundation
import Alamofire

public class APIService {
    
    // MARK: - Constants
    static let baseUrl = "https://run.mocky.io/v3/";
    
    //MARK :- Properties
    var delegate: APIServiceDelegate?
  
    // MARK: - API SERVICE Request
    func APIRequest(url : String, requestBody: [String : String]?, method: Alamofire.HTTPMethod = .get, addHeaders : Bool = false, progresslabel: String = "", showProgress: Bool = true) {
        
        AF.request(url,
                   method: method,
                   parameters: requestBody,
                   encoder: URLEncodedFormParameterEncoder.default
        ).responseData { response in
        
            switch response.result {
                case .success(let value):
                    self.delegate?.successResponse(response: value)
                
                case .failure(let error):
                    print(error)
                    self.delegate?.errorResponse(error: "An Error occurred. Please try again!!!")
                
            }
            
        }
    }
    
}

public protocol APIServiceDelegate{
    func successResponse(response: Data)
    func errorResponse(error: String)
}
