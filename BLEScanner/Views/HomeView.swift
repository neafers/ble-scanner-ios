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
        
        // Display a navigation stack and a single button
        NavigationStack {
            VStack {
                NavigationLink {
                    DevicesView()
                } label: {
                    Label("Scan for BLE Devices", systemImage: "radio")
                        .font(.system(size: 20))
                }
                .offset(y: -50)
            }
            .navigationTitle("Home")
        }
        
        // Detect app lifecycle changes and react
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                bleScanner.startScanning()
            } else if newPhase == .inactive {
                bleScanner.stopScanning()
            } else if newPhase == .background {
                bleScanner.stopScanning()
            }
        }
        
        // Store the scanner as an environment object so we can access it later
        .environmentObject(bleScanner)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
