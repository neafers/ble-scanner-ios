//
//  BLEScanner.swift
//  BLEScanner
//
//  Created by jeffn on 1/12/23.
//

import Foundation
import CoreBluetooth

/// BLE Scanner scans for, connects to, and discovers services and characteristics for BLE devices
class BLEScanner: NSObject, ObservableObject {
    
    /// Defines the various states of the scanner
    enum ScanState {
        case idle, scanning, connecting, discoveringServices, discoveringCharacteristics, readingValues, updatingValue
    }
    
    private var centralManager: CBCentralManager!
    private var poweredOn = false
    private var connectedPeripheral: CBPeripheral?
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    /// Defines the current state of the scanner
    @Published var scanState: ScanState = .idle
    
    /// Start scanning for devices
    func startScanning() {
        guard let centralManager = centralManager else { return }
        guard poweredOn else { return }
        let options = [CBCentralManagerScanOptionAllowDuplicatesKey: false]
        centralManager.scanForPeripherals(withServices: nil, options: options)
        scanState = .scanning
    }
    
    /// Stop scanning for devices
    func stopScanning() {
        guard let centralManager = centralManager else { return }
        scanState = .idle
        
        centralManager.stopScan()
    }
    
    /// Connect to a specific peripheral
    func connect(device: BLEDevice) {
        if let connectedPeripheral = connectedPeripheral {
            centralManager.cancelPeripheralConnection(connectedPeripheral)
        }
        DeviceStore.shared.connectedPeripheral = nil
        guard let peripheral = device.peripheral else { return }
        scanState = .connecting
        
        centralManager.connect(peripheral)
    }
}

// MARK: - CBCentralManagerDelegate Delegate

extension BLEScanner: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            poweredOn = true
            startScanning()
        }
        else if central.state == .poweredOff {
            poweredOn = false
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        DeviceStore.shared.peripherals[peripheral.identifier.uuidString] = peripheral
        peripheral.delegate = self
    }
}

// MARK: - CBPeripheralDelegate Delegate

extension BLEScanner: CBPeripheralDelegate {
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        DeviceStore.shared.connectedPeripheral = peripheral
        scanState = .discoveringServices
        peripheral.discoverServices(nil)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        DeviceStore.shared.connectedPeripheral = peripheral
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
        if services.count > 0 {
            scanState = .discoveringCharacteristics
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        DeviceStore.shared.connectedPeripheral = peripheral
        for characteristic in characteristics {
            peripheral.readValue(for: characteristic)
        }
        if characteristics.count > 0 {
            scanState = .readingValues
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        DeviceStore.shared.connectedPeripheral = peripheral
        if let _ = characteristic.value {
            scanState = .updatingValue
        }
    }
}
