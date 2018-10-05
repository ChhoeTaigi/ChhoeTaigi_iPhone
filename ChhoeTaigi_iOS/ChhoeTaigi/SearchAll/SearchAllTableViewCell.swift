
import UIKit

class SearchAllTableViewCell: UITableViewCell {
    
    private let dictNameLabelActiveColor = #colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1)
    private let dictNameLabelInactiveColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 0.6038634418)
    private let searchResultLabelActiveColor = #colorLiteral(red: 0.3084011078, green: 0.5618229508, blue: 0, alpha: 1)
    private let searchResultLabelInactiveColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 0.6038634418)

    @IBOutlet weak var dictNameLabel: UILabel!
    @IBOutlet weak var searchResultLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setDictNameLabelActive(isActive: Bool) {
        if (isActive) {
            dictNameLabel.textColor = dictNameLabelActiveColor
        } else {
            dictNameLabel.textColor = dictNameLabelInactiveColor
        }
    }
    
    func setSearchResultLabelActive(isActive: Bool) {
        if (isActive) {
            searchResultLabel.textColor = searchResultLabelActiveColor
        } else {
            searchResultLabel.textColor = searchResultLabelInactiveColor
        }
    }
}
