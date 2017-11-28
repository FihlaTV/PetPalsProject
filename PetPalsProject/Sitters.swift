//
//  Sitters.swift
//  PetPalsProject
//
//  Created by ADENIKE TOMOMEWO on 11/3/17.
//  Copyright © 2017 ADENIKE TOMOMEWO. All rights reserved.
//
import Foundation
import Firebase
import FirebaseDatabase

struct Sitters{
    var email: String?
    var fullname: String?
    var uid: String!
    var address: String?
    var city: String?
    var state: String?
    var zipcode: String?
    var phoneNumber: String?
    var sitter: String?
    var urlto: String?

    var ref: DatabaseReference?
    var key: String?
    
    init(snapshot: DataSnapshot){
         let value = snapshot.value as? NSDictionary
        key = snapshot.key
        ref = snapshot.ref
        fullname = value?["fullname"] as? String
        uid = value?["uid"] as? String
        email = value?["email"] as? String
        address = value?["street"] as? String
        city = value?["city"] as? String
        state = value?["state"] as? String
        zipcode = value?["zipCode"] as? String
        phoneNumber = value?["phoneNumber"] as? String
        sitter = value?["sitter"] as? String
        urlto = value?["urlToImage"] as? String
        
    }
    
    init(fullname: String, userId: String, photoUrl: String){
        self.fullname = fullname
        self.uid = userId
        self.urlto = photoUrl
    }
  }

