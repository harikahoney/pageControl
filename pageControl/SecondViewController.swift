//
//  SecondViewController.swift
//  pageControl
//
//  Created by Sagi Harika on 11/12/19.
//  Copyright © 2019 Sagi Harika. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController
{
    
  
       
    @IBOutlet weak var stackView: UIStackView!
    
  
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
          setupUI()

    }
    
    
    
    func setupUI()
    {
        
    let backButton = UIButton()
        backButton.backgroundColor = UIColor.blue
        backButton.setTitle("Back", for: UIControl.State.normal)
        stackView.addArrangedSubview(backButton)
        
        

   var i = 0
   for x in MovieDetails.movie.selectedAudio
   {
       let label = UILabel()
       label.layer.cornerRadius = 10
       label.text = "Song No \(i + 1)"
       label.backgroundColor = .black
       label.textAlignment = .left
       label.textColor = UIColor.white
       stackView.addArrangedSubview(label)
       
       
       
       label.translatesAutoresizingMaskIntoConstraints = false
       label.heightAnchor.constraint(equalToConstant: 40).isActive = true
       
       
       
       
       let playAndPauseButton = UIButton()
       playAndPauseButton.backgroundColor = .blue
       playAndPauseButton.setTitle("Play", for: UIControl.State.normal)
       playAndPauseButton.layer.cornerRadius = 10
       playAndPauseButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
       playAndPauseButton.addTarget(self, action: #selector(playAndPauseButtonEH(button:)), for: UIControl.Event.touchUpInside)
       playAndPauseButton.tag = i
    stackView.addSubview(playAndPauseButton)
//       playPauseButtonState.append(ButtonState.OFF)
//       i += 1
//       contentView.addSubview(playAndPauseButton)


       playAndPauseButton.translatesAutoresizingMaskIntoConstraints = false
       playAndPauseButton.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: -2.5).isActive = true
       playAndPauseButton.centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true
       playAndPauseButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
       playAndPauseButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
       
   }
   
   if(MovieDetails.movie.selectedAudio.count == 0)
   {
       let label = UILabel()
       label.layer.cornerRadius = 10
       label.text = "SONGS NOT AVAILABLE"
       label.backgroundColor = .white
       label.textAlignment = .center
       label.textColor = UIColor.black
       stackView.addArrangedSubview(label)
       
       
       
       label.translatesAutoresizingMaskIntoConstraints = false
       label.heightAnchor.constraint(equalToConstant: 40).isActive = true
       
   }
        
    }
    
    
    @objc func playAndPauseButtonEH(button:UIButton)
    {
        
    }

}
