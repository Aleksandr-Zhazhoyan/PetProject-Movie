//
//  UIApplication+Extension.swift
//  ProjectMovie
//
//  Created by Aleksandr Zhazhoyan on 23.02.2025.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
