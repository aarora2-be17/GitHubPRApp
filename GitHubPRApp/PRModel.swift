//
//  PRModel.swift
//  GitHubPRApp
//
//  Created by Arora, Abhishek on 22/02/22.
//

import Foundation

struct User: Identifiable, Decodable {
    var id: Int
    var login : String
    var avatar_url : String?
}

enum CodingKeys : String, CodingKey {
    case id
    case title
    case user
    case login
    case created_at
    case closed_at
    case state
}
struct PR : Identifiable, Decodable {
    let id: Int
    let title : String?
    let user : User
    var created_at : String
    var closed_at : String?
    let state : String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decode(Int.self, forKey: .id)
        self.title = try values.decode(String.self, forKey: .title)
        self.user = try values.decode(User.self, forKey: .user)
        let createdAt = try values.decode(String.self, forKey: .created_at)
        self.created_at = formatDate(date: createdAt)
        let closedAt = try values.decodeIfPresent(String.self, forKey: .closed_at)
        self.closed_at = formatDate(date: closedAt ?? "")
        self.state = try values.decode(String.self, forKey: .state)
    }
}

func formatDate(date: String) -> String {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "MM dd yyyy"

    let date_ = dateFormatterGet.date(from: date)
    return dateFormatterPrint.string(from: date_ ?? Date())
}


