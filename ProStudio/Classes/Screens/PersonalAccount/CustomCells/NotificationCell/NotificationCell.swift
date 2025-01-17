import UIKit

class NotificationCell: UITableViewCell {
	
	@IBOutlet weak var notificationLabel: UILabel!
	@IBOutlet weak var switchControl: UISwitch!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		notificationSettings()
	}
	
	
	private func notificationSettings() {
		notificationLabel.text = "Push-уведомления"
		notificationLabel.textAlignment = .left
		notificationLabel.textColor = PSColor.textColor
		notificationLabel.font = PSFont.cellText
		
		switchControl.tintColor = PSColor.cerulean
		switchControl.onTintColor = PSColor.cerulean
	}
	
}

