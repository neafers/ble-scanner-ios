//
//  CharacteristicView.swift
//  BLEScanner
//
//  Created by jeffn on 1/12/23.
//

import SwiftUI

struct CharacteristicView: View {
    var characteristics: [BLECharacteristic]
    
    var body: some View {
        VStack {
            
            // Display a list of characteristics
            ForEach(characteristics, id: \.id) { characteristic in
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Color.gray
                        ForEach(characteristic.items, id: \.self) { item in
                            Text(item)
                                .font(.system(size: 14))
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

struct CharacteristicView_Previews: PreviewProvider {
    static let chars = [
        BLECharacteristic(characteristic: nil),
        BLECharacteristic(characteristic: nil),
        BLECharacteristic(characteristic: nil)]
    static var previews: some View {
        CharacteristicView(characteristics: chars)
    }
}
