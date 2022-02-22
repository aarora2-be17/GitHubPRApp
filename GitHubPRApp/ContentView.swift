//
//  ContentView.swift
//  GitHubPRApp
//
//  Created by Arora, Abhishek on 20/02/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var fetcher = PRFetcher()
    
    var body: some View {
        NavigationView {
            List(fetcher.pullRequests) { pr in
                HStack {
                    AsyncImage(url: URL(string: pr.user.avatar_url ?? "")
                               , content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 100)
                    }, placeholder: {
                        Image(systemName: "photo")
                    })
                    Spacer()
                    VStack {
                        Text(pr.title ?? "")
                            .fontWeight(Font.Weight.bold)
                            .lineLimit(2)
                            .foregroundColor(Color.black)
                        Text("User \(pr.user.login)")
                            .fontWeight(Font.Weight.bold)
                            .lineLimit(1)
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.leading)
                        Text("Created At \(pr.created_at)")
                            .fontWeight(Font.Weight.regular)
                            .lineLimit(1)
                            .foregroundColor(Color.blue)
                            .multilineTextAlignment(.leading)
                        Text("Closed At \(pr.closed_at ?? "")")
                            .fontWeight(Font.Weight.regular)
                            .lineLimit(1)
                            .foregroundColor(Color.green)
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                }
            }
            .navigationTitle("Pull Requests")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
