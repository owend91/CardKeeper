//
//  Year+Extension.swift
//  CardKeeper
//
//  Created by David Owen on 1/9/23.
//

import Foundation

extension Year {
    var yearView: String {
        year ?? ""
    }
    
    var categoryArray: [Category] {
        let set = category as? Set<Category> ?? []
        return set.sorted { $0.nameView < $1.nameView}
    }
}
