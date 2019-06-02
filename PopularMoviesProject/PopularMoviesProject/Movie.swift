//
//  Movie.swift
//  PopularMoviesProject
//
//  Created by jets on 7/22/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

import Foundation

class Movie
{
    var MovieID : Int!
    var title : String = ""
    var image : String = ""
    var rating : Double = 0.0
    var popularity : Double = 0.0

    var releaseYear : String = ""
    var genre : [String] = []
    var VideoTrailers : [MovieTrailers] = []
    var Reviews : [MovieReview] = []
    
    
    
    
    var overview : String = ""
    
    
    
    //    subscript(index: Int)-> String
    //        {
    //        get {
    //            return genre[index];
    //        }
    //        set{
    //            self.genre[index]=newValue
    //        }
    //    }
}
