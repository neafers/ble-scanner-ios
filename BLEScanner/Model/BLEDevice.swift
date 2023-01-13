//
//  BLEDevice.swift
//  BLEScanner
//
//  Created by jeffn on 1/12/23.
//

import Foundation
import CoreBluetooth

/// Wraps a CBPeripheral and provides view isolation
struct BLEDevice {
    let peripheral: CBPeripheral?
    let name: String
    let id: String
    var services: [BLEService] = []
    
    /// Creates a wrapper for a CBPeripheral
    init(peripheral: CBPeripheral?) {
        self.peripheral = peripheral
        self.name = peripheral?.name ?? "unknown name"
        self.id = peripheral?.identifier.uuidString ?? UUID().uuidString
        
        guard let services = peripheral?.services else { return }
        for service in services {
            self.services.append(BLEService(service: service))
        }
    }
}
