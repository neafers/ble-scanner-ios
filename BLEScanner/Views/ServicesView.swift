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
            List {
                ForEach(DeviceStore.shared.connectedDevice?.services ?? [], id: \.id) { service in
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill(Color(.systemGray))
                            Text(service.name)
                                .font(.system(size: 14))
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        CharacteristicView(characteristics: service.characteristics)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
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
