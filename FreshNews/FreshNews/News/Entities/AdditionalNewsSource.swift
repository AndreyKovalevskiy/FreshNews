//
//  AdditionalNewsSource.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 24.12.20.
//

import Foundation

class LentaRuNewsSource: NewsSource {
    init() {
        super.init(name: "Lenta.ru", url: "https://lenta.ru/rss")
    }
}

class GazetaRuNewsSource: NewsSource {
    init() {
        super.init(name: "Gazeta.ru", url: "https://www.gazeta.ru/export/rss/lenta.xml")
    }
}
