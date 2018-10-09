
import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.versionLabel.text = "版本: \(Bundle.main.releaseVersionNumberPretty)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickButtonDataSource(_ sender: Any) {
        performSegue(withIdentifier: "segueDataSource", sender: nil)
    }
    
    @IBAction func onClickButtonSiaukai(_ sender: Any) {
        performSegue(withIdentifier: "segueChhoeTaigiSiaukai", sender: nil)
    }
    
    @IBAction func onClickButtonWebsite(_ sender: Any) {
        performSegue(withIdentifier: "segueWebsite", sender: nil)
    }
    
    @IBAction func onClickButtonFacebook(_ sender: Any) {
        performSegue(withIdentifier: "segueFacebook", sender: nil)
    }
    
    @IBAction func onClickButtonPoweredByG0v(_ sender: Any) {
        performSegue(withIdentifier: "seguePoweredByG0v", sender: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "segueDataSource") {
            let vc = segue.destination as! WebkitViewController
            vc.linkAddress = "https://github.com/ChhoeTaigi/ChhoeTaigiDatabase/blob/master/README.md"
        } else if (segue.identifier == "segueChhoeTaigiSiaukai") {
            let vc = segue.destination as! WebkitViewController
           vc.linkAddress = "https://chhoe.taigi.info/liaukai"
        } else if (segue.identifier == "segueWebsite") {
            let vc = segue.destination as! WebkitViewController
           vc.linkAddress = "https://chhoe.taigi.info/"
        } else if (segue.identifier == "segueFacebook") {
            let vc = segue.destination as! WebkitViewController
            vc.linkAddress = "https://www.facebook.com/ChhoeTaigi/"
        } else if (segue.identifier == "seguePoweredByG0v") {
            let vc = segue.destination as! WebkitViewController
            vc.linkAddress = "https://grants.g0v.tw/power/"
        }
    }

}
