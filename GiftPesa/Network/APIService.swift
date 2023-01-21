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
//    func APIRequest(request: APIServiceRequest,apiServiceTask: @escaping APIServiceTask){
//
//        var urlBuilder = URLComponents()
//        urlBuilder.scheme = "https"
//        urlBuilder.host = APIService.host
//        urlBuilder.path = request.path!
//
//        if let path = request.path {
//            urlBuilder.path = path
//        }
//
//        let queryItems = request.queryItems?.map({
//            URLQueryItem(name: $0.key, value: "\($0.value)")
//        })
//        // Add Query Params to request
//        urlBuilder.queryItems = queryItems
//
//        URLSession.shared.dataTask(with: urlBuilder.url!) { (data, response, error) in
//
//          DispatchQueue.main.async {
//
//            guard error == nil else {
//                print(Error.requestError)
//                apiServiceTask(.failure(.requestError))
//              return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse else {
//                 print(Error.requestError)
//                  apiServiceTask(.failure(.requestError))
//                  return
//            }
//
//            guard let data = data else {
//                print(Error.dataError)
//                apiServiceTask(.failure(.dataError))
//              return
//            }
//            apiServiceTask(.success(APIServiceResponse<Data?>(statusCode: httpResponse.statusCode,
//                                                         body: data)))
//
//          }
//        }.resume()
//
//        AF.request(urlBuilder.url!,
//                   method: .get,
//                   parameters: request.queryItems,
//                   encoder: URLEncodedFormParameterEncoder.default
//        ).responseData { response in
//
//            switch response.result {
//                case .success(let value):
//                    self.delegate?.successResponse(response: value)
//
//                case .failure(let error):
//                    print(error)
//                    self.delegate?.errorResponse(error: "An Error occurred. Please try again!!!")
//
//            }
//
//        }
//
//    }

    
}

public protocol APIServiceDelegate{
    func successResponse(response: Data)
    func errorResponse(error: String)
}
