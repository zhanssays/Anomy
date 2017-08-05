//
//  Comment.swift
//  Anamyn
//
//  Created by Zhansaya Sikhymbekova on 7/29/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

import ObjectMapper
import FirebaseAuth
import FirebaseDatabase

class Comment: Mappable {
    
    var id: String?
    var text: String?
    var author: String?
    var post: String?
    var createdAt: Date?
    
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        text <- map["text"]
        author <- map["author"]
        post <- map["post"]
        createdAt <- (map["createdAt"], DateTransform())
    }
    
    func fetchAuthorName(completion: @escaping (String?) -> Void) {
        guard let uid = author else { return }
        let refUsers = Database.database().reference().child("users")
        refUsers.child("\(uid)/name").observeSingleEvent(of: .value, with: { snapshot in
            completion(snapshot.value as? String)
        }) { error in
            print(error.localizedDescription)
            completion(nil)
        }
    }
    
}
