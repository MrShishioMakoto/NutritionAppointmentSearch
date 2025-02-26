//
//  String+Extension.swift
//  NutritionAppointmentSearch
//
//  Created by Gonçalo Almeida on 24/02/2025.
//

import Foundation

extension String {
    func localizable() -> String {
        NSLocalizedString(self, comment: "")
    }
}
