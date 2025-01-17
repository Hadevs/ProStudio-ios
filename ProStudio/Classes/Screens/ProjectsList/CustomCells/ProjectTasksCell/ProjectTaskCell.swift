import UIKit
import Shift

class ProjectTaskCell: UITableViewCell {
	
	@IBOutlet weak var taskButton: PSScaleView!
	@IBOutlet weak var taskTitle: ShiftMaskableLabel!
	@IBOutlet weak var taskComment: ShiftMaskableLabel!
	@IBOutlet weak var okImage: UIImageView!
	
	var is99 = false
	var nowSelected: VoidClosure?
	var colorsForGradient: [UIColor] = [] {
		didSet {
			updateBorder()
		}
	}
	
	func updateBorder() { // это не бордер
		layer1.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: taskButton.frame.size.height)
		layer1.startPoint = CGPoint(x: 0, y: 0.5)
		layer1.endPoint = CGPoint(x: 1, y: 0.5)
		layer1.colors = [colorsForGradient[0].cgColor, colorsForGradient[1].cgColor]
		
		layer1.removeFromSuperlayer()
		taskButton.layer.insertSublayer(layer1, at: 0)
	}
	override func prepareForReuse() {
		super.prepareForReuse()
		updateBorder()
	}
	override func awakeFromNib() {
		super.awakeFromNib()
		taskTitle.textLabel.font = PSFont.introBold.with(size: 17.0)
		taskComment.textLabel.font = PSFont.introBook.with(size: 14.0)
		taskComment.backgroundColor = .clear
		taskTitle.backgroundColor = .clear
		taskButton.outed = {
			self.nowSelected?()
		}
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		taskButton.layer.cornerRadius = 10
		taskButton.layer.masksToBounds = true
		
	}
	
	var layouted = false
	var done = false
	let gradient = CAGradientLayer()
	let layer1 = CAGradientLayer()
	override func layoutSubviews() {
		super.layoutSubviews()
//		guard !layouted && !done else {
//			return
//		}
		
		layouted = true
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0) {
			self.taskButton.layer.cornerRadius = 10
			self.taskButton.clipsToBounds = true
			
			
			self.gradient.frame =  CGRect(origin: CGPoint.zero, size: self.taskButton.frame.size)
			self.gradient.colors = [self.colorsForGradient[1].cgColor, self.colorsForGradient[1].cgColor]
			
			let shape = CAShapeLayer()
			shape.lineWidth = 5
			
			shape.path = UIBezierPath(roundedRect: self.taskButton.bounds, cornerRadius: self.taskButton.layer.cornerRadius).cgPath
			
			shape.strokeColor = UIColor.black.cgColor
			shape.fillColor = UIColor.clear.cgColor
			self.gradient.mask = shape
			self.gradient.removeFromSuperlayer()
			self.taskButton.layer.addSublayer(self.gradient)
		}
	}
	
	func settingsCell(done: Bool, colors: [UIColor]) {
		layer1.colors = colors.map {$0.cgColor}
		colorsForGradient = colors
		self.done = done
		if done {
			layer1.isHidden = false
			gradient.isHidden = true
			okImage.image = UIImage(named: "subtraction6")
			taskTitle.setColors([UIColor.white, UIColor.white])
			taskTitle.start(shiftPoint: .left)
			taskTitle.end(shiftPoint: .right)
			taskTitle.animationDuration(3.0)
			taskTitle.maskToText = true
			taskTitle.startTimedAnimation()
			
			taskComment.setColors([.white, UIColor.white])
			taskComment.start(shiftPoint: .left)
			taskComment.end(shiftPoint: .right)
			taskComment.animationDuration(3.0)
			taskComment.maskToText = true
			taskComment.startTimedAnimation()
		} else {
			layer1.isHidden = true
			gradient.isHidden = false
			taskTitle.setColors(colors)
			taskTitle.start(shiftPoint: .left)
			taskTitle.end(shiftPoint: .right)
			taskTitle.animationDuration(100)
			taskTitle.maskToText = true
			taskTitle.startTimedAnimation()
			
			taskComment.setColors(colors)
			taskComment.start(shiftPoint: .left)
			taskComment.end(shiftPoint: .right)
			taskComment.animationDuration(100)
			taskComment.maskToText = true
			taskComment.startTimedAnimation()
			okImage.image = .none
		}
	}
}
