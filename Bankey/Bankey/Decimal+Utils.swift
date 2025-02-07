//
//  Decimal+Utils.swift
//  Bankey
//
//  Created by simonecaria on 07/02/25.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
