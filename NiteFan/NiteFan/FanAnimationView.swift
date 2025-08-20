//
//  FanAnimationView.swift
//  NiteFan
//
//  Custom animated fan view using Core Animation
//

import UIKit

class FanAnimationView: UIView {
    
    // MARK: - Properties
    private var fanImageView: UIImageView!
    private var rotationAnimation: CABasicAnimation?
    private var isAnimating = false
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Setup
    private func setupView() {
        // Create fan image view
        fanImageView = UIImageView()
        fanImageView.contentMode = .scaleAspectFit
        fanImageView.tintColor = .nfPrimaryText
        fanImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Use SF Symbol for fan
        let config = UIImage.SymbolConfiguration(pointSize: 60, weight: .light)
        fanImageView.image = UIImage(systemName: "fan", withConfiguration: config)
        
        addSubview(fanImageView)
        
        NSLayoutConstraint.activate([
            fanImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            fanImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            fanImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            fanImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8)
        ])
        
        // Add subtle shadow
        layer.shadowColor = UIColor.nfAccent.cgColor
        layer.shadowRadius = 0
        layer.shadowOpacity = 0
        layer.shadowOffset = .zero
    }
    
    // MARK: - Animation Control
    func startAnimating(speed: Double = 1.0) {
        guard !isAnimating else { return }
        isAnimating = true
        
        // Create rotation animation
        rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation?.fromValue = 0
        rotationAnimation?.toValue = Double.pi * 2
        rotationAnimation?.duration = 2.0 / speed
        rotationAnimation?.repeatCount = .infinity
        rotationAnimation?.isRemovedOnCompletion = false
        
        // Add animation with ease-in-out timing
        CATransaction.begin()
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: .linear))
        fanImageView.layer.add(rotationAnimation!, forKey: "rotation")
        CATransaction.commit()
        
        // Animate shadow appearance
        UIView.animate(withDuration: 0.5) {
            self.layer.shadowRadius = 15
            self.layer.shadowOpacity = 0.3
        }
        
        // Scale up slightly
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5) {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }
    }
    
    func stopAnimating() {
        guard isAnimating else { return }
        isAnimating = false
        
        // Remove rotation animation
        fanImageView.layer.removeAnimation(forKey: "rotation")
        
        // Animate shadow disappearance
        UIView.animate(withDuration: 0.5) {
            self.layer.shadowRadius = 0
            self.layer.shadowOpacity = 0
        }
        
        // Scale back to normal
        UIView.animate(withDuration: 0.3) {
            self.transform = .identity
        }
    }
    
    func setSpeed(_ speed: Double) {
        if isAnimating {
            stopAnimating()
            startAnimating(speed: speed)
        }
    }
    
    // MARK: - Appearance Updates
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            fanImageView.tintColor = .nfPrimaryText
            layer.shadowColor = UIColor.nfAccent.cgColor
        }
    }
}