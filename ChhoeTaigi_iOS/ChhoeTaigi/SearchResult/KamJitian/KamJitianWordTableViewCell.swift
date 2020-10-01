
import UIKit

class KamJitianWordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var columnNameLabel: UILabel!
    @IBOutlet weak var columnContentLabel: UILabel!
    
    public static let columnNames = ["白話字",
                                     "白話字輸入",
                                     "漢字台文",
                                     "文音(白話字)",
                                     "文音(白話字輸入)",
                                     "台文解說(白話字)",
                                     "漢羅台文解說（白話字）",
                                     "教育部羅馬字",
                                     "教育部羅馬字輸入",
                                     "文音(教育部羅馬字)",
                                     "文音(教育部羅馬字輸入)",
                                     "台文解說（教育部羅馬字）",
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

    func bindData(index: Int, model: KamJitianModel) {
        var columnContent = " "
        
        if (index == 0) {
            columnContent = getContent(str: model.poj_unicode)
        } else if (index == 1) {
            columnContent = getContent(str: model.poj_input)
        } else if (index == 2) {
            columnContent = getContent(str: model.hanji_taibun)
        } else if (index == 3) {
            columnContent = getContent(str: model.poj_bunim_unicode)
        } else if (index == 4) {
            columnContent = getContent(str: model.poj_bunim_input)
        } else if (index == 5) {
            columnContent = getContent(str: model.poj_kaisoeh)
        } else if (index == 6) {
            columnContent = getContent(str: model.hanlo_taibun_kaisoeh_poj)
        } else if (index == 7) {
            columnContent = getContent(str: model.kiplmj_unicode)
        } else if (index == 8) {
            columnContent = getContent(str: model.kiplmj_input)
        } else if (index == 9) {
            columnContent = getContent(str: model.kiplmj_bunim_unicode)
        } else if (index == 10) {
            columnContent = getContent(str: model.kiplmj_bunim_input)
        } else if (index == 11) {
            columnContent = getContent(str: model.kiplmj_kaisoeh)
        } else if (index == 12) {
            columnContent = getContent(str: model.page_number)
        } else if (index == 13) {
            columnContent = getContent(str: model.id)
        }
        
        columnNameLabel.text = KamJitianWordTableViewCell.columnNames[index]
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

extension KamJitianWordTableViewCell: ContentLabelContainer {}
