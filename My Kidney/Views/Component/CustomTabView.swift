//
//  CustomTabView.swift
//  My Kidney
//
//  Created by Pratama One on 20/07/24.
//

import SwiftUI

struct CustomTabView: View {
    @State private var selectedTab = 0
    let tabItems: [TabItemModel]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                tabItems[selectedTab].view
                Spacer()
            }
            
            CustomTabBarView(selectedTab: $selectedTab, tabItems: tabItems)
                .frame(height: 40)
        }
    }
}
