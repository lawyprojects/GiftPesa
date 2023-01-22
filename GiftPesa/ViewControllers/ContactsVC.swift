//
//  ContactsVC.swift
//  GiftPesa
//
//  Created by Lawrence Magerer on 21/01/2023.
//

import UIKit
import Contacts
class ContactsVC: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var contactsTable: UITableView!
    
    @IBOutlet weak var txtSearch: CustomTextField!
    // MARK: - Variables
    var contactsList: [Contact] = []
    var contactsListFiltered: [Contact] = []
    var updateSelectedContact: ((String)->())?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.txtSearch.delegate = self
        self.txtSearch.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        setupContactsTable()
        loadContacts()
    }
    

    // SETUP CONTACTS TABLE
    func setupContactsTable(){
        self.contactsTable.register(UINib(nibName: "ContactCell", bundle: nil), forCellReuseIdentifier:"ContactCell")
    }
    
    // LOAD CONTACTS
    func loadContacts(){
        let contactStore = CNContactStore()
        let keys = [
                CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
                        CNContactPhoneNumbersKey,
                        CNContactEmailAddressesKey
                ] as [Any]
        let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
        do {
            try contactStore.enumerateContacts(with: request){
                    (contact, stop) in
                // Array containing all unified contacts from everywhere
                let name = "\(contact.givenName) \(contact.familyName)"
                if contact.phoneNumbers.count > 0 {
                    if let phoneNumber = contact.phoneNumbers.first {
                        self.contactsList.append(Contact(name: name,phoneNumber: phoneNumber.value.stringValue))
                    }

                }
                
                self.contactsListFiltered = self.contactsList
            }
        } catch {
            print("unable to fetch contacts")
        }
        self.contactsTable.reloadData()
    }
    
    @IBAction func backTapped(_ sender: UITapGestureRecognizer) {
        
        self.dismiss(animated: true)
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
extension ContactsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.contactsListFiltered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : ContactCell? = tableView.dequeueReusableCell(withIdentifier : "ContactCell") as? ContactCell
        let contact = self.contactsListFiltered[indexPath.row]
        cell?.setupContact(contact: contact)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? ContactCell
        updateSelectedContact!((cell?.phoneNumber.text)!)
        self.dismiss(animated: false)
        
    }
    
    
}

extension ContactsVC : UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        //input text
        let searchText  = textField.text!
         if searchText.count > 0 {
             contactsListFiltered = contactsList
             let filtered = contactsListFiltered.filter { ($0.name?.replacingOccurrences(of: " ", with: "").lowercased().contains(searchText.replacingOccurrences(of: " ", with: "").lowercased())) ?? false }
             contactsListFiltered = filtered
             
         } else if searchText.count == 0 {
             contactsListFiltered = contactsList
         }
         contactsTable.reloadData()

    }
    

    

}

