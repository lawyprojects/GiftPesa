//
//  MerchantsViewModel.swift
//  GiftPesa
//
//  Created by Lawrence Magerer on 19/01/2023.
//

import Foundation
import UIKit

public class MerchantsViewModel  {
    // MARK: - Constants
    let merchantsListPath = "2598c0cf-5647-4ecc-ba4b-15cbc14a2124"
    
    // MARK: Variables
    let apiService = APIService();
    
    var merchantsData: MerchantData?
    let merchantsList: DataBind<[Merchant]> = DataBind([])

    init(){
    
    }
    
    
    // GET Merchants
    public func getMerchants(){

        let merchantsListRequest = APIServiceRequest(method: .get, path: merchantsListPath, queryItems: [:])
        
//        apiService.APIRequest(request: merchantsListRequest, apiServiceTask: { [weak self] (result) in
//            guard let self = self else {
//                return
//            }
//            switch result {
//            case .success(let response):
//                if let response = try? response.decode(to: MerchantData.self) {
//                   
//                    DispatchQueue.main.async {
//                        self.merchantsData = response.body
//                        if let merchantsResult = self.merchantsListData.result {
//                            if let message = merchantsResult.message {
//                                self.merchantsListData = merchantsList
//                            }
//                        }
//                        
//                    }
//                    
//                } else {
//                    print(Error.decodingError)
//                }
//            case .failure:
//                print(Error.networkError)
//            }
//        })
    }

}

