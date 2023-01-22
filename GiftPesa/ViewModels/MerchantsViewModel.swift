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


}

