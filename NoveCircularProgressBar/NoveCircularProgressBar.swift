//
//  NoveCircularProgressBar.swift
//  NoveCircularProgressBar
//
//  Created by Steve Gigou on 20/02/2020.
//  Copyright © 2020 Novesoft. All rights reserved.
//

import UIKit

/**
 Progress bar using a circular design.
 */
@IBDesignable public class NoveCircularProgressBar: UIView {
  
  /// Line and space between border and progress bar width.
  @IBInspectable public var lineWidth: CGFloat = 2.0 {
    didSet {
      updateSize()
    }
  }
  /// Line and progress bar color.
  @IBInspectable public var color: UIColor = .black {
    didSet {
      updateColor()
    }
  }
  /// Number of seconds to animate from 0.0 to 1.0.
  @IBInspectable public var speed: Double = 1.0
  
  /// Indicates the current bar progress.
  public private(set) var progress: Double = 0.0
  
  /// Animation key allowing to cancel it.
  private static let animationKey = "ProgressAnimation"
  
  /// External border of the component.
  private var circleLayer = CAShapeLayer()
  /// Internal progress bar.
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
  
  /**
   Add layers.
   
   - Important: This should be called only once during the component life cycle.
   */
  private func createLayers() {
    progressLayer.strokeEnd = 0
    updateColor()
    updateSize()
    layer.addSublayer(circleLayer)
    layer.addSublayer(progressLayer)
  }
  
  /**
   Update the size of the layers.
   
   This function must be called when the frame has changed.
   */
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
  
  /**
   Update the color of all layers.
   */
  private func updateColor() {
    circleLayer.fillColor = UIColor.clear.cgColor
    circleLayer.strokeColor = color.cgColor
    progressLayer.fillColor = UIColor.clear.cgColor
    progressLayer.strokeColor = color.cgColor
  }
  
  // MARK: Animations
  
  /**
   Update the progress bar to display a new percentage.
   
   - parameter to: Percentage to reach.
   - parameter animated: Indicates if the progress bar should animate the transition.
   */
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
  
  /**
   Tells the animation duration to go from one percentage to another.
   
   - parameter from: Beginning percentage.
   - parameter to: Percentage to reach
   - returns: The duration of the animation based on the component’s speed.
   */
  private func calculateDuration(from: Double, to: Double) -> Double {
    return abs(from - to) * speed
  }

}
