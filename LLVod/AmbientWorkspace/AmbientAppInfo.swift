import Foundation

/// 应用名、版本与关于说明统一在此维护；名称与版本从安装包读取，改名或升级时无需同步修改文字。
enum AmbientAppInfo {
    static var name: String { Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? "见微ToDo" }
    static var version: String {
        let short = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? ""
        return build.isEmpty ? short : "\(short)（\(build)）"
    }

    /// 关于弹窗正文：标语、版本、简介、数据说明与素材致谢；素材作者与仓库接入说明中的来源表一致。
    static var about: String {
        """
        见微知著，静水流深
        版本 \(version)

        在看不见的细微处持续沉淀，自能从容深远。用一段安静的专注、一个每天的小习惯，把自律慢慢积累成看得见的改变。

        专注记录、习惯打卡、水滴与场景解锁只保存在本机，无需注册账号。
        """
    }
}
