import Foundation
import RealmSwift

public class TaihoaSoanntengSutianModel: Object {
    @objc dynamic var id: String?
    @objc dynamic var poj_unicode: String?
    @objc dynamic var poj_unicode_dialect: String?
    @objc dynamic var poj_input: String?
    @objc dynamic var poj_input_dialect: String?
    @objc dynamic var hanlo_taibun_poj: String?
    @objc dynamic var kiplmj_unicode: String?
    @objc dynamic var kiplmj_unicode_dialect: String?
    @objc dynamic var kiplmj_input: String?
    @objc dynamic var kiplmj_input_dialect: String?
    @objc dynamic var hanlo_taibun_kiplmj: String?
    @objc dynamic var hoabun: String?
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}

public class TaijitToaSutianModel: Object {
    @objc dynamic var id: String?
    @objc dynamic var poj_unicode: String?
    @objc dynamic var poj_unicode_dialect: String?
    @objc dynamic var poj_input: String?
    @objc dynamic var poj_input_dialect: String?
    @objc dynamic var hanlo_taibun_poj: String?
    @objc dynamic var hanlo_taibun_kaisoeh_poj: String?
    @objc dynamic var hanlo_taibun_leku_poj: String?
    @objc dynamic var kiplmj_unicode: String?
    @objc dynamic var kiplmj_unicode_dialect: String?
    @objc dynamic var kiplmj_input: String?
    @objc dynamic var kiplmj_input_dialect: String?
    @objc dynamic var hanlo_taibun_kiplmj: String?
    @objc dynamic var hanlo_taibun_kaisoeh_kiplmj: String?
    @objc dynamic var hanlo_taibun_leku_kiplmj: String?
    @objc dynamic var page_number: String?
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}

public class MaryknollTaiengSutianModel: Object {
    @objc dynamic var id: String?
    @objc dynamic var poj_unicode: String?
    @objc dynamic var poj_input: String?
    @objc dynamic var kiplmj_unicode: String?
    @objc dynamic var kiplmj_input: String?
    @objc dynamic var hoabun: String?
    @objc dynamic var english_descriptions: String?
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}

public class EmbreeTaigiSutianModel: Object {
    @objc dynamic var id: String?
    @objc dynamic var poj_unicode: String?
    @objc dynamic var poj_input: String?
    @objc dynamic var kiplmj_unicode: String?
    @objc dynamic var kiplmj_input: String?
    @objc dynamic var abbreviations: String?
    @objc dynamic var noun_classifiers: String?
    @objc dynamic var reduplication: String?
    @objc dynamic var hoabun: String?
    @objc dynamic var english_descriptions: String?
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}

public class KauiokpooTaigiSutianModel: Object {
    @objc dynamic var id: String?
    @objc dynamic var poj_unicode: String?
    @objc dynamic var poj_unicode_dialect: String?
    @objc dynamic var poj_input: String?
    @objc dynamic var poj_input_dialect: String?
    @objc dynamic var kiplmj_unicode: String?
    @objc dynamic var kiplmj_unicode_dialect: String?
    @objc dynamic var kiplmj_input: String?
    @objc dynamic var kiplmj_input_dialect: String?
    @objc dynamic var word_property: String?
    @objc dynamic var word_bunpeh_property: String?
    @objc dynamic var word_dialect_property: String?
    @objc dynamic var hanji_taibun: String?
    @objc dynamic var hoabun: String?
    @objc dynamic var descriptions: String?
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}

public class KamJitianModel: Object {
    @objc dynamic var id: String?
    @objc dynamic var poj_unicode: String?
    @objc dynamic var poj_input: String?
    @objc dynamic var hanlo_taibun_poj: String?
    @objc dynamic var poj_kaisoeh: String?
    @objc dynamic var hanlo_taibun_kaisoeh_poj: String?
    @objc dynamic var kiplmj_unicode: String?
    @objc dynamic var kiplmj_input: String?
    @objc dynamic var hanlo_taibun_kiplmj: String?
    @objc dynamic var kiplmj_kaisoeh: String?
    @objc dynamic var page_number: String?
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}

public class ITaigiHoataiSutianModel: Object {
    @objc dynamic var id: String?
    @objc dynamic var poj_unicode: String?
    @objc dynamic var poj_input: String?
    @objc dynamic var kiplmj_unicode: String?
    @objc dynamic var kiplmj_input: String?
    @objc dynamic var hanlo_taibun_kiplmj: String?
    @objc dynamic var hoabun: String?
    @objc dynamic var from: String?
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}

public class TaioanPehoeKichhooGikuModel: Object {
    @objc dynamic var id: String?
    @objc dynamic var poj_unicode: String?
    @objc dynamic var poj_unicode_dialect: String?
    @objc dynamic var poj_input: String?
    @objc dynamic var poj_input_dialect: String?
    @objc dynamic var kiplmj_unicode: String?
    @objc dynamic var kiplmj_unicode_dialect: String?
    @objc dynamic var kiplmj_input: String?
    @objc dynamic var kiplmj_input_dialect: String?
    @objc dynamic var hoabun: String?
    @objc dynamic var page_number: String?
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}

public class TaioanSitbutMialuiModel: Object {
    @objc dynamic var id: String?
    @objc dynamic var poj_unicode: String?
    @objc dynamic var poj_input: String?
    @objc dynamic var kiplmj_unicode: String?
    @objc dynamic var kiplmj_input: String?
    @objc dynamic var hanji_taibun: String?
    @objc dynamic var page_number: String?
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}

