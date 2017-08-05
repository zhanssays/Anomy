//
//  Weight.swift
//  Anamyn
//
//  Created by Zhansaya Sikhymbekova on 8/4/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

import ObjectMapper
import FirebaseAuth
import FirebaseDatabase

class Weight: Mappable{
    var id: String?
    var difference: String?
    var weight: String?
    var createdAt: Date?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        difference <- map["difference"]
        weight <- map["weight"]
        createdAt <- (map["createdAt"], DateTransform())
    }
    
    
    static func addWeight(with weight: String?,createdAt:Date?, completion: @escaping (Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid, let weight = weight, let createdAt = createdAt else { return }
        let refUsers = Database.database().reference().child("users")
        
        refUsers.child("\(uid)/weights").childByAutoId().setValue([
            "weight": weight,
            "createdAt": createdAt.timeIntervalSince1970
        ]) { error, ref in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    func remove(completion: @escaping (Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid, let id = id else { return }
        let refUsers = Database.database().reference().child("users")
        refUsers.child("\(uid)/weights/\(id)").removeValue { error, ref in
            completion(error)
        }
    }
    
    static func fetchWeight(handler: @escaping (Weight?) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let refUsers = Database.database().reference().child("users")
        refUsers.child("\(uid)/weights").observe(.childAdded, with: { snapshot in
            guard let dict = snapshot.value as? [String: Any] else { return }
            let weight = Weight(JSON: dict)
            weight?.id = snapshot.key
            handler(weight)
        }) { error in
            print(error.localizedDescription)
            //completion(nil)
        }
    }
    
    
    
}
