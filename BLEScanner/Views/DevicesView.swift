//
//  DevicesView.swift
//  BLEScanner
//
//  Created by jeffn on 1/12/23.
//

import SwiftUI

struct DevicesView: View {
    var body: some View {
        List {
            
            // Display a list of devices
            ForEach(DeviceStore.shared.devices, id: \.id) { device in
                NavigationLink(device.name, destination: ServicesView(device: device))
            }
        }
        .navigationTitle("Devices")
    }
}

struct DevicesView_Previews: PreviewProvider {
    static var previews: some View {
        DevicesView()
    }
}
