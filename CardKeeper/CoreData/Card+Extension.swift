//
//  Card+Extension.swift
//  CardKeeper
//
//  Created by David Owen on 1/9/23.
//

import UIKit

extension Card {
    
    var frontIdView: String {
        frontId ?? ""
    }
    
    var frontImage: UIImage {
        if !frontIdView.isEmpty,
            let image = FileManager().retrieveImage(with: frontIdView) {
                return image
        } else {
            return UIImage(systemName: "photo")!
        }
    }
    
}
