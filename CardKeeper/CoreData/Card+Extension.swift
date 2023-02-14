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
    
    var backIdView: String {
        backId ?? ""
    }
    
    var cardDescriptionView: String {
        cardDescription ?? ""
    }
    
    var dateReceivedView: String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MM-dd-yyyy"
        if let dateReceived {
            return dateFormatterPrint.string(from: dateReceived)
        } else {
            return ""
        }
    }
    
    var frontImage: UIImage {
//        if !frontIdView.isEmpty,
//            let image = FileManager().retrieveImage(with: frontIdView) {
//                return image
//        } else {
//            return UIImage(systemName: "photo")!
//        }
        cardFrontImage ?? UIImage(systemName: "photo")!
    }
    
    var backImage: UIImage {
//        if !backIdView.isEmpty,
//            let image = FileManager().retrieveImage(with: backIdView) {
//                return image
//        } else {
//            return UIImage(systemName: "photo")!
//        }
        cardBackImage ?? UIImage(systemName: "photo")!
    }
    
}
