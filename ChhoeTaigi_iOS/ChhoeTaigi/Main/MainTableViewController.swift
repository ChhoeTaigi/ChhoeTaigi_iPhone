
import UIKit

class MainTableViewController: UITableViewController {

    private let hideTableSection2 = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                performSegue(withIdentifier: "segueSearchAllWithLomajiSooji", sender: nil)
            } else if (indexPath.row == 1) {
                performSegue(withIdentifier: "segueSearchAllWithLomaji", sender: nil)
            } else if (indexPath.row == 2) {
                performSegue(withIdentifier: "segueSearchAllWithHanlo", sender: nil)
            } else if (indexPath.row == 3) {
                performSegue(withIdentifier: "segueSearchAllWithHoabun", sender: nil)
            } else if (indexPath.row == 4) {
                performSegue(withIdentifier: "segueSearchAllWithEngbun", sender: nil)
            }
        }
    }
    
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "segueSearchAllWithLomajiSooji") {
            let vc = segue.destination as! SearchAllViewController
            vc.searchAllType = SearchAllViewController.SEARCH_ALL_TYPE_LOMAJI_SOOJI
        } else if (segue.identifier == "segueSearchAllWithLomaji") {
            let vc = segue.destination as! SearchAllViewController
            vc.searchAllType = SearchAllViewController.SEARCH_ALL_TYPE_LOMAJI
        } else if (segue.identifier == "segueSearchAllWithHanlo") {
            let vc = segue.destination as! SearchAllViewController
            vc.searchAllType = SearchAllViewController.SEARCH_ALL_TYPE_HANLO
        } else if (segue.identifier ==  "segueSearchAllWithHoabun") {
            let vc = segue.destination as! SearchAllViewController
            vc.searchAllType = SearchAllViewController.SEARCH_ALL_TYPE_HOABUN
        } else if (segue.identifier ==  "segueSearchAllWithEngbun") {
            let vc = segue.destination as! SearchAllViewController
            vc.searchAllType = SearchAllViewController.SEARCH_ALL_TYPE_ENGBUN
        }
    }

}
