//
//  UiGridViewController.swift
//  PopularMoviesProject
//
//  Created by jets on 7/23/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage


private let reuseIdentifier = "Cell"
let Poster_URL = "https://image.tmdb.org/t/p/w500"

class UiGridViewController: UICollectionViewController {
    
    @IBOutlet var myCollectionView: UICollectionView!
    var moviesArray:Array<Movie> = []
    var responseFoods:[[String: Any]]=[]
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fwidth = (view.frame.size.width-2)/2
        let layout = myCollectionView.collectionViewLayout as! UICollectionViewFlowLayout

        layout.itemSize = CGSize(width: fwidth, height: fwidth)
               self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        navigationController?.navigationBar.backItem?.backBarButtonItem?.tintColor = UIColor.black
        
        DispatchQueue.main.async {
            Alamofire.request("https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=f9fff5cdf61663858e62cf2282fbf0f2").responseJSON { (response) in
                if let responseValue = response.result.value as! [String: Any]? {
                    self.responseFoods = responseValue["results"] as! [[String: Any]]
                    for item in self.responseFoods{
                        
                        let movie1  = Movie()
                        movie1.title=item["title"] as! String
                        movie1.overview=item["overview"] as! String
                        let imageURL = item["poster_path"] as? String
                        movie1.image = Poster_URL + imageURL!
                        movie1.rating=item["vote_average"]! as! Double
                        movie1.popularity=item["popularity"]! as! Double

                        movie1.releaseYear=item["release_date"] as! String

                        movie1.genre = ["1" , "2 "]
                       movie1.MovieID = item["id"] as! Int
                        self.moviesArray.append(movie1)
                        self.collectionView?.reloadData()
                        
                    }
                    
                    
                    
                }
                
            }
        }


       
    }


 
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return responseFoods.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> ImageCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as! ImageCollectionViewCell
    
        // Configure the cell
        cell.imageGrid.sd_setImage(with: URL(string: moviesArray[indexPath.item].image), placeholderImage: UIImage(named: "placeholder.png"))
        
        
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let details : DetailsViewController = storyboard?.instantiateViewController(withIdentifier: "detailsVC") as! DetailsViewController
      details.movie = moviesArray[indexPath.item]
        
        
        print(moviesArray[indexPath.item].releaseYear)
        print(moviesArray[indexPath.item].rating)
        self.navigationController?.pushViewController(details, animated: true)
    }
    
    

}
