//
//  HeaderRoundDate.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 4/12/2023.
//

import SwiftUI

struct HeaderRoundDate: View {
    var date: Date
    var roundNo: String
    var isFullDate: Bool
    var body: some View {
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE d MMM h:mm a"
        return dateFormatter.string(from: date)
    }
    var shortDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE d MMM"
        return dateFormatter.string(from: date)
    }
        HeaderTextView(text: isFullDate ? "\(roundNo) - \(formattedDate)" : "\(roundNo) - \(shortDate)")
    }
}

#Preview {
    HeaderRoundDate(date: Date(), roundNo: "Round 1", isFullDate: true)
}
