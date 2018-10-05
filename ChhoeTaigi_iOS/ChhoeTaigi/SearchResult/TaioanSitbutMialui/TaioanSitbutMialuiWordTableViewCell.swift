
import UIKit

class TaioanSitbutMialuiWordTableViewCell: UITableViewCell {

    @IBOutlet weak var columnNameLabel: UILabel!
    @IBOutlet weak var columnContentLabel: UILabel!
    
    private let columnNames = ["白話字",
                               "白話字輸入",
                               "教育部羅馬字",
                               "教育部羅馬字輸入",
                               "漢字台文",
                               "原冊頁數",
                               "編號"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bindData(index: Int, model: TaioanSitbutMialuiModel) {
        var columnContent = " "
        
        if (index == 0) {
            columnContent = getContent(str: model.poj_unicode)
        } else if (index == 1) {
            columnContent = getContent(str: model.poj_input)
        } else if (index == 2) {
            columnContent = getContent(str: model.kiplmj_unicode)
        } else if (index == 3) {
            columnContent = getContent(str: model.kiplmj_input)
        } else if (index == 4) {
            columnContent = getContent(str: model.hanji_taibun)
        } else if (index == 5) {
            columnContent = getContent(str: model.page_number)
        } else if (index == 6) {
            columnContent = getContent(str: model.id)
        }
        
        columnNameLabel.text = columnNames[index]
        columnContentLabel.text = columnContent
    }
    
    func getContent(str: String?) -> String {
        if (str != nil && !str!.isEmpty) {
            return str!
        } else {
            return " "
        }
    }
}
