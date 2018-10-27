
import UIKit

class CustomBackButtonTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let backBarButtonItem = UIBarButtonItem()
        backBarButtonItem.title = "Tńg--去"
        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backBarButtonItem
    }
    
}
