//
//  DateBox.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 3/12/2023.
//

import SwiftUI

struct DateBox: View {
    var date: Date
    var myDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: date)
    }
    var myString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        return dateFormatter.string(from: date)
    }
    var myTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: date)
    }
    var body: some View {
        VStack {
            Text("\(myDay)")
                .font(.system(size: 16))
                .fontWeight(.bold)
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity)
                .background(GetColor(dow: myDay))
                .padding(.top, -2)
            Text("\(myTime)")
                .foregroundStyle(Color("DarkColor"))
                .font(.system(size: 17))
                .fontWeight(.semibold)
                .padding(.vertical, 1)
            Text("\(myString)")
                .font(.system(size: 13))
                .foregroundStyle(Color("DarkColor"))
           }
           .frame(width: 75, height: 75)
           .clipShape(RoundedRectangle(cornerRadius: 10))
           .overlay(
               RoundedRectangle(cornerRadius: 10)
                   .stroke(Color.black, lineWidth: 1)
           )
    }
    func GetColor(dow: String) -> Color {
        if dow == "Mon" {return Color.orange}
        if dow == "Tue" {return Color.yellow}
        if dow == "Wed" {return Color.green}
        if dow == "Thur" {return Color.teal}
        if dow == "Fri" {return Color.blue}
        if dow == "Sat" {return Color.purple}
        if dow == "Sun" {return Color.red}
        else {return Color.yellow}
    }
}

#Preview {
    DateBox(date: Date())
}
