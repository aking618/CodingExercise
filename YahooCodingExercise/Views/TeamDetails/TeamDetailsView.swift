//
//  TeamDetailsView.swift
//  YahooCodingExercise
//
//  Created by Ayren King on 9/23/22.
//

import SwiftUI

struct TeamDetailsView: View {
    
    @State var viewModel : TeamDetailsViewModel
    
    @State var currentSortedColumn: Int = 0
    
    @State var sortOrderAsc : [String : Bool] = [
        "TeamName" : true,
        "Wins" : false,
        "Losses" : false,
        "Draws" : false,
        "Total" : false,
    ]
    

    let columns = [GridItem(.flexible(), alignment: .topLeading), GridItem(.fixed(24), alignment: .center), GridItem(.fixed(24), alignment: .center), GridItem(.fixed(24), alignment: .center), GridItem(.fixed(24), alignment: .center)]
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 36) {
                    
                    DetailHeader(
                        viewModel: $viewModel,
                        currentSortedColumn: $currentSortedColumn,
                        sortOrderAsc: $sortOrderAsc)
                    
                    Group {
                        Divider()
                        Divider()
                        Divider()
                        Divider()
                        Divider()
                    }
                    
                    ForEach(viewModel.gameStats) { stat in
                        Text(stat.opponentTeamName)
                        Text(String(stat.wins))
                        Text(String(stat.losses))
                        Text(String(stat.draws))
                        Text(String(stat.total))
                    }
                    
                }
                .padding()
                
            }
            .background(.white)
            .animation(.easeInOut)
            .padding(.top)
            .navigationTitle(Text(viewModel.teamName))
        }
        .background(LinearGradient(colors: [.green.opacity(0.3), .blue.opacity(0.5)],
                                   startPoint: .topLeading, endPoint: .bottomTrailing))
    }
    
}
