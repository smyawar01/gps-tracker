//
//  PermissionErrorView.swift
//  gps-tracker
//
//  Created by muhammad Yawar on 8/28/23.
//

import SwiftUI

struct PermissionErrorView: View {
    
    private let onPress: () -> Void
    
    public init(onPress: @escaping () -> Void) {
        self.onPress = onPress
    }
    
    var body: some View {
        
        HStack {
            
            Text("In order to work GPS Tracker App requires location permission.")
            Button {
                onPress()
            } label: {
                Text("Ask me")
            }
        }
        .padding()
        .background { Color(uiColor: UIColor.lightGray) }
        .cornerRadius(10)
    }
}

private struct PermissionErrorWithButton: View {
    
    @State var text = ""
    var body: some View {
    
        VStack {
            
            PermissionErrorView {
                
                text = "Button Pressed"
            }
            Text(text)
        }
    }
}

struct PermissionErrorView_Previews: PreviewProvider {
    static var previews: some View {
        
        PermissionErrorWithButton()
    }
}
