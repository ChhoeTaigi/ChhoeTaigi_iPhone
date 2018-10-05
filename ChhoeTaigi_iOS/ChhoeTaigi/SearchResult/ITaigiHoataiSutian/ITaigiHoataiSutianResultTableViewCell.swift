
import UIKit

class ITaigiHoataiSutianResultTableViewCell: UITableViewCell {

    @IBOutlet weak var pojContentLabel: UILabel!
    @IBOutlet weak var kiplmjContentLabel: UILabel!
    @IBOutlet weak var hanloTaibunContentLabel: UILabel!
    @IBOutlet weak var hoabunContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bindData(model: ITaigiHoataiSutianModel) {
        var pojUnicode = " "
        if (model.poj_unicode != nil && !model.poj_unicode!.isEmpty) {
            pojUnicode = model.poj_unicode!
        }
        
        var kiplmjUnicode = " "
        if (model.kiplmj_unicode != nil && !model.kiplmj_unicode!.isEmpty) {
            kiplmjUnicode = model.kiplmj_unicode!
        }
        
        var hanloTaibunKiplmj = " "
        if (model.hanlo_taibun_kiplmj != nil && !model.hanlo_taibun_kiplmj!.isEmpty) {
            hanloTaibunKiplmj = model.hanlo_taibun_kiplmj!
        }
        
        var hoabun = " "
        if (model.hoabun != nil && !model.hoabun!.isEmpty) {
            hoabun = model.hoabun!
        }
        
        pojContentLabel.text = pojUnicode
        kiplmjContentLabel.text = kiplmjUnicode
        hanloTaibunContentLabel.text = hanloTaibunKiplmj
        hoabunContentLabel.text = hoabun
    }
}
