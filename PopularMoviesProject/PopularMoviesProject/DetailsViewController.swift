//
//  DetailsViewController.swift
//  PopularMoviesProject
//
//  Created by jets on 7/22/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import CoreData

class DetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
  
    
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtRating: UILabel!
    
    @IBOutlet weak var btnFavorite: UIButton!
   
    @IBOutlet weak var txtReview: UILabel!
    @IBOutlet weak var tabelView: UITableView!
    var responseTrailers:[[String: Any]]=[]
    var responseReviews:[[String: Any]]=[]
var authors : [String] = []
    var review : [String] = []
    var isExist:Bool=false

    let coreDataCRUD:CoreDataCRUD = CoreDataCRUD()
    @IBAction func btnAddToFavorite(_ sender: Any) {
        
        if coreDataCRUD.isExist(id: movie) {
            coreDataCRUD.deleteData(movieId: movie.MovieID)
            let image = UIImage(named: "Star")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            btnFavorite.setImage(image, for: .normal)

        }
        else
        {
         coreDataCRUD.addTOFavourite(movie: movie)
            let image = UIImage(named: "Star-Fill")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            btnFavorite.setImage(image, for: .normal)

        }
        
       
        
    }
    
    
    
    
  
    
    
    @IBOutlet weak var txtDescription: UITextView!
    var movie:Movie!

    override func viewDidLoad() {
        super.viewDidLoad()

      isExist =  coreDataCRUD.isExist(id: movie)
        
        if(isExist){
            let image = UIImage(named: "Star-Fill")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            btnFavorite.setImage(image, for: .normal)
            
        }

        
        txtReview.text=""
        imgMovie.sd_setImage(with: URL(string: movie.image), placeholderImage: UIImage(named: "placeholder.png"))
        txtTitle.text = movie.title
        txtRating.text = String(movie.rating)+"/10"
        txtDescription.text=movie.overview
        
        let ID_of_URL = String(movie.MovieID)
        //let ReviewURL = Stri
        
        DispatchQueue.main.async {
            Alamofire.request("https://api.themoviedb.org/3/movie/"+ID_of_URL+"/videos?api_key=2f118a45da8d4c15298e63cbc09bce5a").responseJSON { (response) in
                if let responseValue = response.result.value as! [String: Any]? {
                    self.responseTrailers = responseValue["results"] as! [[String: Any]]
                    for item in self.responseTrailers{
                        let movieTrailer : MovieTrailers = MovieTrailers()
                        movieTrailer.key = item["key"] as? String
                        movieTrailer.name = item["name"] as? String
//                        print(item["key"] as! String)
                        self.movie.VideoTrailers.append(movieTrailer)
                        
                    }
                      self.tabelView?.reloadData()
                }
                
            }
            
            
            
        }
        
        Alamofire.request("https://api.themoviedb.org/3/movie/"+ID_of_URL+"/reviews?api_key=2f118a45da8d4c15298e63cbc09bce5a").responseJSON { (response) in
            if let responseValueReview = response.result.value as! [String: Any]? {
                self.responseReviews = responseValueReview["results"] as! [[String: Any]]
                for item in self.responseReviews{
                   //self.authors.append()
                    let reviews : MovieReview =  MovieReview()
                    
                    
                    reviews.author = item["author"] as! String
                    reviews.content = item["content"] as! String
                    self.movie.Reviews.append(reviews)
                    
                    
                  // movie.Reviews
                    
                    
                self.txtReview.text = self.txtReview.text!  + reviews.author! + " : " + reviews.content! + "\n"
                                                  }
            }
            
        }
        

        

        
    }
    

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return self.movie.VideoTrailers.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.detailTextLabel?.text = movie.VideoTrailers[indexPath.row].name

        
        cell.textLabel?.text = "Trailer \(indexPath.row+1)"
        // cell.MovieImage.sd_setImage(with: URL(string: moviesArray[indexPath.row].image), placeholderImage: UIImage(named: "placeholder.png"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
     print(movie.VideoTrailers[indexPath.row].key!)
        let youtubeURL = NSURL(string:"https://www.youtube.com/watch?v="+movie.VideoTrailers[indexPath.row].key!)
        if(UIApplication.shared.canOpenURL(youtubeURL as! URL)){
            UIApplication.shared.openURL(youtubeURL as! URL)
        }else{
            print("Cannot open youtube")
        }
        
    }



}
