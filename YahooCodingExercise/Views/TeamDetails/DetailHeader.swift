//
//  DetailHeader.swift
//  YahooCodingExercise
//
//  Created by Ayren King on 9/24/22.
//

import SwiftUI

struct DetailHeader: View {
    
    @Binding var viewModel : TeamDetailsViewModel
    
    @Binding var currentSortedColumn: Int
    
    @Binding var sortOrderAsc : [String : Bool]
    
    var body: some View {
        Group {
            Button(action: {
                if sortOrderAsc["TeamName"]! {
                    viewModel.gameStats = viewModel.gameStats.sorted { $0.opponentTeamName.lowercased() < $1.opponentTeamName.lowercased() }
                }
                else {
                    viewModel.gameStats = viewModel.gameStats.sorted { $0.opponentTeamName.lowercased() > $1.opponentTeamName.lowercased() }
                }
                
                sortOrderAsc["TeamName"] = !sortOrderAsc["TeamName"]!
                currentSortedColumn = 0;
            }) {
                VStack {
                    Text("Team Name")
                        .font(.title3)
                        .bold()
                    
                    if currentSortedColumn == 0 {
                        Image(systemName: sortOrderAsc["TeamName"]! ? "chevron.down" : "chevron.up")
                    }
                }
            }
            .foregroundColor(currentSortedColumn == 0 ? Color.green : Color.black)
            
            Button(action: {
                if sortOrderAsc["Wins"]! {
                    viewModel.gameStats = viewModel.gameStats.sorted { $0.wins < $1.wins }
                }
                else {
                    viewModel.gameStats = viewModel.gameStats.sorted { $0.wins > $1.wins }
                }
                
                sortOrderAsc["Wins"] = !sortOrderAsc["Wins"]!
                currentSortedColumn = 1;
            }) {
                VStack {
                    Text("W")
                        .font(.title3)
                        .bold()
                    if currentSortedColumn == 1 {
                        Image(systemName: sortOrderAsc["Wins"]! ? "chevron.down" : "chevron.up")
                    }
                }
            }
            .foregroundColor(currentSortedColumn == 1 ? Color.green : Color.black)
            
            Button(action: {
                if sortOrderAsc["Losses"]! {
                    viewModel.gameStats = viewModel.gameStats.sorted { $0.losses < $1.losses }
                }
                else {
                    viewModel.gameStats = viewModel.gameStats.sorted { $0.losses > $1.losses }
                }
                
                sortOrderAsc["Losses"] = !sortOrderAsc["Losses"]!
                currentSortedColumn = 2;
            }) {
                VStack {
                    Text("L")
                        .font(.title3)
                        .bold()
                    if currentSortedColumn == 2 {
                        Image(systemName: sortOrderAsc["Losses"]! ? "chevron.down" : "chevron.up")
                    }
                }
            }
            .foregroundColor(currentSortedColumn == 2 ? Color.green : Color.black)
            
            Button(action: {
                if sortOrderAsc["Draws"]! {
                    viewModel.gameStats = viewModel.gameStats.sorted { $0.draws < $1.draws }
                }
                else {
                    viewModel.gameStats = viewModel.gameStats.sorted { $0.draws > $1.draws }
                }
                
                sortOrderAsc["Draws"] = !sortOrderAsc["Draws"]!
                currentSortedColumn = 3;
            }) {
                VStack {
                    Text("D")
                        .font(.title3)
                        .bold()
                    if currentSortedColumn == 3 {
                        Image(systemName: sortOrderAsc["Draws"]! ? "chevron.down" : "chevron.up")
                    }
                }
            }
            .foregroundColor(currentSortedColumn == 3 ? Color.green : Color.black)
            
            Button(action: {
                if sortOrderAsc["Total"]! {
                    viewModel.gameStats = viewModel.gameStats.sorted { $0.total < $1.total }
                }
                else {
                    viewModel.gameStats = viewModel.gameStats.sorted { $0.total > $1.total }
                }
                
                sortOrderAsc["Total"] = !sortOrderAsc["Total"]!
                currentSortedColumn = 4;
            }) {
                VStack {
                    Text("T")
                        .font(.title3)
                        .bold()
                    if currentSortedColumn == 4 {
                        Image(systemName: sortOrderAsc["Total"]! ? "chevron.down" : "chevron.up")
                    }
                }
            }
            .foregroundColor(currentSortedColumn == 4 ? Color.green : Color.black)
        }
    }
}
