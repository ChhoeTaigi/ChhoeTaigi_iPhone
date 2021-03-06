
import UIKit

class TaioanSitbutMialuiResultTableViewCell: UITableViewCell {

    @IBOutlet weak var pojContentLabel: UILabel!
    @IBOutlet weak var kiplmjContentLabel: UILabel!
    @IBOutlet weak var hanjiTaibunContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bindData(model: TaioanSitbutMialuiModel) {
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
        
        pojContentLabel.text = pojUnicode
        kiplmjContentLabel.text = kiplmjUnicode
        hanjiTaibunContentLabel.text = hanjiTaibun
    }
}
