
import Foundation
import Realm
import RealmSwift

public class RealmDatabaseLoader {
//    private static var queue = DispatchQueue(label: "chhoe.taigi.info.app.realmdatabaseloader.queue")
    
    public static func getBundledRealm() -> Realm {
//        objc_sync_enter(self)
        
        let config = Realm.Configuration(
            // Get the URL to the bundled file
            fileURL: Bundle.main.url(forResource: "dict", withExtension: "realm"),
            // Open the file in read-only mode as application bundles are not writeable
            readOnly: true)
        
        // Open the Realm with the configuration
        let realm = try! Realm(configuration: config)
        
//        defer {
//            objc_sync_exit(self)
//        }
        
        return realm
    }
}
