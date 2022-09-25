//
//  OverviewView.swift
//  YahooCodingExercise
//
//  Created by Ayren King on 9/23/22.
//

import SwiftUI

struct OverviewView: View {
    
    @State var viewModel : OverviewViewModel = .init(teamSummaries: TeamSummaries())
    
    @State var loading : Bool = true
    
    @State var currentSortedColumn: Int = 0
    
    @State var sortOrderAsc : [String : Bool] = [
        "TeamName" : true,
        "Wins" : false,
        "Losses" : false,
        "Draws" : false,
        "WinPercentage" : false,
    ]
    
    let columns = [GridItem(.flexible(), alignment: .topLeading),  GridItem(.fixed(24), alignment: .center), GridItem(.fixed(24), alignment: .center), GridItem(.fixed(24), alignment: .center), GridItem(.fixed(64), alignment: .center)]
    
    var body: some View {
        NavigationView {
            ZStack {
                if loading {
                    Spinner()
                }
                
                if viewModel.teamSummaries.isEmpty  && !loading {
                    Text("No records were found at this time.")
                }
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 36) {
                        OverviewHeader(
                            viewModel: $viewModel,
                            currentSortedColumn: $currentSortedColumn,
                            sortOrderAsc: $sortOrderAsc
                        )
                        
                        Group {
                            Divider()
                            Divider()
                            Divider()
                            Divider()
                            Divider()
                        }
                        
                        ForEach(viewModel.teamSummaries) { teamSummary in
                            NavigationLink(teamSummary.teamName) {
                                TeamDetailsView(viewModel: TeamDetailsViewModel(teamSummary: teamSummary))
                            }
                            Text(String(teamSummary.wins))
                            Text(String(teamSummary.losses))
                            Text(String(teamSummary.draws))
                            Text(String(teamSummary.winPercentage))
                        }
                        
                    }
                    .padding()
                    
                    
                }
            }
            .background(.white)
            .animation(.easeInOut)
            .padding(.top)
            .onAppear() {
                if viewModel.teamSummaries.isEmpty {
                    
                    GameRecordServerAF().requestGameRecords { gameRecords in
                        self.viewModel.teamSummaries = GameRecordServerAF().parseGameRecords(records: gameRecords)
                        self.viewModel.teamSummaries.sort { $0.winPercentage > $1.winPercentage }
                        self.loading = false
                    }
                }
            }
            .background(LinearGradient(colors: [.green.opacity(0.3), .blue.opacity(0.5)],
                                       startPoint: .topLeading, endPoint: .bottomTrailing))
            .navigationBarTitle(Text("Overall Standings"))
        }
    }
}

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewView()
    }
}
