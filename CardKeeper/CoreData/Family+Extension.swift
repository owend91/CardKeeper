//
//  Family+Extension.swift
//  CardKeeper
//
//  Created by David Owen on 1/9/23.
//

import Foundation

extension Family {
    var nameView: String {
        name ?? ""
    }
    
    var addressedAsView: String {
        addressedAs ?? ""
    }
    
    var streetAddress1View: String {
        streetAddress1 ?? ""
    }
    
    var streetAddress2View: String {
        streetAddress2 ?? ""
    }
    
    var cityView: String {
        city ?? ""
    }
    
    var stateView: String {
        state ?? ""
    }
    
    var countryView: String {
        addressedAs ?? ""
    }
    
    var zipCodeView: String {
        zipCode ?? ""
    }
    
    var descriptionView: String {
        familyDescription ?? ""
    }
}
