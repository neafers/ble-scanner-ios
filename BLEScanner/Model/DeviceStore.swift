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
    var bleDevices: [String: CBPeripheral] = [String: CBPeripheral]() {
        willSet {
            devices = DeviceStore.shared.bleDevices.values.sorted {$0.name ?? "" < $1.name ?? ""}
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
    
    @Published var devices: [BLEDevice] = []
    @Published var connectedDevice: BLEDevice?
    
    private init() { }
}
