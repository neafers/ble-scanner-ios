//
//  BLEService.swift
//  BLEScanner
//
//  Created by jeffn on 1/12/23.
//

import Foundation
import CoreBluetooth


/// Wraps a CBService and provides view isolation
struct BLEService {
    let service: CBService?
    let description: String
    let id: String
    var characteristics: [BLECharacteristic] = []
    
    init(service: CBService?) {
        self.service = service
        description = service?.description ?? "description unknown"
        id = service?.uuid.uuidString ?? UUID().uuidString
        
        guard let characteristics = service?.characteristics else { return }
        for characteristic in characteristics {
            self.characteristics.append(BLECharacteristic(characteristic: characteristic))
        }
    }
    
    /// Parses the name or UUID from the description
    var name: String {
        guard self.description.count > 0 else { return "" }
        let strings = self.description.trimmingCharacters(in: CharacterSet(charactersIn: "<>")).split(separator: ",")
        for string in strings {
            if string.hasPrefix(" UUID") {
                let nameValue = string.split(separator: "=")
                if nameValue.count == 2 {
                    return nameValue[1].trimmingCharacters(in: .whitespaces)
                }
            }
        }
        return ""
    }
}
