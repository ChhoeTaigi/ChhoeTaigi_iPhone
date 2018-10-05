
import UIKit
import RxCocoa
import RxSwift
import RealmSwift

class TaihoaSoanntengSutianResultTableViewController: UITableViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    public var searchAllType = 0
    public var searchEquals = false
    public var keyword: String?
    
    private var results: Results<TaihoaSoanntengSutianModel>?
    private var currentSelectedModel: TaihoaSoanntengSutianModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        setup()
    }
    
    func setup() {
        self.titleLabel.text = "1. 台文華文線頂辭典: \(self.keyword ?? "")"
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        
        starSearch()
    }
    
    func starSearch() {
        if (searchAllType == SearchAllViewController.SEARCH_ALL_TYPE_LOMAJI) {
            var queryFormat: String
            if (self.searchEquals == false) {
                queryFormat = "poj_input CONTAINS %@ OR poj_unicode CONTAINS %@ OR kiplmj_input CONTAINS %@ OR kiplmj_unicode CONTAINS %@ OR poj_input_dialect CONTAINS %@ OR poj_unicode_dialect CONTAINS %@ OR kiplmj_input_dialect CONTAINS %@ OR kiplmj_unicode_dialect CONTAINS %@"
            } else {
                queryFormat = "poj_input = %@ OR poj_unicode = %@ OR kiplmj_input = %@ OR kiplmj_unicode = %@ OR poj_input_dialect = %@ OR poj_unicode_dialect = %@ OR kiplmj_input_dialect = %@ OR kiplmj_unicode_dialect = %@"
            }
            let queryKeyword = self.keyword!.lowercased()
            let predicate = NSPredicate(format: queryFormat, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword)
            self.results = RealmDatabaseLoader.getBundledRealm().objects(TaihoaSoanntengSutianModel.self).filter(predicate)
        } else if (searchAllType == SearchAllViewController.SEARCH_ALL_TYPE_HANLO) {
            var queryFormat: String
            if (self.searchEquals == false) {
                queryFormat = "hanlo_taibun_poj CONTAINS %@ OR hanlo_taibun_kiplmj CONTAINS %@"
            } else {
                queryFormat = "hanlo_taibun_poj = %@ OR hanlo_taibun_kiplmj = %@"
            }
            let queryKeyword = self.keyword!.lowercased()
            let predicate = NSPredicate(format: queryFormat, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword)
            self.results = RealmDatabaseLoader.getBundledRealm().objects(TaihoaSoanntengSutianModel.self).filter(predicate)
        } else if (searchAllType == SearchAllViewController.SEARCH_ALL_TYPE_HOABUN) {
            var queryFormat: String
            if (self.searchEquals == false) {
                queryFormat = "hoabun CONTAINS %@"
            } else {
                queryFormat = "hoabun = %@"
            }
            let queryKeyword = self.keyword!.lowercased()
            let predicate = NSPredicate(format: queryFormat, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword)
            self.results = RealmDatabaseLoader.getBundledRealm().objects(TaihoaSoanntengSutianModel.self).filter(predicate)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (results == nil) {
            return 0
        } else {
            return results!.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TaihoaSoanntengSutianResultTableViewCell
        
        if (results != nil) {
            cell.bindData(model: results![indexPath.row])
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentSelectedModel = results![indexPath.row]
        performSegue(withIdentifier: "segueWordView", sender: nil)
    }

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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueWordView") {
            let vc = segue.destination as! TaihoaSoanntengSutianWordTableViewController
            vc.modelData = self.currentSelectedModel
        }
    }

}
