
import Foundation
import RealmSwift

class SearchAllResult {
    
    var dictId: Int
    var dictName: String
    var searching: Bool
    var results: Array<Object>?
    
    init(_ dictId :Int) {
        self.dictId = dictId
        
        switch self.dictId {
        case 1:
            self.dictName = "1. 台文華文線頂辭典"
        case 2:
            self.dictName = "2. 台日大辭典(台文譯本)"
        case 3:
            self.dictName = "3. Maryknoll台英辭典"
        case 4:
            self.dictName = "4. Embree台語辭典"
        case 5:
            self.dictName = "5. 教育部台語辭典"
        case 6:
            self.dictName = "6. 甘字典"
        case 7:
            self.dictName = "7. iTaigi華台辭典"
        case 8:
            self.dictName = "8. 台灣白話基礎語句"
        case 9:
            self.dictName = "9. 台灣植物名彙"
            
        default:
            self.dictName = ""
        }
        
        self.searching = false
    }
    
    func getCount()-> Int {
        if (results == nil) {
            return -1
        } else {
            return results!.count
        }
    }
}
