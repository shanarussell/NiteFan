//
//  ModernViewController.swift
//  NiteFan
//
//  Modern iOS UI implementation with SF Symbols, haptics, and animations
//

import UIKit
import AVFoundation

class ModernViewController: UIViewController {
    
    // MARK: - Properties
    private let hapticGenerator = UIImpactFeedbackGenerator(style: .light)
    private let selectionGenerator = UISelectionFeedbackGenerator()
    private var audioPlayers: [String: AVAudioPlayer] = [:]
    private var activeButtons: Set<UIButton> = []
    private var fanAnimationViews: [Int: FanAnimationView] = [:]
    
    // MARK: - UI Components
    private lazy var backgroundGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor(red: 0.05, green: 0.05, blue: 0.15, alpha: 1.0).cgColor,
            UIColor(red: 0.1, green: 0.1, blue: 0.25, alpha: 1.0).cgColor,
            UIColor(red: 0.05, green: 0.05, blue: 0.2, alpha: 1.0).cgColor
        ]
        gradient.locations = [0.0, 0.5, 1.0]
        return gradient
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "NiteFan"
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sweet dreams await"
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var fanStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var ambientStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var muteButton: UIButton = {
        let button = createControlButton(
            symbol: "speaker.slash.fill",
            title: "Mute All",
            color: .systemRed
        )
        button.addTarget(self, action: #selector(muteAllTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()
        setupUI()
        setupAudioSession()
        preloadAudioPlayers()
        prepareHaptics()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundGradient.frame = view.bounds
    }
    
    deinit {
        stopAllSounds()
        audioPlayers.removeAll()
    }
    
    // MARK: - Setup Methods
    private func setupGradientBackground() {
        view.layer.insertSublayer(backgroundGradient, at: 0)
        
        // Add subtle animated stars
        addFloatingStars()
    }
    
    private func setupUI() {
        // Add main components
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(fanStackView)
        view.addSubview(ambientStackView)
        view.addSubview(muteButton)
        
        // Create fan buttons
        for i in 1...4 {
            let fanButton = createFanButton(number: i)
            fanStackView.addArrangedSubview(fanButton)
        }
        
        // Create ambient sound buttons
        let rainButton = createAmbientButton(
            symbol: "cloud.rain.fill",
            title: "Rain",
            sound: "rain"
        )
        let clickButton = createAmbientButton(
            symbol: "metronome.fill",
            title: "Click",
            sound: "click"
        )
        let wobbleButton = createAmbientButton(
            symbol: "waveform",
            title: "Wobble",
            sound: "wobble"
        )
        
        ambientStackView.addArrangedSubview(rainButton)
        ambientStackView.addArrangedSubview(clickButton)
        ambientStackView.addArrangedSubview(wobbleButton)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            // Title
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Subtitle
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            // Fan Stack
            fanStackView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 40),
            fanStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fanStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            fanStackView.heightAnchor.constraint(equalToConstant: 320),
            
            // Ambient Stack
            ambientStackView.topAnchor.constraint(equalTo: fanStackView.bottomAnchor, constant: 24),
            ambientStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ambientStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ambientStackView.heightAnchor.constraint(equalToConstant: 80),
            
            // Mute Button
            muteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            muteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            muteButton.widthAnchor.constraint(equalToConstant: 200),
            muteButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    // MARK: - Button Creation
    private func createFanButton(number: Int) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        // Glass morphism effect
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.layer.cornerRadius = 16
        blurView.layer.masksToBounds = true
        
        // Create horizontal stack for fan animation and text
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isUserInteractionEnabled = false
        
        // Create fan animation view
        let fanAnimationView = FanAnimationView()
        fanAnimationView.translatesAutoresizingMaskIntoConstraints = false
        fanAnimationViews[number] = fanAnimationView
        
        // Create label for fan text
        let label = UILabel()
        label.text = "Fan \(number)"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        
        stackView.addArrangedSubview(fanAnimationView)
        stackView.addArrangedSubview(label)
        
        // Create invisible button overlay
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = number
        button.backgroundColor = .clear
        
        // Add subviews
        container.addSubview(blurView)
        container.addSubview(stackView)
        container.addSubview(button)
        
        // Add action
        button.addTarget(self, action: #selector(fanButtonTapped(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            // Blur view fills container
            blurView.topAnchor.constraint(equalTo: container.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            // Stack view centered in container
            stackView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            // Fan animation size
            fanAnimationView.widthAnchor.constraint(equalToConstant: 60),
            fanAnimationView.heightAnchor.constraint(equalToConstant: 60),
            
            // Button overlay fills container
            button.topAnchor.constraint(equalTo: container.topAnchor),
            button.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        return container
    }
    
    private func createAmbientButton(symbol: String, title: String, sound: String) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: symbol)
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        config.imagePlacement = .top
        config.imagePadding = 4
        config.title = title
        config.baseBackgroundColor = UIColor.systemIndigo.withAlphaComponent(0.3)
        config.baseForegroundColor = .white
        config.cornerStyle = .large
        
        button.configuration = config
        button.accessibilityIdentifier = sound
        button.addTarget(self, action: #selector(ambientButtonTapped(_:)), for: .touchUpInside)
        
        return button
    }
    
    private func createControlButton(symbol: String, title: String, color: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: symbol)
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        config.imagePlacement = .leading
        config.imagePadding = 8
        config.title = title
        config.baseBackgroundColor = color.withAlphaComponent(0.2)
        config.baseForegroundColor = color
        config.cornerStyle = .large
        
        button.configuration = config
        return button
    }
    
    // MARK: - Actions
    @objc private func fanButtonTapped(_ sender: UIButton) {
        let fanNumber = sender.tag
        let soundName = "fan\(fanNumber)"
        
        hapticGenerator.impactOccurred()
        
        // Get the container view (parent of the button)
        let containerView = sender.superview
        
        // Get the fan animation view
        let fanAnimationView = fanAnimationViews[fanNumber]
        
        if activeButtons.contains(sender) {
            // Stop sound and animation
            stopSound(named: soundName)
            fanAnimationView?.stopAnimating()
            animateButtonDeactivation(sender, container: containerView)
            activeButtons.remove(sender)
        } else {
            // Start sound and animation
            playSound(named: soundName)
            fanAnimationView?.startAnimating(speed: Double(fanNumber) * 0.5 + 0.5) // Vary speed by fan number
            animateButtonActivation(sender, container: containerView)
            activeButtons.insert(sender)
        }
    }
    
    @objc private func ambientButtonTapped(_ sender: UIButton) {
        guard let soundName = sender.accessibilityIdentifier else { return }
        
        selectionGenerator.selectionChanged()
        
        if activeButtons.contains(sender) {
            stopSound(named: soundName)
            animateButtonDeactivation(sender)
            activeButtons.remove(sender)
        } else {
            playSound(named: soundName)
            animateButtonActivation(sender)
            activeButtons.insert(sender)
        }
    }
    
    @objc private func muteAllTapped() {
        let notificationGenerator = UINotificationFeedbackGenerator()
        notificationGenerator.notificationOccurred(.warning)
        
        stopAllSounds()
        
        // Stop all fan animations
        fanAnimationViews.values.forEach { $0.stopAnimating() }
        
        // Deactivate all buttons
        activeButtons.forEach { button in
            let container = button.superview
            animateButtonDeactivation(button, container: container)
        }
        activeButtons.removeAll()
        
        // Pulse animation for mute button
        UIView.animate(withDuration: 0.2, animations: {
            self.muteButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.muteButton.transform = .identity
            }
        }
    }
    
    // MARK: - Animations
    private func animateButtonActivation(_ button: UIButton, container: UIView? = nil) {
        let viewToAnimate = container ?? button
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5) {
            viewToAnimate.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            viewToAnimate.alpha = 1.0
        }
        
        // Add glow effect
        viewToAnimate.layer.shadowColor = UIColor.systemBlue.cgColor
        viewToAnimate.layer.shadowRadius = 8
        viewToAnimate.layer.shadowOpacity = 0.5
        viewToAnimate.layer.shadowOffset = .zero
        
        // Update button appearance
        if var config = button.configuration {
            config.baseBackgroundColor = UIColor.systemBlue.withAlphaComponent(0.4)
            button.configuration = config
        }
    }
    
    private func animateButtonDeactivation(_ button: UIButton, container: UIView? = nil) {
        let viewToAnimate = container ?? button
        
        UIView.animate(withDuration: 0.3) {
            viewToAnimate.transform = .identity
            viewToAnimate.alpha = 0.8
        }
        
        // Remove glow effect
        viewToAnimate.layer.shadowOpacity = 0
        
        // Reset button appearance
        if var config = button.configuration {
            if button.accessibilityIdentifier != nil {
                config.baseBackgroundColor = UIColor.systemIndigo.withAlphaComponent(0.3)
            } else {
                config.baseBackgroundColor = nil
            }
            button.configuration = config
        }
    }
    
    private func addFloatingStars() {
        for _ in 0..<20 {
            let star = UIView()
            star.backgroundColor = .white
            star.alpha = CGFloat.random(in: 0.1...0.3)
            let size = CGFloat.random(in: 1...3)
            star.frame = CGRect(x: 0, y: 0, width: size, height: size)
            star.layer.cornerRadius = size / 2
            
            let x = CGFloat.random(in: 0...view.bounds.width)
            let y = CGFloat.random(in: 0...view.bounds.height)
            star.center = CGPoint(x: x, y: y)
            
            view.insertSubview(star, at: 1)
            
            // Subtle twinkling animation
            UIView.animate(withDuration: Double.random(in: 2...5),
                          delay: Double.random(in: 0...2),
                          options: [.autoreverse, .repeat],
                          animations: {
                star.alpha = CGFloat.random(in: 0.3...0.6)
            })
        }
    }
    
    // MARK: - Audio Management
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to setup audio session: \(error.localizedDescription)")
        }
    }
    
    private func preloadAudioPlayers() {
        let audioFiles = [
            ("fan1", "mp3"), ("fan2", "mp3"), ("fan3", "mp3"), ("fan4", "mp3"),
            ("click", "m4r"), ("rain", "m4r"), ("wobble", "m4r")
        ]
        
        for (filename, ext) in audioFiles {
            loadAudioPlayer(named: filename, ofType: ext)
        }
    }
    
    private func loadAudioPlayer(named filename: String, ofType ext: String) {
        guard let path = Bundle.main.path(forResource: filename, ofType: ext) else { return }
        
        do {
            let player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            player.numberOfLoops = -1
            player.prepareToPlay()
            player.volume = 0
            audioPlayers[filename] = player
        } catch {
            print("Failed to load audio: \(filename)")
        }
    }
    
    private func playSound(named soundName: String) {
        guard let player = audioPlayers[soundName] else { return }
        
        if !player.isPlaying {
            player.play()
            // Fade in
            player.setVolume(1.0, fadeDuration: 0.5)
        }
    }
    
    private func stopSound(named soundName: String) {
        guard let player = audioPlayers[soundName] else { return }
        
        if player.isPlaying {
            // Fade out
            player.setVolume(0, fadeDuration: 0.5)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                player.stop()
                player.currentTime = 0
            }
        }
    }
    
    private func stopAllSounds() {
        audioPlayers.values.forEach { player in
            if player.isPlaying {
                player.setVolume(0, fadeDuration: 0.3)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    player.stop()
                    player.currentTime = 0
                }
            }
        }
    }
    
    private func prepareHaptics() {
        hapticGenerator.prepare()
        selectionGenerator.prepare()
    }
}