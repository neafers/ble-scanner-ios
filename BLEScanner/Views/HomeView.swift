//
//  ContentView.swift
//  BLEScanner
//
//  Created by jeffn on 1/11/23.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.scenePhase) var scenePhase
    @StateObject var bleScanner = BLEScanner()
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: DevicesView()) {
                    Text("Scan For BLE Devices")
                        .font(.system(size: 20))
                }
            }
            .padding()
            .navigationTitle("Home")
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                bleScanner.startScanning()
            } else if newPhase == .inactive {
                bleScanner.stopScanning()
            } else if newPhase == .background {
                bleScanner.stopScanning()
            }
        }
        .environmentObject(bleScanner)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
