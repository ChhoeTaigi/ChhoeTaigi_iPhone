
import UIKit
import RxCocoa
import RxSwift
import Realm
import RealmSwift
import Segmentio

class SearchAllViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    public static let SEARCH_ALL_TYPE_LOMAJI_SOOJI = 1
    public static let SEARCH_ALL_TYPE_LOMAJI = 2
    public static let SEARCH_ALL_TYPE_HANLO = 3
    public static let SEARCH_ALL_TYPE_HOABUN = 4
    public static let SEARCH_ALL_TYPE_ENGBUN = 5
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentControlParentView: UIView!
    
    public var searchAllType = 0
    
    private let disposeBag = DisposeBag() // Bag of disposables to release them when view is being deallocated
    
    private var searchKeyword = ""
    private var searchAllResults = [SearchAllResult]()
    private var searchEquals: Bool = false
    
    private var isFirstLoadActiveKeyboard = true
    
    // searchAllWithLomajiSooji
    private var searchAllWithLomajiSoojiInTaibunHoabunSoanntengSutianPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithLomajiSoojiInTaijitToaSutianSutianPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithLomajiSoojiInMaryknollTaiengSutianPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithLomajiSoojiInEmbreeTaigiSutianPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithLomajiSoojiInKauiokpooTaigiSutianPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithLomajiSoojiInKamJitianPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithLomajiSoojiInITaigiTaihoaSutianPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithLomajiSoojiInTaioanPehoeKichhooGikuPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithLomajiSoojiInTaioanSitbutMialuiPublishSubject :PublishSubject = PublishSubject<String>()
    
    // searchAllWithLomaji
    private var searchAllWithLomajiInTaibunHoabunSoanntengSutianPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithLomajiInTaijitToaSutianSutianPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithLomajiInMaryknollTaiengSutianPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithLomajiInEmbreeTaigiSutianPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithLomajiInKauiokpooTaigiSutianPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithLomajiInKamJitianPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithLomajiInITaigiTaihoaSutianPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithLomajiInTaioanPehoeKichhooGikuPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithLomajiInTaioanSitbutMialuiPublishSubject :PublishSubject = PublishSubject<String>()
    
    // searchAllWithHanlo
    private var searchAllWithHanloInTaibunHoabunSoanntengSutianPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithHanloInTaijitToaSutianSutianPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithHanloInKauiokpooTaigiSutianPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithHanloInKamJitianPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithHanloInITaigiTaihoaSutianPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithHanloInTaioanSitbutMialuiPublishSubject :PublishSubject = PublishSubject<String>()
    
    // searchAllWithHoabun
    private var searchAllWithHoabunInTaibunHoabunSoanntengSutianPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithHoabunInMaryknollTaiengSutianPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithHoabunInEmbreeTaigiSutianPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithHoabunInKauiokpooTaigiSutianPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithHoabunInITaigiTaihoaSutianPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithHoabunInTaioanPehoeKichhooGikuPublishSubject :PublishSubject = PublishSubject<String>()
    
    // searchAllWithEngbun
    private var searchAllWithEngbunInMaryknollTaiengSutianPublishSubject :PublishSubject = PublishSubject<String>()
    private var searchAllWithEngbunInEmbreeTaigiSutianPublishSubject :PublishSubject = PublishSubject<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (isFirstLoadActiveKeyboard) {
            isFirstLoadActiveKeyboard = false
            DispatchQueue.main.async {
                self.searchBar.becomeFirstResponder()
            }
        }
    }
    
    private func setup() {
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        
        setupSearchBar()
        setupSegmentControl()
        
        searchAllResults.removeAll()
        
        for index in 1...9 {
            self.searchAllResults.append(SearchAllResult(index))
        }
        
        if (searchAllType == SearchAllViewController.SEARCH_ALL_TYPE_LOMAJI_SOOJI) {
            self.searchBar.placeholder = "請phah【LMJ台文(數字輸入)】"
            setupSearchAllWithLomajiPublishSubjects(isLomajiSoojiInputMode: true)
        } else if (searchAllType == SearchAllViewController.SEARCH_ALL_TYPE_LOMAJI) {
            self.searchBar.placeholder = "請phah【LMJ台文】"
            setupSearchAllWithLomajiPublishSubjects(isLomajiSoojiInputMode: false)
        } else if (searchAllType == SearchAllViewController.SEARCH_ALL_TYPE_HANLO) {
            self.searchBar.placeholder = "請phah【漢字/漢羅台文】"
            setupSearchAllWithHanloPublishSubjects()
        } else if (searchAllType == SearchAllViewController.SEARCH_ALL_TYPE_HOABUN) {
            self.searchBar.placeholder = "請phah【對應ê華文】"
            setupSearchAllWithHoabunPublishSubjects()
        } else if (searchAllType == SearchAllViewController.SEARCH_ALL_TYPE_ENGBUN) {
            self.searchBar.placeholder = "請phah【對應ê英文】"
            setupSearchAllWithEngbunPublishSubjects()
        }
    }
    
    private func setupSearchBar() {
        if let textfield = self.searchBar.value(forKey: "searchField") as? UITextField {
            let searchBarTextAttributes = [NSAttributedString.Key.font.rawValue: UIFont.systemFont(ofSize: 20)]
            textfield.defaultTextAttributes = convertToNSAttributedStringKeyDictionary(searchBarTextAttributes)
            textfield.layer.cornerRadius = 1.0
            textfield.layer.masksToBounds = true
            textfield.clipsToBounds = true
            textfield.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            
            if let label = textfield.value(forKey: "_placeholderLabel") as? UILabel {
                label.minimumScaleFactor = 0.8
                label.adjustsFontSizeToFitWidth = true
            }
        }
    }
    
    private func setupSegmentControl() {
        var segmentioView: Segmentio!
        
        let segmentioViewRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
        segmentioView = Segmentio(frame: segmentioViewRect)
        
        var content = [SegmentioItem]()
        
        let item1 = SegmentioItem(
            title: "相關--ê",
            image: nil
        )
        let item2 = SegmentioItem(
            title: "Sio-kâng--ê",
            image: nil
        )
        content.append(item1)
        content.append(item2)
        
        let segmentioIndicatorOptions = SegmentioIndicatorOptions(
            type: .bottom,
            ratio: 1,
            height: 5,
            color: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        )
        
        let segmentioStates = SegmentioStates(
            defaultState: SegmentioState(
                backgroundColor: .clear,
                titleFont: UIFont.systemFont(ofSize: 22),
                titleTextColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            ),
            selectedState: SegmentioState(
                backgroundColor: .clear,
                titleFont: UIFont.systemFont(ofSize: 22),
                titleTextColor: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            ),
            highlightedState: SegmentioState(
                backgroundColor: .clear,
                titleFont: UIFont.systemFont(ofSize: 22),
                titleTextColor: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            )
        )
        
        let segmentioOptions = SegmentioOptions(
            backgroundColor: .clear,
            segmentPosition: SegmentioPosition.fixed(maxVisibleItems: 2),
            scrollEnabled: false,
            indicatorOptions: segmentioIndicatorOptions,
            horizontalSeparatorOptions: nil,
            verticalSeparatorOptions: nil,
            imageContentMode: .center,
            labelTextAlignment: .center,
            segmentStates: segmentioStates
        )
        
        segmentioView.setup(
            content: content,
            style: SegmentioStyle.onlyLabel,
            options: segmentioOptions
        )
        
        segmentioView.valueDidChange = { segmentio, segmentIndex in
            print("Selected item: ", segmentIndex)
            
            self.switchSearchCondition(condition: segmentIndex)
        }
        
        segmentioView.selectedSegmentioIndex = 0
        
        self.segmentControlParentView.addSubview(segmentioView)
    }
    
    private func switchSearchCondition(condition: Int) {
        if condition == 0 {
            self.searchEquals = false
        } else {
            self.searchEquals = true
        }
        
        searchAll(self.searchBar.text!)
    }
    
    private func setupSearchAllWithLomajiPublishSubjects(isLomajiSoojiInputMode: Bool) {
        // 1. Taihoa Soannteng Sutian
        searchAllWithLomajiInTaibunHoabunSoanntengSutianPublishSubject
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .subscribeOn(MainScheduler.instance)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                    let searchAllResult = self.searchAllResults[0]
                    
                    if (query.isEmpty) {
                        searchAllResult.searching = false
                    } else {
                        var queryFormat: String
                        if (self.searchEquals == false) {
                            if (isLomajiSoojiInputMode) {
                                queryFormat = "poj_input CONTAINS[c] %@ OR kiplmj_input CONTAINS[c] %@ OR poj_input_dialect CONTAINS[c] %@ OR kiplmj_input_dialect CONTAINS[c] %@"
                            } else {
                                queryFormat = "poj_unicode CONTAINS[c] %@ OR kiplmj_unicode CONTAINS[c] %@ OR poj_unicode_dialect CONTAINS[c] %@ OR kiplmj_unicode_dialect CONTAINS[c] %@"
                            }
                        } else {
                            if (isLomajiSoojiInputMode) {
                                queryFormat = "poj_input =[c] %@ OR kiplmj_input =[c] %@ OR poj_input_dialect =[c] %@ OR kiplmj_input_dialect =[c] %@"
                            } else {
                                queryFormat = "poj_unicode =[c] %@ OR kiplmj_unicode =[c] %@ OR poj_unicode_dialect =[c] %@ OR kiplmj_unicode_dialect =[c] %@"
                            }
                        }
                        let queryKeyword = query.lowercased()
                        let predicate = NSPredicate(format: queryFormat, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword)
                        let results = RealmDatabaseLoader.getBundledRealm().objects(TaihoaSoanntengSutianModel.self).filter(predicate)
                        
                        searchAllResult.searching = false
                        searchAllResult.results = results.toArray(type: Object.self)
                    }
                }
            )
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(
                onNext: { query in
                    self.tableView.reloadData()
            }
            )
            .disposed(by: disposeBag)
        
        // 2. Taijit Toa Sutian
        searchAllWithLomajiInTaijitToaSutianSutianPublishSubject
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .subscribeOn(MainScheduler.instance)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                    let searchAllResult = self.searchAllResults[1]
                    
                    if (query.isEmpty) {
                        searchAllResult.searching = false
                    } else {
                        var queryFormat: String
                        if (self.searchEquals == false) {
                            if (isLomajiSoojiInputMode) {
                                queryFormat = "poj_input CONTAINS[c] %@ OR kiplmj_input CONTAINS[c] %@ OR poj_input_dialect CONTAINS[c] %@ OR kiplmj_input_dialect CONTAINS[c] %@"
                            } else {
                                queryFormat = "poj_unicode CONTAINS[c] %@ OR kiplmj_unicode CONTAINS[c] %@ OR poj_unicode_dialect CONTAINS[c] %@ OR kiplmj_unicode_dialect CONTAINS[c] %@"
                            }
                        } else {
                            if (isLomajiSoojiInputMode) {
                                queryFormat = "poj_input =[c] %@ OR kiplmj_input =[c] %@ OR poj_input_dialect =[c] %@ OR kiplmj_input_dialect =[c] %@"
                            } else {
                                queryFormat = "poj_unicode =[c] %@ OR kiplmj_unicode =[c] %@ OR poj_unicode_dialect =[c] %@ OR kiplmj_unicode_dialect =[c] %@"
                            }
                        }
                        let queryKeyword = query.lowercased()
                        let predicate = NSPredicate(format: queryFormat, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword)
                        let results = RealmDatabaseLoader.getBundledRealm().objects(TaijitToaSutianModel.self).filter(predicate)
                        
                        searchAllResult.searching = false
                        searchAllResult.results = results.toArray(type: Object.self)
                    }
                }
            )
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(
                onNext: { query in
                    self.tableView.reloadData()
            }
            )
            .disposed(by: disposeBag)
        
        // 3. Maryknoll TaiEng Sutian
        searchAllWithLomajiInMaryknollTaiengSutianPublishSubject
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .subscribeOn(MainScheduler.instance)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                    let searchAllResult = self.searchAllResults[2]
                    
                    if (query.isEmpty) {
                        searchAllResult.searching = false
                    } else {
                        var queryFormat: String
                        if (self.searchEquals == false) {
                            if (isLomajiSoojiInputMode) {
                                queryFormat = "poj_input CONTAINS[c] %@ OR kiplmj_input CONTAINS[c] %@"
                            } else {
                                queryFormat = "poj_unicode CONTAINS[c] %@ OR kiplmj_unicode CONTAINS[c] %@"
                            }
                        } else {
                            if (isLomajiSoojiInputMode) {
                                queryFormat = "poj_input =[c] %@ OR kiplmj_input =[c] %@"
                            } else {
                                queryFormat = "poj_unicode =[c] %@ OR kiplmj_unicode =[c] %@"
                            }
                        }
                        let queryKeyword = query.lowercased()
                        let predicate = NSPredicate(format: queryFormat, queryKeyword, queryKeyword, queryKeyword, queryKeyword)
                        let results = RealmDatabaseLoader.getBundledRealm().objects(MaryknollTaiengSutianModel.self).filter(predicate)
                        
                        searchAllResult.searching = false
                        searchAllResult.results = results.toArray(type: Object.self)
                    }
                }
            )
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(
                onNext: { query in
                    self.tableView.reloadData()
            }
            )
            .disposed(by: disposeBag)
        
        // 4. Embree Taigi Sutian
        searchAllWithLomajiInEmbreeTaigiSutianPublishSubject
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .subscribeOn(MainScheduler.instance)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                    let searchAllResult = self.searchAllResults[3]
                    
                    if (query.isEmpty) {
                        searchAllResult.searching = false
                    } else {
                        var queryFormat: String
                        if (self.searchEquals == false) {
                            if (isLomajiSoojiInputMode) {
                                queryFormat = "poj_input CONTAINS[c] %@ OR kiplmj_input CONTAINS[c] %@"
                            } else {
                                queryFormat = "poj_unicode CONTAINS[c] %@ OR kiplmj_unicode CONTAINS[c] %@"
                            }
                        } else {
                            if (isLomajiSoojiInputMode) {
                                queryFormat = "poj_input =[c] %@ OR kiplmj_input =[c] %@"
                            } else {
                                queryFormat = "poj_unicode =[c] %@ OR kiplmj_unicode =[c] %@"
                            }
                        }
                        let queryKeyword = query.lowercased()
                        let predicate = NSPredicate(format: queryFormat, queryKeyword, queryKeyword, queryKeyword, queryKeyword)
                        let results = RealmDatabaseLoader.getBundledRealm().objects(EmbreeTaigiSutianModel.self).filter(predicate)
                        
                        searchAllResult.searching = false
                        searchAllResult.results = results.toArray(type: Object.self)
                    }
                }
            )
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(
                onNext: { query in
                    self.tableView.reloadData()
            }
            )
            .disposed(by: disposeBag)
        
        // 5. Kauiokpoo Taigi Sutian
        searchAllWithLomajiInKauiokpooTaigiSutianPublishSubject
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .subscribeOn(MainScheduler.instance)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                    let searchAllResult = self.searchAllResults[4]
                    
                    if (query.isEmpty) {
                        searchAllResult.searching = false
                    } else {
                        var queryFormat: String
                        if (self.searchEquals == false) {
                            if (isLomajiSoojiInputMode) {
                                queryFormat = "poj_input CONTAINS[c] %@ OR kiplmj_input CONTAINS[c] %@ OR poj_input_dialect CONTAINS[c] %@ OR kiplmj_input_dialect CONTAINS[c] %@"
                            } else {
                                queryFormat = "poj_unicode CONTAINS[c] %@ OR kiplmj_unicode CONTAINS[c] %@ OR poj_unicode_dialect CONTAINS[c] %@ OR kiplmj_unicode_dialect CONTAINS[c] %@"
                            }
                        } else {
                            if (isLomajiSoojiInputMode) {
                                queryFormat = "poj_input =[c] %@ OR kiplmj_input =[c] %@ OR poj_input_dialect =[c] %@ OR kiplmj_input_dialect =[c] %@"
                            } else {
                                queryFormat = "poj_unicode =[c] %@ OR kiplmj_unicode =[c] %@ OR poj_unicode_dialect =[c] %@ OR kiplmj_unicode_dialect =[c] %@"
                            }
                        }
                        let queryKeyword = query.lowercased()
                        let predicate = NSPredicate(format: queryFormat, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword)
                        let results = RealmDatabaseLoader.getBundledRealm().objects(KauiokpooTaigiSutianModel.self).filter(predicate)
                        
                        searchAllResult.searching = false
                        searchAllResult.results = results.toArray(type: Object.self)
                    }
                }
            )
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(
                onNext: { query in
                    self.tableView.reloadData()
            }
            )
            .disposed(by: disposeBag)
        
        // 6. Kam Jitian
        searchAllWithLomajiInKamJitianPublishSubject
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .subscribeOn(MainScheduler.instance)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                    let searchAllResult = self.searchAllResults[5]
                    
                    if (query.isEmpty) {
                        searchAllResult.searching = false
                    } else {
                        var queryFormat: String
                        if (self.searchEquals == false) {
                            if (isLomajiSoojiInputMode) {
                                queryFormat = "poj_input CONTAINS[c] %@ OR kiplmj_input CONTAINS[c] %@"
                            } else {
                                queryFormat = "poj_unicode CONTAINS[c] %@ OR kiplmj_unicode CONTAINS[c] %@"
                            }
                        } else {
                            if (isLomajiSoojiInputMode) {
                                queryFormat = "poj_input =[c] %@ OR kiplmj_input =[c] %@"
                            } else {
                                queryFormat = "poj_unicode =[c] %@ OR kiplmj_unicode =[c] %@"
                            }
                        }
                        let queryKeyword = query.lowercased()
                        let predicate = NSPredicate(format: queryFormat, queryKeyword, queryKeyword, queryKeyword, queryKeyword)
                        let results = RealmDatabaseLoader.getBundledRealm().objects(KamJitianModel.self).filter(predicate)
                        
                        searchAllResult.searching = false
                        searchAllResult.results = results.toArray(type: Object.self)
                    }
                }
            )
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(
                onNext: { query in
                    self.tableView.reloadData()
            }
            )
            .disposed(by: disposeBag)
        
        // 7. iTaigi HoaTai Sutian
        searchAllWithLomajiInITaigiTaihoaSutianPublishSubject
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .subscribeOn(MainScheduler.instance)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                    let searchAllResult = self.searchAllResults[6]
                    
                    if (query.isEmpty) {
                        searchAllResult.searching = false
                    } else {
                        var queryFormat: String
                        if (self.searchEquals == false) {
                            if (isLomajiSoojiInputMode) {
                                queryFormat = "poj_input CONTAINS[c] %@ OR kiplmj_input CONTAINS[c] %@"
                            } else {
                                queryFormat = "poj_unicode CONTAINS[c] %@ OR kiplmj_unicode CONTAINS[c] %@"
                            }
                        } else {
                            if (isLomajiSoojiInputMode) {
                                queryFormat = "poj_input =[c] %@ OR kiplmj_input =[c] %@"
                            } else {
                                queryFormat = "poj_unicode =[c] %@ OR kiplmj_unicode =[c] %@"
                            }
                        }
                        let queryKeyword = query.lowercased()
                        let predicate = NSPredicate(format: queryFormat, queryKeyword, queryKeyword, queryKeyword, queryKeyword)
                        let results = RealmDatabaseLoader.getBundledRealm().objects(ITaigiHoataiSutianModel.self).filter(predicate)
                        
                        searchAllResult.searching = false
                        searchAllResult.results = results.toArray(type: Object.self)
                    }
                }
            )
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(
                onNext: { query in
                    self.tableView.reloadData()
            }
            )
            .disposed(by: disposeBag)
        
        // 8. Taioan Pehoe Kichhoo Giku
        searchAllWithLomajiInTaioanPehoeKichhooGikuPublishSubject
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .subscribeOn(MainScheduler.instance)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                    let searchAllResult = self.searchAllResults[7]
                    
                    if (query.isEmpty) {
                        searchAllResult.searching = false
                    } else {
                        var queryFormat: String
                        if (self.searchEquals == false) {
                            if (isLomajiSoojiInputMode) {
                                queryFormat = "poj_input CONTAINS[c] %@ OR kiplmj_input CONTAINS[c] %@ OR poj_input_dialect CONTAINS[c] %@ OR kiplmj_input_dialect CONTAINS[c] %@"
                            } else {
                                queryFormat = "poj_unicode CONTAINS[c] %@ OR kiplmj_unicode CONTAINS[c] %@ OR poj_unicode_dialect CONTAINS[c] %@ OR kiplmj_unicode_dialect CONTAINS[c] %@"
                            }
                        } else {
                            if (isLomajiSoojiInputMode) {
                                queryFormat = "poj_input =[c] %@ OR kiplmj_input =[c] %@ OR poj_input_dialect =[c] %@ OR kiplmj_input_dialect =[c] %@"
                            } else {
                                queryFormat = "poj_unicode =[c] %@ OR kiplmj_unicode =[c] %@ OR poj_unicode_dialect =[c] %@ OR kiplmj_unicode_dialect =[c] %@"
                            }
                        }
                        let queryKeyword = query.lowercased()
                        let predicate = NSPredicate(format: queryFormat, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword)
                        let results = RealmDatabaseLoader.getBundledRealm().objects(TaioanPehoeKichhooGikuModel.self).filter(predicate)
                        
                        searchAllResult.searching = false
                        searchAllResult.results = results.toArray(type: Object.self)
                    }
                }
            )
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(
                onNext: { query in
                    self.tableView.reloadData()
            }
            )
            .disposed(by: disposeBag)
        
        // 9. Taioan Sitbut Mialui
        searchAllWithLomajiInTaioanSitbutMialuiPublishSubject
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .subscribeOn(MainScheduler.instance)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                    let searchAllResult = self.searchAllResults[8]
                    
                    if (query.isEmpty) {
                        searchAllResult.searching = false
                    } else {
                        var queryFormat: String
                        if (self.searchEquals == false) {
                            if (isLomajiSoojiInputMode) {
                                queryFormat = "poj_input CONTAINS[c] %@ OR kiplmj_input CONTAINS[c] %@"
                            } else {
                                queryFormat = "poj_unicode CONTAINS[c] %@ OR kiplmj_unicode CONTAINS[c] %@"
                            }
                        } else {
                            if (isLomajiSoojiInputMode) {
                                queryFormat = "poj_input =[c] %@ OR kiplmj_input =[c] %@"
                            } else {
                                queryFormat = "poj_unicode =[c] %@ OR kiplmj_unicode =[c] %@"
                            }
                        }
                        let queryKeyword = query.lowercased()
                        let predicate = NSPredicate(format: queryFormat, queryKeyword, queryKeyword, queryKeyword, queryKeyword)
                        let results = RealmDatabaseLoader.getBundledRealm().objects(TaioanSitbutMialuiModel.self).filter(predicate)
                        
                        searchAllResult.searching = false
                        searchAllResult.results = results.toArray(type: Object.self)
                    }
                }
            )
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(
                onNext: { query in
                    self.tableView.reloadData()
            }
            )
            .disposed(by: disposeBag)
    }
    
    private func setupSearchAllWithHanloPublishSubjects() {
        // 1. Taihoa Soannteng Sutian
        searchAllWithHanloInTaibunHoabunSoanntengSutianPublishSubject
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .subscribeOn(MainScheduler.instance)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                    let searchAllResult = self.searchAllResults[0]
                    
                    if (query.isEmpty) {
                        searchAllResult.searching = false
                    } else {
                        var queryFormat: String
                        if (self.searchEquals == false) {
                            queryFormat = "hanlo_taibun_poj CONTAINS[c] %@ OR hanlo_taibun_kiplmj CONTAINS[c] %@"
                        } else {
                            queryFormat = "hanlo_taibun_poj =[c] %@ OR hanlo_taibun_kiplmj =[c] %@"
                        }
                        let queryKeyword = query.lowercased()
                        let predicate = NSPredicate(format: queryFormat, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword)
                        let results = RealmDatabaseLoader.getBundledRealm().objects(TaihoaSoanntengSutianModel.self).filter(predicate)
                        
                        searchAllResult.searching = false
                        searchAllResult.results = results.toArray(type: Object.self)
                    }
                }
            )
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(
                onNext: { query in
                    self.tableView.reloadData()
            }
            )
            .disposed(by: disposeBag)
        
        // 2. Taijit Toa Sutian
        searchAllWithHanloInTaijitToaSutianSutianPublishSubject
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .subscribeOn(MainScheduler.instance)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                    let searchAllResult = self.searchAllResults[1]
                    
                    if (query.isEmpty) {
                        searchAllResult.searching = false
                    } else {
                        var queryFormat: String
                        if (self.searchEquals == false) {
                            queryFormat = "hanlo_taibun_poj CONTAINS[c] %@ OR hanlo_taibun_kiplmj CONTAINS[c] %@"
                        } else {
                            queryFormat = "hanlo_taibun_poj =[c] %@ OR hanlo_taibun_kiplmj =[c] %@"
                        }
                        let queryKeyword = query.lowercased()
                        let predicate = NSPredicate(format: queryFormat, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword)
                        let results = RealmDatabaseLoader.getBundledRealm().objects(TaijitToaSutianModel.self).filter(predicate)
                        
                        searchAllResult.searching = false
                        searchAllResult.results = results.toArray(type: Object.self)
                    }
                }
            )
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(
                onNext: { query in
                    self.tableView.reloadData()
            }
            )
            .disposed(by: disposeBag)
        
        // 3. Maryknoll TaiEng Sutian: N/A
        // 4. Embree Taigi Sutian: N/A
        
        // 5. Kauiokpoo Taigi Sutian
        searchAllWithHanloInKauiokpooTaigiSutianPublishSubject
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .subscribeOn(MainScheduler.instance)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                    let searchAllResult = self.searchAllResults[4]
                    
                    if (query.isEmpty) {
                        searchAllResult.searching = false
                    } else {
                        var queryFormat: String
                        if (self.searchEquals == false) {
                            queryFormat = "hanji_taibun CONTAINS[c] %@"
                        } else {
                            queryFormat = "hanji_taibun =[c] %@"
                        }
                        let queryKeyword = query.lowercased()
                        let predicate = NSPredicate(format: queryFormat, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword)
                        let results = RealmDatabaseLoader.getBundledRealm().objects(KauiokpooTaigiSutianModel.self).filter(predicate)
                        
                        searchAllResult.searching = false
                        searchAllResult.results = results.toArray(type: Object.self)
                    }
                }
            )
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(
                onNext: { query in
                    self.tableView.reloadData()
            }
            )
            .disposed(by: disposeBag)
        
        // 6. Kam Jitian
        searchAllWithHanloInKamJitianPublishSubject
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .subscribeOn(MainScheduler.instance)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                    let searchAllResult = self.searchAllResults[5]
                    
                    if (query.isEmpty) {
                        searchAllResult.searching = false
                    } else {
                        var queryFormat: String
                        if (self.searchEquals == false) {
                            queryFormat = "hanlo_taibun_poj CONTAINS[c] %@ OR hanlo_taibun_kiplmj CONTAINS[c] %@"
                        } else {
                            queryFormat = "hanlo_taibun_poj =[c] %@ OR kiplmj_unicode =[c] %@"
                        }
                        let queryKeyword = query.lowercased()
                        let predicate = NSPredicate(format: queryFormat, queryKeyword, queryKeyword, queryKeyword, queryKeyword)
                        let results = RealmDatabaseLoader.getBundledRealm().objects(KamJitianModel.self).filter(predicate)
                        
                        searchAllResult.searching = false
                        searchAllResult.results = results.toArray(type: Object.self)
                    }
                }
            )
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(
                onNext: { query in
                    self.tableView.reloadData()
            }
            )
            .disposed(by: disposeBag)
        
        // 7. iTaigi HoaTai Sutian
        searchAllWithHanloInITaigiTaihoaSutianPublishSubject
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .subscribeOn(MainScheduler.instance)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                    let searchAllResult = self.searchAllResults[6]
                    
                    if (query.isEmpty) {
                        searchAllResult.searching = false
                    } else {
                        var queryFormat: String
                        if (self.searchEquals == false) {
                            queryFormat = "hanlo_taibun_kiplmj CONTAINS[c] %@"
                        } else {
                            queryFormat = "hanlo_taibun_kiplmj =[c] %@"
                        }
                        let queryKeyword = query.lowercased()
                        let predicate = NSPredicate(format: queryFormat, queryKeyword, queryKeyword, queryKeyword, queryKeyword)
                        let results = RealmDatabaseLoader.getBundledRealm().objects(ITaigiHoataiSutianModel.self).filter(predicate)
                        
                        searchAllResult.searching = false
                        searchAllResult.results = results.toArray(type: Object.self)
                    }
                }
            )
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(
                onNext: { query in
                    self.tableView.reloadData()
            }
            )
            .disposed(by: disposeBag)
        
        // 8. Taioan Pehoe Kichhoo Giku: N/A
        
        // 9. Taioan Sitbut Mialui
        searchAllWithHanloInTaioanSitbutMialuiPublishSubject
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .subscribeOn(MainScheduler.instance)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                    let searchAllResult = self.searchAllResults[8]
                    
                    if (query.isEmpty) {
                        searchAllResult.searching = false
                    } else {
                        var queryFormat: String
                        if (self.searchEquals == false) {
                            queryFormat = "hanji_taibun CONTAINS[c] %@"
                        } else {
                            queryFormat = "hanji_taibun =[c] %@"
                        }
                        let queryKeyword = query.lowercased()
                        let predicate = NSPredicate(format: queryFormat, queryKeyword, queryKeyword, queryKeyword, queryKeyword)
                        let results = RealmDatabaseLoader.getBundledRealm().objects(TaioanSitbutMialuiModel.self).filter(predicate)
                        
                        searchAllResult.searching = false
                        searchAllResult.results = results.toArray(type: Object.self)
                    }
                }
            )
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(
                onNext: { query in
                    self.tableView.reloadData()
            }
            )
            .disposed(by: disposeBag)
    }
    
    private func setupSearchAllWithHoabunPublishSubjects() {
        // 1. Taihoa Soannteng Sutian
        searchAllWithHoabunInTaibunHoabunSoanntengSutianPublishSubject
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .subscribeOn(MainScheduler.instance)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                    let searchAllResult = self.searchAllResults[0]
                    
                    if (query.isEmpty) {
                        searchAllResult.searching = false
                    } else {
                        var queryFormat: String
                        if (self.searchEquals == false) {
                            queryFormat = "hoabun CONTAINS[c] %@"
                        } else {
                            queryFormat = "hoabun =[c] %@"
                        }
                        let queryKeyword = query.lowercased()
                        let predicate = NSPredicate(format: queryFormat, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword)
                        let results = RealmDatabaseLoader.getBundledRealm().objects(TaihoaSoanntengSutianModel.self).filter(predicate)
                        
                        searchAllResult.searching = false
                        searchAllResult.results = results.toArray(type: Object.self)
                    }
                }
            )
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(
                onNext: { query in
                    self.tableView.reloadData()
            }
            )
            .disposed(by: disposeBag)
        
        // 2. Taijit Toa Sutian: N/A
        
        // 3. Maryknoll TaiEng Sutian
        searchAllWithHoabunInMaryknollTaiengSutianPublishSubject
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .subscribeOn(MainScheduler.instance)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                    let searchAllResult = self.searchAllResults[2]
                    
                    if (query.isEmpty) {
                        searchAllResult.searching = false
                    } else {
                        var queryFormat: String
                        if (self.searchEquals == false) {
                            queryFormat = "hoabun CONTAINS[c] %@"
                        } else {
                            queryFormat = "hoabun =[c] %@"
                        }
                        let queryKeyword = query.lowercased()
                        let predicate = NSPredicate(format: queryFormat, queryKeyword, queryKeyword, queryKeyword, queryKeyword)
                        let results = RealmDatabaseLoader.getBundledRealm().objects(MaryknollTaiengSutianModel.self).filter(predicate)
                        
                        searchAllResult.searching = false
                        searchAllResult.results = results.toArray(type: Object.self)
                    }
                }
            )
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(
                onNext: { query in
                    self.tableView.reloadData()
            }
            )
            .disposed(by: disposeBag)
        
        // 4. Embree Taigi Sutian
        searchAllWithHoabunInEmbreeTaigiSutianPublishSubject
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .subscribeOn(MainScheduler.instance)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                    let searchAllResult = self.searchAllResults[3]
                    
                    if (query.isEmpty) {
                        searchAllResult.searching = false
                    } else {
                        var queryFormat: String
                        if (self.searchEquals == false) {
                            queryFormat = "hoabun CONTAINS[c] %@"
                        } else {
                            queryFormat = "hoabun =[c] %@"
                        }
                        let queryKeyword = query.lowercased()
                        let predicate = NSPredicate(format: queryFormat, queryKeyword, queryKeyword, queryKeyword, queryKeyword)
                        let results = RealmDatabaseLoader.getBundledRealm().objects(EmbreeTaigiSutianModel.self).filter(predicate)
                        
                        searchAllResult.searching = false
                        searchAllResult.results = results.toArray(type: Object.self)
                    }
                }
            )
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(
                onNext: { query in
                    self.tableView.reloadData()
            }
            )
            .disposed(by: disposeBag)
        
        // 5. Kauiokpoo Taigi Sutian
        searchAllWithHoabunInKauiokpooTaigiSutianPublishSubject
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .subscribeOn(MainScheduler.instance)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                    let searchAllResult = self.searchAllResults[4]
                    
                    if (query.isEmpty) {
                        searchAllResult.searching = false
                    } else {
                        var queryFormat: String
                        if (self.searchEquals == false) {
                            queryFormat = "hoabun CONTAINS[c] %@"
                        } else {
                            queryFormat = "hoabun =[c] %@"
                        }
                        let queryKeyword = query.lowercased()
                        let predicate = NSPredicate(format: queryFormat, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword)
                        let results = RealmDatabaseLoader.getBundledRealm().objects(KauiokpooTaigiSutianModel.self).filter(predicate)
                        
                        searchAllResult.searching = false
                        searchAllResult.results = results.toArray(type: Object.self)
                    }
                }
            )
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(
                onNext: { query in
                    self.tableView.reloadData()
            }
            )
            .disposed(by: disposeBag)
        
        // 6. Kam Jitian: N/A
        
        // 7. iTaigi HoaTai Sutian
        searchAllWithHoabunInITaigiTaihoaSutianPublishSubject
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .subscribeOn(MainScheduler.instance)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                    let searchAllResult = self.searchAllResults[6]
                    
                    if (query.isEmpty) {
                        searchAllResult.searching = false
                    } else {
                        var queryFormat: String
                        if (self.searchEquals == false) {
                            queryFormat = "hoabun CONTAINS[c] %@"
                        } else {
                            queryFormat = "hoabun =[c] %@"
                        }
                        let queryKeyword = query.lowercased()
                        let predicate = NSPredicate(format: queryFormat, queryKeyword, queryKeyword, queryKeyword, queryKeyword)
                        let results = RealmDatabaseLoader.getBundledRealm().objects(ITaigiHoataiSutianModel.self).filter(predicate)
                        
                        searchAllResult.searching = false
                        searchAllResult.results = results.toArray(type: Object.self)
                    }
                }
            )
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(
                onNext: { query in
                    self.tableView.reloadData()
            }
            )
            .disposed(by: disposeBag)
        
        // 8. Taioan Pehoe Kichhoo Giku
        searchAllWithHoabunInTaioanPehoeKichhooGikuPublishSubject
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .subscribeOn(MainScheduler.instance)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                    let searchAllResult = self.searchAllResults[7]
                    
                    if (query.isEmpty) {
                        searchAllResult.searching = false
                    } else {
                        var queryFormat: String
                        if (self.searchEquals == false) {
                            queryFormat = "hoabun CONTAINS[c] %@"
                        } else {
                            queryFormat = "hoabun =[c] %@"
                        }
                        let queryKeyword = query.lowercased()
                        let predicate = NSPredicate(format: queryFormat, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword, queryKeyword)
                        let results = RealmDatabaseLoader.getBundledRealm().objects(TaioanPehoeKichhooGikuModel.self).filter(predicate)
                        
                        searchAllResult.searching = false
                        searchAllResult.results = results.toArray(type: Object.self)
                    }
                }
            )
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(
                onNext: { query in
                    self.tableView.reloadData()
            }
            )
            .disposed(by: disposeBag)
        
        // 9. Taioan Sitbut Mialui: N/A
    }
    
    private func setupSearchAllWithEngbunPublishSubjects() {
        // 1. Taihoa Soannteng Sutian: N/A
        // 2. Taijit Toa Sutian: N/A
        
        // 3. Maryknoll TaiEng Sutian
        searchAllWithEngbunInMaryknollTaiengSutianPublishSubject
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .subscribeOn(MainScheduler.instance)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                    let searchAllResult = self.searchAllResults[2]
                    
                    if (query.isEmpty) {
                        searchAllResult.searching = false
                    } else {
                        var queryFormat: String
                        if (self.searchEquals == false) {
                            queryFormat = "english_descriptions CONTAINS[c] %@"
                        } else {
                            queryFormat = "english_descriptions =[c] %@"
                        }
                        let queryKeyword = query.lowercased()
                        let predicate = NSPredicate(format: queryFormat, queryKeyword, queryKeyword, queryKeyword, queryKeyword)
                        let results = RealmDatabaseLoader.getBundledRealm().objects(MaryknollTaiengSutianModel.self).filter(predicate)
                        
                        searchAllResult.searching = false
                        searchAllResult.results = results.toArray(type: Object.self)
                    }
                }
            )
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(
                onNext: { query in
                    self.tableView.reloadData()
            }
            )
            .disposed(by: disposeBag)
        
        // 4. Embree Taigi Sutian
        searchAllWithEngbunInEmbreeTaigiSutianPublishSubject
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .subscribeOn(MainScheduler.instance)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .do(
                onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                    let searchAllResult = self.searchAllResults[3]
                    
                    if (query.isEmpty) {
                        searchAllResult.searching = false
                    } else {
                        var queryFormat: String
                        if (self.searchEquals == false) {
                            queryFormat = "english_descriptions CONTAINS[c] %@"
                        } else {
                            queryFormat = "english_descriptions =[c] %@"
                        }
                        let queryKeyword = query.lowercased()
                        let predicate = NSPredicate(format: queryFormat, queryKeyword, queryKeyword, queryKeyword, queryKeyword)
                        let results = RealmDatabaseLoader.getBundledRealm().objects(EmbreeTaigiSutianModel.self).filter(predicate)
                        
                        searchAllResult.searching = false
                        searchAllResult.results = results.toArray(type: Object.self)
                    }
                }
            )
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive(
                onNext: { query in
                    self.tableView.reloadData()
            }
            )
            .disposed(by: disposeBag)
        
        // 5. Kauiokpoo Taigi Sutian: N/A
        // 6. Kam Jitian: N/A
        // 7. iTaigi HoaTai Sutian: N/A
        // 8. Taioan Pehoe Kichhoo Giku: N/A
        // 9. Taioan Sitbut Mialui: N/A
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchAllResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! SearchAllTableViewCell
        
        if (searchAllType == SearchAllViewController.SEARCH_ALL_TYPE_LOMAJI_SOOJI || searchAllType == SearchAllViewController.SEARCH_ALL_TYPE_LOMAJI) {
            setCellSearching(cell: cell, cellForRowAt: indexPath)
        } else if (searchAllType == SearchAllViewController.SEARCH_ALL_TYPE_HANLO) {
            if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 7) {
                setCellNotAvailable(cell: cell, cellForRowAt: indexPath)
            } else {
                setCellSearching(cell: cell, cellForRowAt: indexPath)
            }
        } else if (searchAllType == SearchAllViewController.SEARCH_ALL_TYPE_HOABUN) {
            if (indexPath.row == 1 || indexPath.row == 5 || indexPath.row == 8) {
                setCellNotAvailable(cell: cell, cellForRowAt: indexPath)
            } else {
                setCellSearching(cell: cell, cellForRowAt: indexPath)
            }
        } else if (searchAllType == SearchAllViewController.SEARCH_ALL_TYPE_ENGBUN) {
            if (indexPath.row == 2 || indexPath.row == 3) {
                setCellSearching(cell: cell, cellForRowAt: indexPath)
            } else {
                setCellNotAvailable(cell: cell, cellForRowAt: indexPath)
            }
        }
        
        return cell
    }
    
    func setCellSearching(cell: SearchAllTableViewCell, cellForRowAt indexPath: IndexPath) {
        let searchAllResult = searchAllResults[indexPath.row]
        var searchResultString = " "
        
        if (searchAllResult.searching) {
            searchResultString = "搜尋中..."
        } else {
            if (searchAllResult.getCount() < 0) {
                searchResultString = " "
                cell.setDictNameLabelActive(isActive: true)
            } else if (searchAllResult.getCount() == 0) {
                searchResultString = "0 筆"
                cell.setDictNameLabelActive(isActive: false)
                cell.setSearchResultLabelActive(isActive: false)
            } else {
                searchResultString = "\(searchAllResult.getCount()) 筆"
                cell.setDictNameLabelActive(isActive: true)
                cell.setSearchResultLabelActive(isActive: true)
            }
        }
        
        cell.dictNameLabel.text = searchAllResult.dictName
        cell.searchResultLabel.text = searchResultString
    }
    
    func setCellNotAvailable(cell: SearchAllTableViewCell, cellForRowAt indexPath: IndexPath) {
        let searchAllResult = searchAllResults[indexPath.row]
        
        cell.dictNameLabel.text = searchAllResult.dictName
        cell.searchResultLabel.text = "(無)"
        
        cell.setDictNameLabelActive(isActive: false)
        cell.setSearchResultLabelActive(isActive: false)
    }
    
    // MARK: - UITableViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchAllResult = searchAllResults[indexPath.row]
        if (searchAllResult.getCount() <= 0) {
            return
        }
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                performSegue(withIdentifier: "segueResultTaihoaSoanntengSutian", sender: nil)
            } else if (indexPath.row == 1) {
                performSegue(withIdentifier: "segueResultTaijitToaSutian", sender: nil)
            } else if (indexPath.row == 2) {
                performSegue(withIdentifier: "segueResultMaryknollTaiengSutian", sender: nil)
            } else if (indexPath.row == 3) {
                performSegue(withIdentifier: "segueResultEmbreeTaigiSutian", sender: nil)
            } else if (indexPath.row == 4) {
                performSegue(withIdentifier: "segueResultKauiokpooTaigiDict", sender: nil)
            } else if (indexPath.row == 5) {
                performSegue(withIdentifier: "segueResultKamJitian", sender: nil)
            } else if (indexPath.row == 6) {
                performSegue(withIdentifier: "segueResultITaigiHoataiSutian", sender: nil)
            } else if (indexPath.row == 7) {
                performSegue(withIdentifier: "segueResultTaioanPehoeKichhooGiku", sender: nil)
            } else if (indexPath.row == 8) {
                performSegue(withIdentifier: "segueResultTaioanSitbutMialui", sender: nil)
            }
        }
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("search: \(searchText)")
        
        searchAll(searchText)
    }
    
    private func setResultsToInitial() {
        for searchAllResult in searchAllResults {
            searchAllResult.searching = false
            searchAllResult.results = nil
        }
        
        self.tableView.reloadData()
    }
    
    private func setResultsToSearching() {
        for searchAllResult in searchAllResults {
            searchAllResult.searching = true
            searchAllResult.results = nil
        }
        
        self.tableView.reloadData()
    }
    
    // MARK: - Search functions
    
    private func searchAll(_ searchString :String) {
        let searchStringTrimmed = searchString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (searchStringTrimmed.isEmpty) {
            setResultsToInitial()
        } else {
            setResultsToSearching()
        }
        
        self.searchKeyword = searchStringTrimmed
        
        if (searchAllType == SearchAllViewController.SEARCH_ALL_TYPE_LOMAJI_SOOJI || searchAllType == SearchAllViewController.SEARCH_ALL_TYPE_LOMAJI) {
            searchAllWithLomaji(searchStringTrimmed)
        } else if (searchAllType == SearchAllViewController.SEARCH_ALL_TYPE_HANLO) {
            searchAllWithHanlo(searchStringTrimmed)
        } else if (searchAllType == SearchAllViewController.SEARCH_ALL_TYPE_HOABUN) {
            searchAllWithHoabun(searchStringTrimmed)
        } else if (searchAllType == SearchAllViewController.SEARCH_ALL_TYPE_ENGBUN) {
            searchAllWithEngbun(searchStringTrimmed)
        }
    }
    
    private func searchAllWithLomaji(_ searchStringTrimmed :String) {
        searchAllWithLomajiInTaibunHoabunSoanntengSutianPublishSubject.onNext(searchStringTrimmed)
        searchAllWithLomajiInTaijitToaSutianSutianPublishSubject.onNext(searchStringTrimmed)
        searchAllWithLomajiInMaryknollTaiengSutianPublishSubject.onNext(searchStringTrimmed)
        searchAllWithLomajiInEmbreeTaigiSutianPublishSubject.onNext(searchStringTrimmed)
        searchAllWithLomajiInKauiokpooTaigiSutianPublishSubject.onNext(searchStringTrimmed)
        searchAllWithLomajiInKamJitianPublishSubject.onNext(searchStringTrimmed)
        searchAllWithLomajiInITaigiTaihoaSutianPublishSubject.onNext(searchStringTrimmed)
        searchAllWithLomajiInTaioanPehoeKichhooGikuPublishSubject.onNext(searchStringTrimmed)
        searchAllWithLomajiInTaioanSitbutMialuiPublishSubject.onNext(searchStringTrimmed)
    }
    
    private func searchAllWithHanlo(_ searchStringTrimmed :String) {
        searchAllWithHanloInTaibunHoabunSoanntengSutianPublishSubject.onNext(searchStringTrimmed)
        searchAllWithHanloInTaijitToaSutianSutianPublishSubject.onNext(searchStringTrimmed)
        searchAllWithHanloInKauiokpooTaigiSutianPublishSubject.onNext(searchStringTrimmed)
        searchAllWithHanloInKamJitianPublishSubject.onNext(searchStringTrimmed)
        searchAllWithHanloInITaigiTaihoaSutianPublishSubject.onNext(searchStringTrimmed)
        searchAllWithHanloInTaioanSitbutMialuiPublishSubject.onNext(searchStringTrimmed)
    }
    
    private func searchAllWithHoabun(_ searchStringTrimmed :String) {
        searchAllWithHoabunInTaibunHoabunSoanntengSutianPublishSubject.onNext(searchStringTrimmed)
        searchAllWithHoabunInMaryknollTaiengSutianPublishSubject.onNext(searchStringTrimmed)
        searchAllWithHoabunInEmbreeTaigiSutianPublishSubject.onNext(searchStringTrimmed)
        searchAllWithHoabunInKauiokpooTaigiSutianPublishSubject.onNext(searchStringTrimmed)
        searchAllWithHoabunInITaigiTaihoaSutianPublishSubject.onNext(searchStringTrimmed)
        searchAllWithHoabunInTaioanPehoeKichhooGikuPublishSubject.onNext(searchStringTrimmed)
    }
    
    private func searchAllWithEngbun(_ searchStringTrimmed :String) {
        searchAllWithEngbunInMaryknollTaiengSutianPublishSubject.onNext(searchStringTrimmed)
        searchAllWithEngbunInEmbreeTaigiSutianPublishSubject.onNext(searchStringTrimmed)
    }
    
    // MARK: - Navigation
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "segueResultTaihoaSoanntengSutian") {
            let vc = segue.destination as! TaihoaSoanntengSutianResultTableViewController
            vc.searchAllType = self.searchAllType
            vc.searchEquals = self.searchEquals
            vc.keyword = self.searchKeyword
        } else if (segue.identifier == "segueResultTaijitToaSutian") {
            let vc = segue.destination as! TaijitToaSutianResultTableViewController
            vc.searchAllType = self.searchAllType
            vc.searchEquals = self.searchEquals
            vc.keyword = self.searchKeyword
        } else if (segue.identifier == "segueResultMaryknollTaiengSutian") {
            let vc = segue.destination as! MaryknollTaiengSutianResultTableViewController
            vc.searchAllType = self.searchAllType
            vc.searchEquals = self.searchEquals
            vc.keyword = self.searchKeyword
        } else if (segue.identifier == "segueResultEmbreeTaigiSutian") {
            let vc = segue.destination as! EmbreeTaigiSutianResultTableViewController
            vc.searchAllType = self.searchAllType
            vc.searchEquals = self.searchEquals
            vc.keyword = self.searchKeyword
        } else if (segue.identifier == "segueResultKauiokpooTaigiDict") {
            let vc = segue.destination as! KauiokpooTaigiDictResultTableViewController
            vc.searchAllType = self.searchAllType
            vc.searchEquals = self.searchEquals
            vc.keyword = self.searchKeyword
        } else if (segue.identifier == "segueResultKamJitian") {
            let vc = segue.destination as! KamJitianResultTableViewController
            vc.searchAllType = self.searchAllType
            vc.searchEquals = self.searchEquals
            vc.keyword = self.searchKeyword
        } else if (segue.identifier == "segueResultITaigiHoataiSutian") {
            let vc = segue.destination as! ITaigiHoataiSutianResultTableViewController
            vc.searchAllType = self.searchAllType
            vc.searchEquals = self.searchEquals
            vc.keyword = self.searchKeyword
        } else if (segue.identifier == "segueResultTaioanPehoeKichhooGiku") {
            let vc = segue.destination as! TaioanPehoeKichhooGikuResultTableViewController
            vc.searchAllType = self.searchAllType
            vc.searchEquals = self.searchEquals
            vc.keyword = self.searchKeyword
        } else if (segue.identifier == "segueResultTaioanSitbutMialui") {
            let vc = segue.destination as! TaioanSitbutMialuiResultTableViewController
            vc.searchAllType = self.searchAllType
            vc.searchEquals = self.searchEquals
            vc.keyword = self.searchKeyword
        }
    }
}



// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.Key: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
