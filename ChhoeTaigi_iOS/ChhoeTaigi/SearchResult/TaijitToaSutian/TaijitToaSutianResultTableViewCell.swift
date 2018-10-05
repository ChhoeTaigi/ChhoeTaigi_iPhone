
import UIKit

class TaijitToaSutianResultTableViewCell: UITableViewCell {

    @IBOutlet weak var pojContentLabel: UILabel!
    @IBOutlet weak var kiplmjContentLabel: UILabel!
    @IBOutlet weak var hanloTaibunContentLabel: UILabel!
    @IBOutlet weak var taibunKaisoehContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bindData(model: TaijitToaSutianModel) {
        let pojStringPart1 = model.poj_unicode ?? ""
        var pojStringPart2 = ""
        if (model.poj_input_dialect != nil && !model.poj_input_dialect!.isEmpty) {
            pojStringPart2 = "/"
        }
        let pojStringPart3 = model.poj_unicode_dialect ?? ""
        var pojString = "\(pojStringPart1)\(pojStringPart2)\(pojStringPart3)"
        if (pojString.isEmpty) {
            pojString = " "
        }
        
        let kiplmjStringPart1 = model.kiplmj_unicode ?? ""
        var kiplmjStringPart2 = ""
        if (model.kiplmj_unicode_dialect != nil && !model.kiplmj_unicode_dialect!.isEmpty) {
            kiplmjStringPart2 = "/"
        }
        let kiplmjStringPart3 = model.kiplmj_unicode_dialect ?? ""
        var kiplmjString = "\(kiplmjStringPart1)\(kiplmjStringPart2)\(kiplmjStringPart3)"
        if (kiplmjString.isEmpty) {
            kiplmjString = " "
        }
        
        var hanloTaibunPoj = " "
        if (model.hanlo_taibun_poj != nil && !model.hanlo_taibun_poj!.isEmpty) {
            hanloTaibunPoj = model.hanlo_taibun_poj!
        }
        
        var hanloTaibunKaisoehPoj = " "
        if (model.hanlo_taibun_kaisoeh_poj != nil && !model.hanlo_taibun_kaisoeh_poj!.isEmpty) {
            hanloTaibunKaisoehPoj = model.hanlo_taibun_kaisoeh_poj!
        }
        
        pojContentLabel.text = pojString
        kiplmjContentLabel.text = kiplmjString
        hanloTaibunContentLabel.text = hanloTaibunPoj
        taibunKaisoehContentLabel.text = hanloTaibunKaisoehPoj
    }
}
