//
//  HomeVC.swift
//  GiftPesa
//
//  Created by Lawrence Magerer on 17/01/2023.
//

import UIKit

class HomeVC: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var transactionsTable: UITableView!
    
    // MARK: - Variables
    var transactionsList: [Transaction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTransactionsTable()
        loadTransactionsTable()
    }
    
    // SETUP TRANSACTIONS TABLE
    func setupTransactionsTable(){
        self.transactionsTable.register(UINib(nibName: "TransactionsCell", bundle: nil), forCellReuseIdentifier:"TransactionsCell")
    }
    

    // LOAD RECENT TRANSACTIONS
    func loadTransactionsTable(){
        for i in 1..<10 {
            self.transactionsList.append(Transaction())
        }
        self.transactionsTable.reloadData()
    }
    @IBAction func sendGiftButtonTapped(_ sender: UITapGestureRecognizer) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SendGiftVC") as! SendGiftVC
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

//
extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : TransactionsCell? = tableView.dequeueReusableCell(withIdentifier : "TransactionsCell") as? TransactionsCell
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        88
    }
    
}
