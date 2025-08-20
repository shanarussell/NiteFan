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
        fanImageView.tintColor = .white
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
        layer.shadowColor = UIColor.systemBlue.cgColor
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
        
        // Add animation with smooth timing
        CATransaction.begin()
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: .linear))
        fanImageView.layer.add(rotationAnimation!, forKey: "rotation")
        CATransaction.commit()
        
        // Animate tint color to show it's active
        UIView.animate(withDuration: 0.5) {
            self.fanImageView.tintColor = .systemBlue
            self.layer.shadowRadius = 20
            self.layer.shadowOpacity = 0.4
        }
        
        // Scale up slightly with spring animation
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5) {
            self.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        }
    }
    
    func stopAnimating() {
        guard isAnimating else { return }
        isAnimating = false
        
        // Remove rotation animation
        fanImageView.layer.removeAnimation(forKey: "rotation")
        
        // Animate back to original appearance
        UIView.animate(withDuration: 0.5) {
            self.fanImageView.tintColor = .white
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
    
}