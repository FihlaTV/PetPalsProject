//
//  Users.swift
//  PetPalsProject
//
//  Created by ADENIKE TOMOMEWO on 9/7/17.
//  Copyright © 2017 ADENIKE TOMOMEWO. All rights reserved.
//


class Users {
    var email: String?
    var fullname: String?
    var uid: String?
    var address: String?
    var city: String?
    var state: String?
    var zipcode: String?
    var urlto: String?
    var phoneNumber: String?
   

    init(uid: String?, fullname: String?, email: String?, address: String?, city: String?, state: String?, zipcode: String?, phoneNumber: String?){
        self.uid = uid;
        self.fullname = fullname;
        self.email = email;
        self.address = address;
        self.city = city;
        self.state = state;
        self.zipcode = zipcode;
        self.phoneNumber = phoneNumber;

        //self.urlto = urlto;
    }
}
