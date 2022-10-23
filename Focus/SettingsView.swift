//
//  SettingsView.swift
//  Focus
//
//  Created by Jacob Pantuso on 2022-10-22.
//

import SwiftUI
struct SettingsView: View {
    
    @State private var countdownTimer: Int = 60
    
    var body: some View {
        VStack {
            icon
            title
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

private extension SettingsView {

    var icon: some View {
        Image(systemName: "gear")
            .resizable()
            .frame(width: 40, height: 40)
    }
    var title: some View {
        Text("Settings")
            .font(.system(size:30))
            .bold()
            .foregroundColor(.black)
    }
}
