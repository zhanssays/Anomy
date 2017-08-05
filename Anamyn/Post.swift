//
//  Post.swift
//  Anamyn
//
//  Created by Zhansaya Sikhymbekova on 7/29/17.
//  Copyright © 2017 Zhansaya Sikhymbekova. All rights reserved.
//

import ObjectMapper
import FirebaseAuth
import FirebaseDatabase

class Post: Mappable {
    
    var id: String?
    var text: String?
    var author: String?
    var createdAt: Date?
    var comments: [String: Bool]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        text <- map["text"]
        author <- map["author"]
        comments <- map["comments"]
        createdAt <- (map["createdAt"], DateTransform())
    }
    
    static func fetchPosts(handler: @escaping (Post?) -> Void) {
        let refPosts = Database.database().reference().child("posts")
        refPosts.observe(.childAdded, with: { snapshot in
            guard let dict = snapshot.value as? [String: Any] else { return }
            let post = Post(JSON: dict)
            post?.id = snapshot.key
            handler(post)
        })
    }
    
    static func addPost(with text: String?, completion: @escaping (Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid, let text = text, !text.isEmpty else { return }
        let refPosts = Database.database().reference().child("posts")
        let refUsers = Database.database().reference().child("users")

        let key = refPosts.childByAutoId().key
        refPosts.child(key).setValue([
            "text": text,
            "author": uid,
            "createdAt": Date().timeIntervalSince1970
        ]) { error, ref in
            if let error = error {
                completion(error)
            } else {
                refUsers.child("\(uid)/posts/\(key)").setValue(true)
                completion(nil)
            }
        }
    }
    
    func fetchComments(handler: @escaping (Comment?) -> Void) {
        guard let postId = id, !postId.isEmpty else { return }
        let refPosts = Database.database().reference().child("posts")
        let refComments = Database.database().reference().child("comments")
        refPosts.child("\(postId)/comments").observe(.childAdded, with: { snapshot in
            refComments.child(snapshot.key).observeSingleEvent(of: .value, with: { snapshot in
                guard let dict = snapshot.value as? [String: Any] else { return }
                let comment = Comment(JSON: dict)
                comment?.id = snapshot.key
                handler(comment)
            })  
        })
    }
    
    func addComment(with text: String?, completion: @escaping (Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid, let text = text, let postId = id, !text.isEmpty, !postId.isEmpty else { return }
        let refPosts = Database.database().reference().child("posts")
        let refUsers = Database.database().reference().child("users")
        let refComments = Database.database().reference().child("comments")
        
        let key = refComments.childByAutoId().key
        refComments.child(key).setValue([
            "text": text,
            "author": uid,
            "post": postId,
            "createdAt": Date().timeIntervalSince1970
        ]) { error, ref in
            if let error = error {
                completion(error)
            } else {
                refUsers.child("\(uid)/comments/\(key)").setValue(true)
                refPosts.child("\(postId)/comments/\(key)").setValue(true)
                completion(nil)
            }
        }
    }
    
}
