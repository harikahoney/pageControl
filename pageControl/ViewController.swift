//
//  ViewController.swift
//  pageControl
//
//  Created by Sagi Harika on 09/12/19.
//  Copyright © 2019 Sagi Harika. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController,UIScrollViewDelegate
{

    
    
   
    
   
    @IBOutlet weak var selectSC: UISegmentedControl!
    
    @IBOutlet weak var refreshBtn: UIButton!
    
    
    
    var movieTitle = [String]()
    
    var stories = [String]()
    
    var images = [UIImage]()
    let scrollView = UIScrollView()
     var videoUrl = [String]()
    
    @IBOutlet weak var pageControlObj: UIPageControl!
    
    
    
    //Fetched Data
    var allAudioUrl = [[String]]()
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        setupUI()
        
        
//        titleLabel.text! = movieTitle[0]
//
//        storyTextView.text! = stories[0]
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(timerEH), userInfo: nil, repeats: true)
        
        
        
        
    }
    
    
    @IBAction func audioBtn(_ sender: Any)
    {
           
        for i in 0...allAudioUrl[pageControlObj.currentPage].count-1
        {
           
            print("No Of Songs In Selected Movie: ", allAudioUrl[pageControlObj.currentPage].count)
            MovieDetails.movie.selectedAudio.append(generateAVPlayerObjectsFromUrlInString(urlInString: configureUrl(urlInString: allAudioUrl[pageControlObj.currentPage][i])))
            
            print("Fetching Audio No: ", i+1)
        }
        
       
           
       }
    
    @IBAction func refreshBtn(_ sender: Any) {
 refreshBtn.addTarget(self, action: #selector(setupUI), for: UIControl.Event.touchUpInside)
         
    }
    
    
    @objc func timerEH()
    {
        print(pageControlObj.currentPage)
        
        
        
        
        
        if(pageControlObj.currentPage != images.count-1)
        {
            
            pageControlObj.currentPage += 1
            
            
        }
        else
        {
            pageControlObj.currentPage = 0
        }
        
        scrollView.contentOffset.x = CGFloat(pageControlObj.currentPage * Int(scrollView.frame.width))
        
//
//        titleLabel.text! = movieTitle[pageControlObj.currentPage]
//
//        storyTextView.text! = stories[pageControlObj.currentPage]
//
    }
    
    
   @objc func setupUI()
    {
        //Page Control
       
        pageControlObj.addTarget(self, action: #selector(pageControlEH), for: UIControl.Event.valueChanged)
        
        
        
        
        
        
        //Scroll View
        scrollView.delegate = self
        scrollView.frame = CGRect(x: 0, y: 50, width: view.frame.width, height: 300)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        view.addSubview(self.scrollView)
        
        
        //Fetch Json
        
        let jsonData = fetchJson()
        
        for x in jsonData
        {
            
            let configuredUrlInString = configureUrl(urlInString: x.posters![0])
            
            self.images.append(fetchImage(urlInString: configuredUrlInString))
            
            movieTitle.append(x.title!)
            
            stories.append(x.story ?? "NOT AVAILABLE")
            
            
            
            allAudioUrl.append(x.songs!)
        }
        
        print("No Of Images: ", images.count)
        pageControlObj.numberOfPages = images.count
        
        //Image Views
        
        var i = 0
        for x in images
        {
            let imageView = UIImageView()
            
            imageView.frame = CGRect(x: CGFloat(i) * self.scrollView.frame.width , y: 50, width: scrollView.frame.width, height: scrollView.bounds.height)
            
            
            
           imageView.image = x
            
            scrollView.addSubview(imageView)
            
            
            i += 1
        }
        
        scrollView.contentSize = CGSize(width: scrollView.bounds.width * CGFloat(i), height: scrollView.frame.height)
    }
    
    @objc func pageControlEH()
    {
        
        
        scrollView.contentOffset.x = CGFloat(pageControlObj.currentPage) * scrollView.frame.width
        scrollView.contentOffset.y = 50
        
        
         
    }
    @objc func watchTrailerButtonEH()
       {
           let viewController = AVPlayerViewController()
           
           viewController.player = MovieDetails.movie.video
           
           self.present(viewController, animated: true, completion: nil)
       }
       
    @objc func selectedIndex(_selectSC: UISegmentedControl)
    {
        if(selectSC.selectedSegmentIndex==0)
       {
        
         func fetchVideo(urlInString:String) -> AVPlayer
           {
              return AVPlayer(url: URL(string: urlInString)!)
           }

             MovieDetails.movie.video = fetchVideo(urlInString: videoUrl[MovieDetails.movie.selectedbutton!])

        selectSC.addTarget(self, action: #selector(watchTrailerButtonEH), for: UIControl.Event.touchUpInside)
         selectSC.addSubview(selectSC)
     
        
        
        }
        if(selectSC.selectedSegmentIndex==1)
        {
            
        }
        if(selectSC.selectedSegmentIndex==2)
        {
            
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {


        pageControlObj.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
    
    func fetchJson() -> [MovieDetailsStruct]
    {
        
        var convertedData:[MovieDetailsStruct]?
        
        let dataTaskObj=URLSession.shared.dataTask(with: URL(string: "https://www.brninfotech.com/tws/MovieDetails2.php?mediaType=movies")!){(data,connDetails,err) in
            
            
            do
            {
                convertedData = try JSONDecoder().decode([MovieDetailsStruct].self, from: data!)
                
            }
            catch
            {
                print("Failed")
            }
            
            
            
        }
        dataTaskObj.resume()
        
        while convertedData == nil
        {
            
        }
        
        
        return convertedData!
    }
    
    //fetches the image
    func fetchImage(urlInString:String) -> UIImage
    {
        
        let url = URL(string: urlInString)!
        var image:UIImage!
        do
        {
            
            
            let imageInFormOfData = try Data(contentsOf: url)
            
            image = UIImage(data: imageInFormOfData)
            
        }
        catch
        {
            print("Failed To Get Image")
        }
        
        return image
    }
    
    
    
    
    
    //Configures The Url
    func configureUrl(urlInString:String) -> String
    {
        var tempUrl = urlInString
        
        tempUrl = "https://www.brninfotech.com/tws/" + tempUrl
        
        tempUrl = tempUrl.replacingOccurrences(of: " ", with: "%20")
        
        return tempUrl
        
    }
    func generateAVPlayerObjectsFromUrlInString(urlInString:String) -> AVPlayer
       {
           return AVPlayer(url: URL(string: configureUrl(urlInString: urlInString))!)
       }
    
   
       
    
    }
        
        
    
    
    
    
    
    
    




