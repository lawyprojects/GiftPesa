//
//  SendGiftVC.swift
//  GiftPesa
//
//  Created by Lawrence Magerer on 17/01/2023.
//

import UIKit
import DropDown

class SendGiftVC: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var paymentMethod: UILabel!
    @IBOutlet weak var contact: CustomTextField!
    @IBOutlet weak var merchantsCollectionsView: UICollectionView!
    
    // MARK: - Variable
    var mechantsList: [Merchant] = [Merchant]()
    lazy var dropDown  =  DropDown(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.merchantsCollectionsView.register(UINib(nibName: "MerchantsSelectedCell", bundle: nil), forCellWithReuseIdentifier:"MerchantsSelectedCell")
        
        self.merchantsCollectionsView.register(UINib(nibName: "AddMerchantCell", bundle: nil), forCellWithReuseIdentifier:"AddMerchantCell")
        self.contact.setRightPaddingPoints(60)
        self.setupDropDown()
        self.setupMerchants()
    }
    
    func setupDropDown() {
        dropDown.anchorView = paymentMethod
        dropDown.dataSource = ["MPESA", "CASH"]
        // Top of drop down will be below the anchorView
        dropDown.bottomOffset = CGPoint(x: 0, y: 0)
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            self.paymentMethod.text = item
            
        }
        
        self.paymentMethod.text = dropDown.dataSource.first
        
    }

    // Setup Merchants
    func setupMerchants(){
        // ADD MERCHANT
        self.mechantsList = []
        self.mechantsList.append(Merchant(lookup_values_1: "Add Merchant"))
    }
    
    // Update Selected Merchants
    func updateSelectedMerchants(list: [Merchant]){
        setupMerchants()
        self.mechantsList.append(contentsOf: list)
        self.merchantsCollectionsView.reloadData()
    }
    
    func updateSelectedContact(phoneNumber: String){
        self.contact.text = phoneNumber
    }
    
    @IBAction func backTapped(_ sender: UITapGestureRecognizer) {
        
        self.dismiss(animated: true)
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func dropdownTapped(_ sender: UITapGestureRecognizer) {
        dropDown.show()
    }
    
    @IBAction func dropdownOptionTapped(_ sender: UITapGestureRecognizer) {
        dropDown.show()
    }
    
    @IBAction func searchButtonTapped(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ContactsVC") as! ContactsVC
        vc.updateSelectedContact = updateSelectedContact
        self.present(vc, animated: false, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SendGiftVC : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mechantsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(indexPath.row == 0){
            var cell : AddMerchantCell? = collectionView.dequeueReusableCell(withReuseIdentifier : "AddMerchantCell", for: indexPath) as? AddMerchantCell
            
            return cell!
        }else {
            var cell : MerchantsSelectedCell? = collectionView.dequeueReusableCell(withReuseIdentifier : "MerchantsSelectedCell", for: indexPath) as? MerchantsSelectedCell
            let merchant = self.mechantsList[indexPath.row]
            cell?.setMerchantData(data: merchant)
            
            return cell!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.row == 0){
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MerchantsVC") as! MerchantsVC
            vc.refreshMerchantList = updateSelectedMerchants(list:)
            self.present(vc, animated: false, completion: nil)
        }else {
            
        }
    }
    
    
}

extension String
{
  func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat
  {
    let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height);

      let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

    return boundingBox.width;
  }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
