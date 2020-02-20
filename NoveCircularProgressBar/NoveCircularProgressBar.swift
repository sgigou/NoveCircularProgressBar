//
//  NoveCircularProgressBar.swift
//  NoveCircularProgressBar
//
//  Created by Steve Gigou on 20/02/2020.
//  Copyright © 2020 Novesoft. All rights reserved.
//

import UIKit

@IBDesignable public class NoveCircularProgressBar: UIView {
  
  @IBInspectable public var lineWidth: CGFloat = 2.0 {
    didSet {
      updateSize()
    }
  }
  @IBInspectable public var color: UIColor = .blue {
    didSet {
      updateColor()
    }
  }
  @IBInspectable public var speed: Double = 1.0
  
  public private(set) var progress: Double = 0.0
  
  private static let animationKey = "ProgressAnimation"
  
  private var circleLayer = CAShapeLayer()
  private var progressLayer = CAShapeLayer()
  
  // MARK: Life cycle
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
    createLayers()
  }
  
  required public init?(coder: NSCoder) {
    super.init(coder: coder)
    createLayers()
  }
  
  // MARK: Drawing
  
  private func createLayers() {
    progressLayer.strokeEnd = 0
    updateColor()
    updateSize()
    layer.addSublayer(circleLayer)
    layer.addSublayer(progressLayer)
  }
  
  private func updateSize() {
    let radius = min(frame.size.width / 2, frame.size.height / 2)
    let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: radius - lineWidth / 2, startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
    let progressRadius = radius - 2 * lineWidth
    let progressPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: progressRadius / 2, startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
    circleLayer.path = circlePath.cgPath
    circleLayer.lineWidth = lineWidth
    progressLayer.path = progressPath.cgPath
    progressLayer.lineWidth = progressRadius
  }
  
  private func updateColor() {
    circleLayer.fillColor = UIColor.clear.cgColor
    circleLayer.strokeColor = color.cgColor
    progressLayer.fillColor = UIColor.clear.cgColor
    progressLayer.strokeColor = color.cgColor
  }
  
  // MARK: Animations
  
  public func updateProgress(to percentage: Double, animated: Bool) {
    if percentage == progress { return }
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    animation.fillMode = .both
    animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    animation.isRemovedOnCompletion = false
    let duration = animated ? calculateDuration(from: progress, to: percentage) : 0.0
    animation.duration = duration
    animation.fromValue = progress
    animation.toValue = percentage
    progressLayer.add(animation, forKey: NoveCircularProgressBar.animationKey)
    progress = percentage
  }
  
  private func calculateDuration(from: Double, to: Double) -> Double {
    return abs(from - to) * speed
  }

}
