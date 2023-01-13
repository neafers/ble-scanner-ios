//
//  BLECharacteristic.swift
//  BLEScanner
//
//  Created by jeffn on 1/12/23.
//

import Foundation
import CoreBluetooth

/// Wraps a CBCharacteristic and provides view isolation
struct BLECharacteristic {
    let characteristic: CBCharacteristic?
    let description: String
    let id: String
    var values: [String] = []
    
    /// Creates a wrapper for a CBCharacteristic
    init(characteristic: CBCharacteristic?) {
        self.characteristic = characteristic
        description = characteristic?.description ?? "description unknown"
        id = characteristic?.uuid.uuidString ?? UUID().uuidString
    }
    
    /// Individual characteristic description items as a string array
    var items: [String] {
        guard self.description.count > 0 else { return [] }
        var items = self.description
            .trimmingCharacters(in: CharacterSet(charactersIn: "<>"))
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }
        items.removeAll(where: { $0.hasPrefix("CBCharacteristic") })
        if let data = characteristic?.value {
            items.removeAll(where: { $0.hasPrefix("value") })
            items.removeAll(where: { $0.hasPrefix("bytes") })
            let strValue = String(decoding: data, as: UTF8.self)
            items.append(String("value = \(strValue)"))
        }
        return items
    }
}
