//
//  ContactsListTableCell.swift
//  Chat
//
//  Created by роман поздняков on 08/04/2019.
//  Copyright © 2019 romchick. All rights reserved.
//

import UIKit

final class ContactsListTableCell: UITableViewCell {
    
    static let reuseId = "ContactsListTableCell"
    
    @IBOutlet private weak var sectionLabel: UILabel!
    @IBOutlet private weak var rowLabel: UILabel!
    @IBOutlet private weak var potionLabel: UILabel!
    
    func updateContent(sectionText: String,
                       rowText: String,
                       portion: String) {
        sectionLabel.text = sectionText
        rowLabel.text = rowText
        potionLabel.text = portion
    }
}
