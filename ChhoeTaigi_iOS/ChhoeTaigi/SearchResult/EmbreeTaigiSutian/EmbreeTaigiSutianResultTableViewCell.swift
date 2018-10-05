
import UIKit

class EmbreeTaigiSutianResultTableViewCell: UITableViewCell {

    @IBOutlet weak var pojContentLabel: UILabel!
    @IBOutlet weak var kiplmjContentLabel: UILabel!
    @IBOutlet weak var hoabunContentLabel: UILabel!
    @IBOutlet weak var engbunContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bindData(model: EmbreeTaigiSutianModel) {
        var pojUnicode = " "
        if (model.poj_unicode != nil && !model.poj_unicode!.isEmpty) {
            pojUnicode = model.poj_unicode!
        }
        
        var kiplmjUnicode = " "
        if (model.kiplmj_unicode != nil && !model.kiplmj_unicode!.isEmpty) {
            kiplmjUnicode = model.kiplmj_unicode!
        }
        
        var hoabun = " "
        if (model.hoabun != nil && !model.hoabun!.isEmpty) {
            hoabun = model.hoabun!
        }
        
        var engbun = " "
        if (model.english_descriptions != nil && !model.english_descriptions!.isEmpty) {
            engbun = model.english_descriptions!
        }
        
        pojContentLabel.text = pojUnicode
        kiplmjContentLabel.text = kiplmjUnicode
        hoabunContentLabel.text = hoabun
        engbunContentLabel.text = engbun
    }
}
