//
//  ContactCell.swift
//  GiftPesa
//
//  Created by Lawrence Magerer on 21/01/2023.
//

import UIKit
import Contacts
class ContactCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var name: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupContact(contact: Contact){
        self.name.text = contact.name
        self.phoneNumber.text = contact.phoneNumber
    }
    
}
