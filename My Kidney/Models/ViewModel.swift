//
//  ViewModel.swift
//  My Kidney
//
//  Created by Pratama One on 18/07/24.
//

import Foundation
import SwiftUI
import Combine

struct TabItemModel: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let view: AnyView
}
