//
//  UnitConversion.swift
//  iTunesSearch
//
//  Created by Esther on 4/14/23.
//

import Foundation

struct UnitConversion {
    func millisToMinSec(millis: Int) -> String {
        let milliseconds = millis
        let seconds = milliseconds / 1000
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        let formattedTime = String(format: "%01d:%02d", minutes, remainingSeconds)
        return formattedTime
    }
    
} // End of Struct
