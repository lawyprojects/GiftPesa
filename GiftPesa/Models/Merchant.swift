//
//  Merchant.swift
//  GiftPesa
//
//  Created by Lawrence Magerer on 18/01/2023.
//

import Foundation
import UIKit
struct Merchant: Codable {
    var lookup_code: String?
    var lookup_values_1: String
    var lookup_values_2: String?
    var lookup_values_3: String?
    var lookup_values_4: String?
    var checked: Bool? = false
    //var image: UIImage?
    
}


struct MerchantData : Codable {
    var result: MerchantMessage?
}
struct MerchantMessage : Codable {
    var message: [Merchant]?
}

