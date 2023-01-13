//
//  DeviceView.swift
//  BLEScanner
//
//  Created by jeffn on 1/12/23.
//

import SwiftUI

struct ServicesView: View {
    @EnvironmentObject var bleScanner: BLEScanner
    var device: BLEDevice
    
    var body: some View {
        VStack {
            
            // Display discovery state changes and finally the device name
            switch bleScanner.scanState {
            case .idle:
                Text("Idle")
            case .scanning:
                Text("Scanning")
            case .connecting:
                Text("Connecting")
            case .discoveringServices:
                Text("Discovering Services")
            case .discoveringCharacteristics:
                Text("Discovering Characteristics")
            case .readingValues, .updatingValue:
                Text(DeviceStore.shared.connectedDevice?.name ?? "")
            }
            
            // Display a list of services
            ServiceListView()
        }
        .navigationTitle("Services")
        .navigationBarTitleDisplayMode(.inline)
        
        .onAppear() {
            // Connect to the device when this view appears
            bleScanner.connect(device: device)
        }
    }
}

struct ServicesView_Previews: PreviewProvider {
    static var previews: some View {
        ServicesView(device: BLEDevice(peripheral: nil))
            .environmentObject(BLEScanner())
    }
}
