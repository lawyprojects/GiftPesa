//
//  MerchantsVC.swift
//  GiftPesa
//
//  Created by Lawrence Magerer on 17/01/2023.
//

import UIKit
import JGProgressHUD
class MerchantsVC: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var txtSearch: CustomTextField!
    @IBOutlet weak var merchantsCollectionView: UICollectionView!
    
    // MARK: - Variables
    var mechantsList: [Merchant] = [Merchant]()
    var mechantsListFilter: [Merchant] = [Merchant]()
    let apiService = APIService()
    let progressView = JGProgressHUD()
    
    var refreshMerchantList: (([Merchant])->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        apiService.delegate = self
        self.txtSearch.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        self.txtSearch.delegate = self
        
        self.merchantsCollectionView.register(UINib(nibName: "MerchantsSelectedCell", bundle: nil), forCellWithReuseIdentifier:"MerchantsSelectedCell")
        
        self.loadMerchants()
    }
    
    // Load Merchants
    func loadMerchants(){
        let url = APIService.baseUrl + "2598c0cf-5647-4ecc-ba4b-15cbc14a2124"
        showProgress()
        apiService.APIRequest(url: url, requestBody: [:])
        
    }
    
    // setup Merchants List
    func setupMerchantsList(response: Data){
        guard let resp = try? JSONDecoder().decode(MerchantData.self, from: response) else {
            return
        }
        if let result = resp.result {
            if let message = result.message {
                self.mechantsList = message
                self.mechantsListFilter = self.mechantsList
                self.merchantsCollectionView.reloadData()
                
            }
        }
    }
    
    // get Selected Merchants
    func getSelectedMerchants()-> [Merchant]{
        var selectedMerchants: [Merchant] = []
        
        for i in 0..<self.mechantsListFilter.count {
            var merchant = self.mechantsListFilter[i]
            if merchant.checked == true {
                merchant.checked = false
                selectedMerchants.append(merchant)
            }
        }
        
        return selectedMerchants
    }
    
    @IBAction func backTapped(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        refreshMerchantList!(self.getSelectedMerchants())
        self.dismiss(animated: true)
        
        
    }
    
    func showProgress(){
        progressView.textLabel.text = "Loading..."
        progressView.show(in: self.view)
    }
    
    
    func dismissProgress(){
        progressView.dismiss(afterDelay: 0.0)
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
extension MerchantsVC: APIServiceDelegate {
    func successResponse(response: Data) {
        dismissProgress()
        setupMerchantsList(response: response)
    }
    
    func errorResponse(error: String) {
        dismissProgress()
    }
    
    
}

extension MerchantsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mechantsListFilter.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell : MerchantsSelectedCell? = collectionView.dequeueReusableCell(withReuseIdentifier : "MerchantsSelectedCell", for: indexPath) as? MerchantsSelectedCell
        let merchant = self.mechantsListFilter[indexPath.row]
        cell?.setMerchantData(data: merchant)
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let merchant = self.mechantsListFilter[indexPath.row]
        if(merchant.checked ?? false){
            self.mechantsListFilter[indexPath.row].checked = false
        }else {
            self.mechantsListFilter[indexPath.row].checked = true
        }
        collectionView.reloadData()
    }
    
}

extension MerchantsVC : UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        //input text
           let searchText  = textField.text!
    
            if searchText.count > 0 {
                mechantsListFilter = mechantsList
                let filtered = mechantsListFilter.filter { ($0.lookup_values_2?.replacingOccurrences(of: " ", with: "").lowercased().contains(searchText.replacingOccurrences(of: " ", with: "").lowercased())) ?? false}
                mechantsListFilter = filtered
                
            } else if searchText.count == 0 {
                mechantsListFilter = mechantsList
            }
        

          self.merchantsCollectionView.reloadData();

    }
}
