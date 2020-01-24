//
//  MovieDetails.swift
//  pageControl
//
//  Created by Sagi Harika on 10/12/19.
//  Copyright © 2019 Sagi Harika. All rights reserved.
//

import UIKit
import AVKit

class MovieDetails: NSObject
{
   
    static let movie = MovieDetails()
    
    var images = [UIImage]()
    
    var titles:[String]?
    
    var AVPlayerObjects = [AVPlayer]()
    
    var video = AVPlayer()
    
    var selectedAudio = [AVPlayer]()
    
    var stories = [String]()
    
    var movieTitle = [String]()
    
    var actors = [[String]]()
    
    
    
    var selectedbutton:Int?
    
    private override init()
    {
        super.init()
    }
    
}

