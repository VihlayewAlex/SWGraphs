//
//  Extensions.swift
//  Pods
//
//  Created by Alex Vihlayew on 3/18/17.
//
//

import Foundation

extension Int {
    
    func alphabetOrderRepresentation() -> Character {
        let baseScalar = "a".unicodeScalars.first
        
        return Character(UnicodeScalar(Int((baseScalar?.value)!) + self)!)
    }
    
}
