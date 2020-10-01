
import UIKit

class KauiokpooTaigiDictWordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var columnNameLabel: UILabel!
    @IBOutlet weak var columnContentLabel: UILabel!
    
    public static let columnNames = ["白話字",
                                     "白話字（其他講法）",
                                     "白話字輸入",
                                     "白話字輸入（其他講法）",
                                     "教育部羅馬字",
                                     "教育部羅馬字（其他講法）",
                                     "教育部羅馬字輸入",
                                     "教育部羅馬字輸入（其他講法）",
                                     "漢字台文",
                                     "華文",
                                     "華文解說、詞性，台文例詞kap例句",
                                     "字詞屬性",
                                     "文白屬性",
                                     "其他講法ê類型",
                                     "編號"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func bindData(index: Int, model: KauiokpooTaigiSutianModel) {
        var columnContent = " "
        
        if (index == 0) {
            columnContent = getContent(str: model.poj_unicode)
        } else if (index == 1) {
            columnContent = getContent(str: model.poj_unicode_dialect)
        } else if (index == 2) {
            columnContent = getContent(str: model.poj_input)
        } else if (index == 3) {
            columnContent = getContent(str: model.poj_input_dialect)
        } else if (index == 4) {
            columnContent = getContent(str: model.kiplmj_unicode)
        } else if (index == 5) {
            columnContent = getContent(str: model.kiplmj_unicode_dialect)
        } else if (index == 6) {
            columnContent = getContent(str: model.kiplmj_input)
        } else if (index == 7) {
            columnContent = getContent(str: model.kiplmj_input_dialect)
        } else if (index == 8) {
            columnContent = getContent(str: model.hanji_taibun)
        } else if (index == 9) {
            columnContent = getContent(str: model.hoabun)
        } else if (index == 10) {
            columnContent = getContent(str: model.descriptions)
            
            // fix new line display
            columnContent = columnContent
                .replacingFirstOccurrence(of: " 2.", with: " \n2.")
                .replacingFirstOccurrence(of: " 3.", with: " \n3.")
                .replacingFirstOccurrence(of: " 4.", with: " \n4.")
                .replacingFirstOccurrence(of: " 5.", with: " \n5.")
                .replacingFirstOccurrence(of: " 6.", with: " \n6.")
                .replacingFirstOccurrence(of: " 7.", with: " \n7.")
                .replacingFirstOccurrence(of: " 8.", with: " \n8.")
                .replacingFirstOccurrence(of: " 9.", with: " \n9.")
                .replacingFirstOccurrence(of: "10.", with: "\n10.")
                .replacingFirstOccurrence(of: "11.", with: "\n11.")
                .replacingFirstOccurrence(of: "12.", with: "\n12.")
                .replacingFirstOccurrence(of: "13.", with: "\n13.")
        } else if (index == 11) {
            columnContent = getContent(str: model.word_property)
        } else if (index == 12) {
            columnContent = getContent(str: model.word_bunpeh_property)
        } else if (index == 13) {
            columnContent = getContent(str: model.word_dialect_property)
        } else if (index == 14) {
            columnContent = getContent(str: model.id)
        }
        
        columnNameLabel.text = KauiokpooTaigiDictWordTableViewCell.columnNames[index]
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

extension KauiokpooTaigiDictWordTableViewCell: ContentLabelContainer {}
