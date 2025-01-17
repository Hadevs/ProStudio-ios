//
//  PSCircularVIew.swift
//  circular-view
//
//  Created by Danil Detkin on 07/07/2018.
//  Copyright © 2018 DL. All rights reserved.
//

import UIKit


@IBDesignable
final class PSCircularView: UIView {
	
	lazy var label: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = PSColors.textColorOff
		label.text = "65%"
		label.textAlignment = .center
		label.font = PSFont.introBold.with(size: 42)
		return label
	}()
	
	lazy var checkmark: UIImageView = {
		let i = UIImageView()
		i.image = UIImage(named: "checkmark")
		i.translatesAutoresizingMaskIntoConstraints = false
		i.contentMode = .scaleAspectFit
		return i
	}()
	
	private lazy var circleView: UIView = {
		let circleView = UIView()
		circleView.translatesAutoresizingMaskIntoConstraints = false
		return circleView
	}()
	
	
	private let progressView: UIProgressView = {
		let progress = UIProgressView()
		return progress
	}()
	
	@IBInspectable var lineWidth: CGFloat = 25 {
		didSet {
			updateLineWidths()
		}
	}
	
	@IBInspectable var backLineWidth: CGFloat = 25 {
		didSet {
			updateLineWidths()
		}
	}
	
	var project: Project!
	
	convenience init(project: Project) {
		self.init()
		self.project = project
	}
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		addCircleView()
		addLabel()
		addCheckmark()
	}
	private let shape = CAShapeLayer()
	private func updateLineWidths() {
		//        circleLayerGradientMask.lineWidth = lineWidth
		shape.lineWidth = lineWidth
	}
	
	func animate(with value: CGFloat, duration: TimeInterval = 2) {
		
		var endValue = value
		if endValue > 1 {
			endValue = 1
		}
		
		label.text = "\(Int(endValue * 100))%"
		if value > 0 {
			shape.strokeColor = PSColors.staticCircleLayerColorOn.cgColor
			shape.lineWidth = lineWidth
			//            label.applyGradientWith(startColor: PSColors.textColorFrom, endColor: PSColors.textColorTo)
		}
		
		let progress: CABasicAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
		
		progress.duration = duration
		progress.fromValue = 0
		progress.toValue = endValue
		progress.fillMode = CAMediaTimingFillMode.forwards
		progress.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeOut)
		progress.isRemovedOnCompletion = false
		shape.add(progress, forKey: "strokeEnd")
	}
	
    
	var isLayouted = false
	override func layoutSubviews() {
		super.layoutSubviews()
		
		if !isLayouted {
			isLayouted = true
			addLayersForCircleView()
		}
		
	}
	
	private func addLabel() {
		
		addSubview(label)
		
//		let constraints: [NSLayoutConstraint] = {
//			return NSLayoutConstraint.contraints(withNewVisualFormat: "H:|[label]|,V:|[label]|", dict: ["label": label])
//		}()
		let constraints = [
			label.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
			label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 3),
		]
		addConstraints(constraints)
	}
	
	private func addCheckmark() {
		addSubview(checkmark)
		let size = 35
		let horPadding = 0
		let verPadding = 15
		let constraints = NSLayoutConstraint.contraints(withNewVisualFormat: "H:[checkmark(\(size))]-(\(horPadding))-|,V:|-(\(verPadding))-[checkmark(\(size))]", dict: ["checkmark": checkmark])
		addConstraints(constraints)
	}
	
	private func addCircleView() {
		addSubview(circleView)
		let constraints: [NSLayoutConstraint] = {
			return NSLayoutConstraint.contraints(withNewVisualFormat: "H:|[circleView]|,V:|[circleView]|", dict: ["circleView": circleView])
		}()
		
		addConstraints(constraints)
	}
	
	private func addLayersForCircleView() {
		let scale: CGFloat = 0.8
//		let delta = bounds.height - bounds.height * scale
//		let ovalIn = CGRect(x: bounds.origin.x + delta / 2, y: bounds.origin.y + delta / 2, width: bounds.width * scale, height: bounds.height * scale)
		let path = UIBezierPath(arcCenter: CGPoint.init(x: bounds.width / 2, y: bounds.height / 2),
														radius: bounds.width*scale / 2 - backLineWidth/2 - 22,
														startAngle: CGFloat(Double.pi / 2 * -1),
														endAngle: CGFloat(Double.pi / 2 * -1 + Double.pi * 2),
														clockwise: true)
		
		let whitePath = UIBezierPath(arcCenter: CGPoint.init(x: bounds.width / 2, y: bounds.height / 2),
																 radius: bounds.width*scale / 2 - backLineWidth - 22,
																 startAngle: CGFloat(Double.pi / 2 * -1),
																 endAngle: CGFloat(Double.pi / 2 * -1 + Double.pi * 2),
																 clockwise: true)
		
		shape.fillColor = UIColor.clear.cgColor
		shape.lineWidth = backLineWidth
		shape.lineCap = .round
		shape.strokeStart = 0
		shape.strokeEnd = 1
		shape.path = path.cgPath
		shape.position = circleView.center
		shape.shadowOpacity = 0.8
		shape.shadowOffset = CGSize.zero
		shape.shadowRadius = 10
		
		
		layer.addSublayer(shape)
		
		
		let staticShape = CAShapeLayer()
		staticShape.fillColor = UIColor.white.cgColor
		
//		staticShape.strokeColor = project.gradientsColor[1].withAlphaComponent(0.1).cgColor
		staticShape.strokeColor = PSColor.progressStaticShape.cgColor
		staticShape.lineWidth = backLineWidth
		staticShape.lineCap = .round
		staticShape.path = path.cgPath
		staticShape.position = circleView.center
		layer.addSublayer(staticShape)
	
		let lineGradient = CAGradientLayer()
		var vo = bounds
		lineGradient.frame = vo
		lineGradient.colors = project.gradientsColor.map{$0.cgColor}
		lineGradient.startPoint = CGPoint(x: 0, y: 0)
		lineGradient.endPoint = CGPoint(x: 1, y: 1)
		lineGradient.mask = shape
		layer.addSublayer(lineGradient)
		
		let whiteLayer = CAShapeLayer()
		whiteLayer.fillColor = UIColor.white.cgColor
		whiteLayer.path = whitePath.cgPath
		whiteLayer.position = circleView.center
		layer.addSublayer(whiteLayer)
	}
}
