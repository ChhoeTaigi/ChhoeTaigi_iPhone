
import UIKit

class KamJitianResultTableViewCell: UITableViewCell {

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

    func bindData(model: KamJitianModel) {
        var pojUnicode = " "
        if (model.poj_unicode != nil && !model.poj_unicode!.isEmpty) {
            pojUnicode = model.poj_unicode!
        }
        
        var kiplmjUnicode = " "
        if (model.kiplmj_unicode != nil && !model.kiplmj_unicode!.isEmpty) {
            kiplmjUnicode = model.kiplmj_unicode!
        }
        
        var hanjiTaibun = " "
        if (model.hanji_taibun != nil && !model.hanji_taibun!.isEmpty) {
            hanjiTaibun = model.hanji_taibun!
        }
        var pojBunimUnicode = " "
        if (model.poj_bunim_unicode != nil && !model.poj_bunim_unicode!.isEmpty) {
            pojBunimUnicode = "(\(model.poj_bunim_unicode!))"
        }
        
        var hanloTaibunKaisoehPoj = " "
        if (model.hanlo_taibun_kaisoeh_poj != nil && !model.hanlo_taibun_kaisoeh_poj!.isEmpty) {
            hanloTaibunKaisoehPoj = model.hanlo_taibun_kaisoeh_poj!
        }
        
        pojContentLabel.text = pojUnicode
        kiplmjContentLabel.text = kiplmjUnicode
        hanloTaibunContentLabel.text = hanjiTaibun + pojBunimUnicode
        taibunKaisoehContentLabel.text = hanloTaibunKaisoehPoj
    }
}
