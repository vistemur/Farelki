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
