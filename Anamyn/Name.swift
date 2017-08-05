//
//  Name.swift
//  Anamyn
//
//  Created by Nurdaulet Bolatov on 8/5/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

import ObjectMapper
import FirebaseAuth
import FirebaseDatabase

class Name: Mappable {

    var id: String?
    var name: String?
    var gender: String?

    required init?(map: Map) {}

    func mapping(map: Map) {
        name <- map["name"]
        gender <- map["gender"]
    }

    func like() {
        guard let uid = Auth.auth().currentUser?.uid, let id = id else { return }
        let refUsers = Database.database().reference().child("users")
        refUsers.child("\(uid)/likedNames/\(id)").setValue(true)
    }

    func dislike() {
        guard let uid = Auth.auth().currentUser?.uid, let id = id else { return }
        let refUsers = Database.database().reference().child("users")
        refUsers.child("\(uid)/likedNames/\(id)").removeValue()
    }

    static func fetchAllNames(completion: @escaping (Name?) -> Void) {
        let refNames = Database.database().reference().child("names")
        refNames.observe(.childAdded, with: { snapshot in
            guard let dict = snapshot.value as? [String: Any] else { return }
            let name = Name(JSON: dict)
            name?.id = snapshot.key
            completion(name)
        }) { error in
            print(error.localizedDescription)
            completion(nil)
        }
    }

    static func fetchLikedNames(completion: @escaping (Name?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let refUsers = Database.database().reference().child("users")
        let refNames = Database.database().reference().child("names")
        refUsers.child("\(uid)/likedNames").observe(.childAdded, with: { snapshot in
            refNames.child(snapshot.key).observeSingleEvent(of: .value, with: { snapshot in
                guard let dict = snapshot.value as? [String: Any] else { return }
                let name = Name(JSON: dict)
                name?.id = snapshot.key
                completion(name)
            }) { error in
                print(error.localizedDescription)
                completion(nil)
            }
        }) { error in
            print(error.localizedDescription)
            completion(nil)
        }
    }

}
