//
//  Response.swift
//  Formatori
//
//  Created by Dani Tox on 17/12/17.
//  Copyright © 2017 Dani Tox. All rights reserved.
//

import Foundation

class Response : Decodable {
    
    var code : String!
    var message : String!
    var formatore : Formatore?
    var verifiche : [Verifica]?
    
}
