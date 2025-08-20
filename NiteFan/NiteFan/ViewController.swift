//
//  ViewController.swift
//  NiteFan
//
//  Created by Shana Russell on 9/27/19.
//  Copyright © 2019 HiTechMom. All rights reserved.
//

import UIKit
import AVFoundation

var fan1: AVAudioPlayer?
var fan2: AVAudioPlayer?
var fan3: AVAudioPlayer?
var fan4: AVAudioPlayer?
var clickSound: AVAudioPlayer?
var rainSound: AVAudioPlayer?
var wobbleSound: AVAudioPlayer?




class ViewController: UIViewController {
    
    let backgroundImageView = UIImageView()


    @IBOutlet weak var fanButton1: UIButton!
    @IBOutlet weak var fanStopButton1: UIButton!
    @IBOutlet weak var fanButton2: UIButton!
    @IBOutlet weak var fanStopButton2: UIButton!
    @IBOutlet weak var fanButton3: UIButton!
    @IBOutlet weak var fanStopButton3: UIButton!
    @IBOutlet weak var fanButton4: UIButton!
    @IBOutlet weak var fanStopButton4: UIButton!
    
    @IBOutlet weak var muteButton: UIButton!
    @IBOutlet weak var clickButton: UIButton!
    @IBOutlet weak var rainButton: UIButton!
    @IBOutlet weak var wobbleButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!

    
    //fan1 button play
    @IBAction func playFan1(_ sender: Any) {
        //play sound
        let path = Bundle.main.path(forResource: "fan1", ofType:"mp3")!
        let url = URL(fileURLWithPath: path)

        do {
            fan1 = try AVAudioPlayer(contentsOf: url)
            fan1?.play()
            fan1?.numberOfLoops = -1
            imageView.startAnimating()
        } catch {
            // couldn't load file :(
        }
        //end play sound
    }
    
    //fan1 button stop
    @IBAction func stopFan1(_ sender: Any) {
        fan1?.stop()
        imageView.stopAnimating()
    }
    
    //fan2 button play
    @IBAction func playFan2(_ sender: Any) {
        //play sound
               let path = Bundle.main.path(forResource: "fan2", ofType:"mp3")!
        let url = URL(fileURLWithPath: path)

               do {
                   fan2 = try AVAudioPlayer(contentsOf: url)
                   fan2?.play()
                fan2?.numberOfLoops = -1
                imageView2.startAnimating()
               } catch {
                   // couldn't load file :(
               }
               //end play sound
    }
    
    //fan2 button stop
    @IBAction func stopFan2(_ sender: Any) {
        fan2?.stop()
        imageView2.stopAnimating()
    }
    
    //fan3 button play
    @IBAction func playFan3(_ sender: Any) {
            //play sound
            let path = Bundle.main.path(forResource: "fan3", ofType:"mp3")!
            let url = URL(fileURLWithPath: path)

            do {
                fan3 = try AVAudioPlayer(contentsOf: url)
                fan3?.play()
                fan3?.numberOfLoops = -1
                imageView3.startAnimating()
            } catch {
                // couldn't load file :(
            }
            //end play sound
        }
    //fan3 button stop
    @IBAction func stopFan3(_ sender: Any) {
        fan3?.stop()
        imageView3.stopAnimating()
    }
    //fan4 button play
    @IBAction func playFan4(_ sender: Any) {
        //play sound
        let path = Bundle.main.path(forResource: "fan4", ofType:"mp3")!
        let url = URL(fileURLWithPath: path)

        do {
            fan4 = try AVAudioPlayer(contentsOf: url)
            fan4?.play()
            fan4?.numberOfLoops = -1
            imageView4.startAnimating()
        } catch {
            // couldn't load file :(
        }
        //end play sound
    }
    
    //fan4 button stop
    @IBAction func stopFan4(_ sender: Any) {
        fan4?.stop()
        imageView4.stopAnimating()
    }
    
    
    
    //click button play
    @IBAction func clickButtonPlay(_ sender: Any) {
        //play sound
        let path = Bundle.main.path(forResource: "click", ofType:"m4r")!
        let url = URL(fileURLWithPath: path)

        do {
            clickSound = try AVAudioPlayer(contentsOf: url)
            clickSound?.play()
            clickSound?.numberOfLoops = -1
        } catch {
            // couldn't load file :(
        }
        //end play sound
    }
    
    //rain button play
    @IBAction func rainButtonPlay(_ sender: Any) {
        //play sound
        let path = Bundle.main.path(forResource: "rain", ofType:"m4r")!
        let url = URL(fileURLWithPath: path)

        do {
            rainSound = try AVAudioPlayer(contentsOf: url)
            rainSound?.play()
            rainSound?.numberOfLoops = -1
        } catch {
            // couldn't load file :(
        }
        //end play sound
    }
    
    //wobble button play
    @IBAction func wobbleButtonPlay(_ sender: Any) {
        //play sound
        let path = Bundle.main.path(forResource: "wobble", ofType:"m4r")!
        let url = URL(fileURLWithPath: path)

        do {
            wobbleSound = try AVAudioPlayer(contentsOf: url)
            wobbleSound?.play()
            wobbleSound?.numberOfLoops = -1
        } catch {
            // couldn't load file :(
        }
        //end play sound
    }
    
    //mute button play
    @IBAction func muteButton(_ sender: Any) {
        fan1?.stop()
        fan2?.stop()
        fan3?.stop()
        fan4?.stop()
        clickSound?.stop()
        rainSound?.stop()
        wobbleSound?.stop()
        imageView.stopAnimating()
        imageView2.stopAnimating()
        imageView3.stopAnimating()
        imageView4.stopAnimating()
        
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //background image
        setBackground()
        
        //background sound
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback)
        }
        catch {
            
        }
        
        //fan animation graphics for fan 1
        imageView.animationImages = [
            UIImage(named: "fan-graphic-2.png")!,
            UIImage(named: "fan-graphic-3.png")!,
            UIImage(named: "fan-graphic-4.png")!,
            UIImage(named: "fan-graphic-5.png")!,
            UIImage(named: "fan-graphic-6.png")!,
            UIImage(named: "fan-graphic-7.png")!
        ]
        
        //fan animation graphics for fan 2
        imageView2.animationImages = [
            UIImage(named: "fan-graphic-2.png")!,
            UIImage(named: "fan-graphic-3.png")!,
            UIImage(named: "fan-graphic-4.png")!,
            UIImage(named: "fan-graphic-5.png")!,
            UIImage(named: "fan-graphic-6.png")!,
            UIImage(named: "fan-graphic-7.png")!
        ]
        
        //fan animation graphics for fan 3
        imageView3.animationImages = [
            UIImage(named: "fan-graphic-2.png")!,
            UIImage(named: "fan-graphic-3.png")!,
            UIImage(named: "fan-graphic-4.png")!,
            UIImage(named: "fan-graphic-5.png")!,
            UIImage(named: "fan-graphic-6.png")!,
            UIImage(named: "fan-graphic-7.png")!
        ]
        
        //fan animation graphics for fan 4
        imageView4.animationImages = [
            UIImage(named: "fan-graphic-2.png")!,
            UIImage(named: "fan-graphic-3.png")!,
            UIImage(named: "fan-graphic-4.png")!,
            UIImage(named: "fan-graphic-5.png")!,
            UIImage(named: "fan-graphic-6.png")!,
            UIImage(named: "fan-graphic-7.png")!
        ]
        

    }
//background image
    func setBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.image = UIImage(named: "stars.jpg")
        view.sendSubviewToBack(backgroundImageView)
    }
//end background image
}


