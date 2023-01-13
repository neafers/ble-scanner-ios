//
//  DeviceStore.swift
//  BLEScanner
//
//  Created by jeffn on 1/12/23.
//

import Foundation
import CoreBluetooth

/// DeviceStore is a memory cache of scanned peripherals and a single optional connected peripheral
class DeviceStore: ObservableObject {
    static let shared = DeviceStore()
    
    /// Scanned peripherals
    var peripherals: [String: CBPeripheral] = [String: CBPeripheral]() {
        willSet {
            devices = DeviceStore.shared.peripherals.values.sorted {$0.name ?? "" < $1.name ?? ""}
                .map(BLEDevice.init)
        }
    }
    
    /// Optional connected peripheral
    var connectedPeripheral: CBPeripheral? {
        willSet {
            if newValue == nil {
                connectedDevice = nil
            } else {
                connectedDevice = BLEDevice(peripheral: connectedPeripheral)
            }
        }
    }
    
    /// Sorted list of BLE device picked up by the scanner
    @Published var devices: [BLEDevice] = []
    
    /// A device selected by the user for connection and discovery
    @Published var connectedDevice: BLEDevice?
    
    private init() { }
}
