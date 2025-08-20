//
//  ViewController.swift
//  NiteFan
//
//  Created by Shana Russell on 9/27/19.
//  Copyright © 2019 HiTechMom. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // MARK: - Properties
    let backgroundImageView = UIImageView()
    
    // Audio players dictionary to prevent memory leaks
    private var audioPlayers: [String: AVAudioPlayer] = [:]
    
    // MARK: - IBOutlets
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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupAudioSession()
        setupFanAnimations()
        preloadAudioPlayers()
    }
    
    deinit {
        // Clean up audio players
        stopAllSounds()
        audioPlayers.removeAll()
    }
    
    // MARK: - Setup Methods
    private func setupBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        backgroundImageView.image = UIImage(named: "stars.jpg")
        view.sendSubviewToBack(backgroundImageView)
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to setup audio session: \(error.localizedDescription)")
            showErrorAlert(title: "Audio Error", message: "Failed to setup audio. Please restart the app.")
        }
    }
    
    private func setupFanAnimations() {
        let animationImages = [
            UIImage(named: "fan-graphic-2.png"),
            UIImage(named: "fan-graphic-3.png"),
            UIImage(named: "fan-graphic-4.png"),
            UIImage(named: "fan-graphic-5.png"),
            UIImage(named: "fan-graphic-6.png"),
            UIImage(named: "fan-graphic-7.png")
        ].compactMap { $0 }
        
        [imageView, imageView2, imageView3, imageView4].forEach { imageView in
            imageView?.animationImages = animationImages
            imageView?.animationDuration = 0.5
        }
    }
    
    private func preloadAudioPlayers() {
        // Preload all audio files to prevent memory leaks from repeated initialization
        let audioFiles = [
            ("fan1", "mp3"),
            ("fan2", "mp3"),
            ("fan3", "mp3"),
            ("fan4", "mp3"),
            ("click", "m4r"),
            ("rain", "m4r"),
            ("wobble", "m4r")
        ]
        
        for (filename, ext) in audioFiles {
            loadAudioPlayer(named: filename, ofType: ext)
        }
    }
    
    // MARK: - Audio Management
    private func loadAudioPlayer(named filename: String, ofType ext: String) {
        guard let path = Bundle.main.path(forResource: filename, ofType: ext) else {
            print("Audio file not found: \(filename).\(ext)")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.numberOfLoops = -1 // Infinite loop
            player.prepareToPlay()
            audioPlayers[filename] = player
        } catch {
            print("Failed to load audio file \(filename).\(ext): \(error.localizedDescription)")
        }
    }
    
    private func playSound(named soundName: String, animateImageView: UIImageView? = nil) {
        guard let player = audioPlayers[soundName] else {
            print("Audio player not found for: \(soundName)")
            showErrorAlert(title: "Audio Error", message: "Unable to play \(soundName) sound.")
            return
        }
        
        if !player.isPlaying {
            player.play()
            animateImageView?.startAnimating()
        }
    }
    
    private func stopSound(named soundName: String, animateImageView: UIImageView? = nil) {
        audioPlayers[soundName]?.stop()
        audioPlayers[soundName]?.currentTime = 0
        animateImageView?.stopAnimating()
    }
    
    private func stopAllSounds() {
        audioPlayers.values.forEach { player in
            player.stop()
            player.currentTime = 0
        }
        [imageView, imageView2, imageView3, imageView4].forEach { $0?.stopAnimating() }
    }
    
    // MARK: - Fan Control Actions
    @IBAction func playFan1(_ sender: Any) {
        playSound(named: "fan1", animateImageView: imageView)
    }
    
    @IBAction func stopFan1(_ sender: Any) {
        stopSound(named: "fan1", animateImageView: imageView)
    }
    
    @IBAction func playFan2(_ sender: Any) {
        playSound(named: "fan2", animateImageView: imageView2)
    }
    
    @IBAction func stopFan2(_ sender: Any) {
        stopSound(named: "fan2", animateImageView: imageView2)
    }
    
    @IBAction func playFan3(_ sender: Any) {
        playSound(named: "fan3", animateImageView: imageView3)
    }
    
    @IBAction func stopFan3(_ sender: Any) {
        stopSound(named: "fan3", animateImageView: imageView3)
    }
    
    @IBAction func playFan4(_ sender: Any) {
        playSound(named: "fan4", animateImageView: imageView4)
    }
    
    @IBAction func stopFan4(_ sender: Any) {
        stopSound(named: "fan4", animateImageView: imageView4)
    }
    
    // MARK: - Sound Effect Actions
    @IBAction func clickButtonPlay(_ sender: Any) {
        playSound(named: "click")
    }
    
    @IBAction func rainButtonPlay(_ sender: Any) {
        playSound(named: "rain")
    }
    
    @IBAction func wobbleButtonPlay(_ sender: Any) {
        playSound(named: "wobble")
    }
    
    @IBAction func muteButton(_ sender: Any) {
        stopAllSounds()
    }
    
    // MARK: - Error Handling
    private func showErrorAlert(title: String, message: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
}