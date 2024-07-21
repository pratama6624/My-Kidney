//
//  TabView.swift
//  My Kidney
//
//  Created by Pratama One on 21/07/24.
//

import SwiftUI

struct TabView: View {
    var rule: String = ""
    var adminAccessPermission: Int = 0
    
    var body: some View {
        VStack {
            TopNavigationView()
                .padding(.horizontal, 5)
        }
        .padding(.horizontal)
        
        if rule == "Admin" && adminAccessPermission == 1 {
            CustomTabView(tabItems: [
                TabItemModel(title: "Home", icon: "house", view: AnyView(HomeAdminView())),
                TabItemModel(title: "News", icon: "newspaper", view: AnyView(NewsView())),
                TabItemModel(title: "Reports", icon: "doc.text", view: AnyView(ReportsView())),
                TabItemModel(title: "Settings", icon: "gear", view: AnyView(SettingsView(rule: rule)))
            ])
        } else if rule == "Doctor" {
            CustomTabView(tabItems: [
                TabItemModel(title: "Home", icon: "house", view: AnyView(HomePatientView())),
                TabItemModel(title: "Patient", icon: "person.2", view: AnyView(Text("Search View"))),
                TabItemModel(title: "Consultation", icon: "message", view: AnyView(Text("Profile View"))),
                TabItemModel(title: "Settings", icon: "gear", view: AnyView(SettingsView(rule: rule)))
            ])
        } else if rule == "Patient" {
            CustomTabView(tabItems: [
                TabItemModel(title: "Home", icon: "house", view: AnyView(HomePatientView())),
                TabItemModel(title: "Diagnosa", icon: "stethoscope", view: AnyView(DiagnosisView())),
                TabItemModel(title: "Konsultasi", icon: "person.2", view: AnyView(ConsultationPatientView(userRule: "Doctor"))),
                TabItemModel(title: "Settings", icon: "gear", view: AnyView(SettingsView(rule: rule)))
            ])
        } else {
            Text("Silahkan Login")
        }
    }
}

#Preview {
    // Hard code aja dulu bree
    TabView(rule: "Admin", adminAccessPermission: 1)
}
