
import UIKit

class KauiokpooTaigiDictResultTableViewCell: UITableViewCell {

    @IBOutlet weak var pojContentLabel: UILabel!
    @IBOutlet weak var kiplmjContentLabel: UILabel!
    @IBOutlet weak var hanjiTaibunContentLabel: UILabel!
    @IBOutlet weak var hoabunContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bindData(model: KauiokpooTaigiSutianModel) {
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
        
        var hanjiTaibun = " "
        if (model.hanji_taibun != nil && !model.hanji_taibun!.isEmpty) {
            hanjiTaibun = model.hanji_taibun!
        }
        
        var hoabun = " "
        if (model.hoabun != nil && !model.hoabun!.isEmpty) {
            hoabun = model.hoabun!
        }
        
        pojContentLabel.text = pojString
        kiplmjContentLabel.text = kiplmjString
        hanjiTaibunContentLabel.text = hanjiTaibun
        hoabunContentLabel.text = hoabun
    }
}
