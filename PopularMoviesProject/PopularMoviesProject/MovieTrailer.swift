//
//  MovieTrailer.swift
//  PopularMoviesProject
//
//  Created by jets on 8/2/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

import Foundation

public class MovieTrailers : NSObject, NSCoding{
    
    var name : String?
    var key : String?
    
    
    public func encode(with aCoder: NSCoder){
        aCoder.encode(name, forKey: "name")
        aCoder.encode(key, forKey: "key")
       
    }
    
    public required init?(coder aDecoder: NSCoder){
        name = aDecoder.decodeObject(forKey: "name") as? String
        key = aDecoder.decodeObject(forKey: "key") as? String
       
    }
    override init() {
        
    }
    
}
