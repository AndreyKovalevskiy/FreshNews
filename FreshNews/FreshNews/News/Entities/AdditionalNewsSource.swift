//
//  AdditionalNewsSource.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 24.12.20.
//

import Foundation

class LentaRuNewsSource: NewsSource {
    init() {
        super.init(name: "Lenta.ru", url: "http://lenta.ru/rss")
    }
}

class GazetaRuNewsSource: NewsSource {
    init() {
        super.init(name: "Gazeta.ru", url: "http://www.gazeta.ru/export/rss/lenta.xml")
    }
}
