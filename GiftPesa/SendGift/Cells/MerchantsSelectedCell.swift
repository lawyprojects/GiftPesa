//
//  MerchantsSelectedCell.swift
//  GiftPesa
//
//  Created by Lawrence Magerer on 18/01/2023.
//

import UIKit

class MerchantsSelectedCell: UICollectionViewCell {

    @IBOutlet weak var imageMerchant: UIImageView!
    @IBOutlet weak var imageChecked: UIImageView!
    
    @IBOutlet weak var nameMerchant: UILabel!
    // MARK: - Variables
    
    var merchant: Merchant?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setMerchantData(data: Merchant){
        self.merchant = data
        self.nameMerchant.text = data.lookup_values_1
        if(data.checked == true){
            imageChecked.isHidden = false
        }else{
            imageChecked.isHidden = true
        }
        
        if let lookup_values_2 = data.lookup_values_2 {
            if let image = UIImage(named: lookup_values_2){
                self.imageMerchant.image = image
            }else {
                self.imageMerchant.image = UIImage(named: "ic_gift")
            }
        }else {
            self.imageMerchant.image = UIImage(named: "ic_gift")
        }
    }
       
    
    
    

}
