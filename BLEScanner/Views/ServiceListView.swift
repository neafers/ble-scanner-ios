//
//  ServiceListView.swift
//  BLEScanner
//
//  Created by jeffn on 1/13/23.
//

import SwiftUI

struct ServiceListView: View {
    let services = DeviceStore.shared.connectedDevice?.services ?? []
    
    var body: some View {
        List {
            
            // Display a list of services
            ForEach(services, id: \.id) { service in
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
}

struct ServiceListView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceListView()
    }
}
