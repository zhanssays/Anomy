//
//  Photo.swift
//  Anamyn
//
//  Created by Nurdaulet Bolatov on 8/5/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class Photo {

    static func save(image: UIImage, at photoId: String, completion: @escaping (URL?, Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid, let data = UIImagePNGRepresentation(image) else { return }
        let storage = Storage.storage().reference()
        let _ = storage.child("\(uid)/\(photoId)").putData(data, metadata: nil) { metadata, error in
            if let error = error {
                completion(nil, error)
            } else if let url = metadata?.downloadURL() {
                completion(url, error)
            }
        }
    }

    static func fetch(photoId: String, completion: @escaping (URL?, Error?) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storage = Storage.storage().reference()
        storage.child("\(uid)/\(photoId)").downloadURL { url, error in
            completion(url, error)
        }
    }

}
