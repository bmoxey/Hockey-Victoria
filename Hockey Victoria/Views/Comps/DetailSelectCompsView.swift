//
//  DetailSelectCompsView.swift
//  Hockey Victoria
//
//  Created by Brett Moxey on 2/12/2023.
//

import SwiftUI

struct DetailSelectCompsView: View {
    @Binding var searching: Bool
    @Binding var comps: [Competitions]
    @Binding var selectedWeek: Int
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    List {
                        OutlineGroup(comps, children: \.items) { row in
                            if (row.items?.isEmpty ?? true) {
                                Text(row.name)
                                    .foregroundStyle(Color("DarkColor"))
                                    .font(.footnote)
                                    .frame(height: 10)
                                    .listRowBackground(Color.white.opacity(0.5))
                            } else {
                                HStack {
                                    Image(systemName: row.isSelected ? "checkmark.circle.fill" : "x.circle")
                                        .foregroundStyle(Color(row.isSelected ? .green : .red))
//                                        .symbolEffect(.replace)
                                    Text(row.name)
                                        .foregroundStyle(Color("DarkColor"))
                                }
                                .onTapGesture {
                                    row.isSelected.toggle()
                                    comps = comps.map {
                                        competition in Competitions(name: competition.name, nameID: competition.nameID, isSelected: competition.isSelected, items: competition.items)
                                    }
                                    
                                }
                                .contentTransition(.symbolEffect(.replace))
                            }
                        }
                        .listRowBackground(Color.white)
                    }
                    .environment(\.defaultMinListRowHeight, 10)
                    .scrollContentBackground(.hidden)
                    .background(Color("LightColor"))
                }
                VStack {
                    Text("Select week to search for teams")
                    Picker("Select week to search for teams:", selection: $selectedWeek) {
                        ForEach(1..<13, id: \.self) {number in
                            Text("\(number)")
                        }
                    }
                    .pickerStyle(.palette)
                    Button(action: {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.8)) {
                            searching = true
                        }
                    }, label: {
                        Text("Search competitions")
                            .frame(width: 220, height: 40)
                            .background(Color("AccentColor").gradient)
                            .foregroundStyle(Color("DarkColor"))
                            .fontWeight(.semibold)
                            .cornerRadius(10.0)
                    })
                }
            }
            .background(Color("DarkColor"))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Select your competitions")
                        .foregroundStyle(Color.white)
                        .fontWeight(.semibold)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Image("LightLogo")
                        .resizable()
                        .frame(width: 93, height: 34)
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color("DarkColor"), for: .navigationBar)
        }
    }
}

#Preview {
    DetailSelectCompsView(searching: .constant(false), comps: .constant([]), selectedWeek: .constant(3))
}
