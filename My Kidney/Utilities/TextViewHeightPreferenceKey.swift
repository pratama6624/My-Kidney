//
//  TextViewHeightPreferenceKey.swift
//  My Kidney
//
//  Created by Pratama One on 21/07/24.
//

import Foundation
import SwiftUI

struct TextViewHeightPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue nextvalue: () -> CGFloat) {
        value = max(value, nextvalue())
    }
}
