//
//  SourceManager.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 29.12.20.
//

import Foundation

class SourceManager {
    
    static let shared = SourceManager()
    
    private var sourceList: [NewsSource]
    
    private init() {
        sourceList = [LentaRuNewsSource(),
                      GazetaRuNewsSource()]
    }
    
    func allRecources() -> [NewsSource] {
        return sourceList
    }
    
    func isEnebledSources() -> [NewsSource] {
        return sourceList.filter { $0.isEnabled }
    }
}
