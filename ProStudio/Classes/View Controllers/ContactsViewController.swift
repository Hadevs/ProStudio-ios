//
//  ContactsViewController.swift
//  ProStudio
//
//  Created by Danil Detkin on 03/11/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit
import MapKit

class ContactsViewController: UIViewController {
	@IBOutlet weak var segmentedControl: ContactsSegmentedControl!
	@IBOutlet weak var label1: UILabel!
	@IBOutlet weak var label2: UILabel!
	@IBOutlet weak var label3: UILabel!
	@IBOutlet weak var label0: UILabel!
	@IBOutlet weak var v1: UIView!
	@IBOutlet weak var v2: UIView!
	@IBOutlet weak var v3: UIView!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		NavigationBarDecorator.decorate(self)
//		navigationController?.navigationBar.barStyle = .black
		navigationItem.title = "Наши контакты"
		navigationItem.largeTitleDisplayMode = .always
		navigationController?.navigationBar.prefersLargeTitles = true
		segmentedControl.titles = ["Петербург", "Москва"]
		segmentedControl.images = [UIImage(named: "spb")!, UIImage(named: "msc")!]
		segmentedControl.font = PSFont.introBold.with(size: 16.0)
		segmentedControl.defaultColor = PSColor.coolGrey
		decorizeLabel1()
		decorizeLabel2()
		decorizeLabel3()
		label0.setLineSpacing(lineSpacing: 6)
		label0.textAlignment = .center
		segmentedControl.addTarget(self, action: #selector(changed(sender:)), for: .valueChanged)
		addGestures()
	}
	
	private func addGestures() {
		let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(v1Clicked))
		v1.addGestureRecognizer(tapGesture1)
		let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(v2Clicked))
		v2.addGestureRecognizer(tapGesture2)
		let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(v3Clicked))
		v3.addGestureRecognizer(tapGesture3)
	}

    @IBAction func besideClicked() {
        guard let number = URL(string: "https://www.behance.net/prostudioagency") else { return }
        UIApplication.shared.open(number)
    }

    @IBAction func youtubs() {
        guard let number = URL(string: "https://www.youtube.com/channel/UCFGwnwFihvgT2Q-E5B_It0Q") else { return }
        UIApplication.shared.open(number)
    }

    @IBAction func faceboook() {
        guard let number = URL(string: "https://www.facebook.com/prostudioagency") else { return }
        UIApplication.shared.open(number)
    }

    @IBAction func vkintakte() {
        guard let number = URL(string: "https://vk.com/prostudioagency") else { return }
        UIApplication.shared.open(number)
    }

    @IBAction func twClicked() {
        guard let number = URL(string: "https://www.behance.net/prostudioagency") else { return }
        UIApplication.shared.open(number)
    }

    @IBAction func dribleClicked() {
        guard let number = URL(string: "https://dribbble.com/prostudioagency") else { return }
        UIApplication.shared.open(number)
    }

	@objc private func v1Clicked() {
		let index = segmentedControl.selectedSegment
		let first = index == 0
		if first {
			guard let number = URL(string: "tel://" + "78124256565") else { return }
			UIApplication.shared.open(number)
		} else {
			guard let number = URL(string: "tel://" + "74954142243") else { return }
			UIApplication.shared.open(number)
		}
	}
	
	@objc private func v2Clicked() {
		let index = segmentedControl.selectedSegment
		let first = index == 0
		if first {
			let latitude: CLLocationDegrees = 59.851131
			let longitude: CLLocationDegrees = 30.301442
			
			let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
			let regionSpan = MKCoordinateRegion.init(center: coordinates, span: MKCoordinateSpan.init(latitudeDelta: latitude, longitudeDelta: longitude))
			let options = [
				MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
				MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
			]
			let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
			let mapItem = MKMapItem(placemark: placemark)
			mapItem.name = "ProStudio СПБ"
			mapItem.openInMaps(launchOptions: options)
		} else {
			let latitude: CLLocationDegrees = 55.675767
			let longitude: CLLocationDegrees = 37.505997
			
			let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
			let regionSpan = MKCoordinateRegion.init(center: coordinates, span: MKCoordinateSpan.init(latitudeDelta: latitude, longitudeDelta: longitude))
			let options = [
				MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
				MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
			]
			let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
			let mapItem = MKMapItem(placemark: placemark)
			mapItem.name = "ProStudio СПБ"
			mapItem.openInMaps(launchOptions: options)
		}
	}
	
	@objc private func v3Clicked() {
		guard let number = URL(string: "mailto:" + "mail@prostudio.ru") else { return }
		UIApplication.shared.open(number)
	}
	
	@objc func changed(sender: ContactsSegmentedControl) {
		let index = sender.selectedSegment
		let first = index == 0
		decorizeLabel1(first: first)
		decorizeLabel2(first: first)
		decorizeLabel3(first: first)
	}
	
	@IBAction func vk() {
		UIApplication.shared.open(URL.init(string: "https://vk.com/prostudioagency")!, options: [:], completionHandler: nil)
	}
	
	let lineHeight: CGFloat = 10
	func decorizeLabel1(first: Bool = true) {
		let attributedString = NSMutableAttributedString(string: first ? "Позвонить\r+7 (812) 425-65-65" : "Позвонить\r+7 (495) 414-22-43", attributes: [
			.font: UIFont(name: "Intro-Bold", size: 18)!,
			.foregroundColor: UIColor(white: 0.0, alpha: 1.0)
			])
		
			attributedString.addAttributes([
				.font: UIFont(name: "Intro-Book", size: 14)!,
				.foregroundColor: UIColor(red: 0.0, green: 127.0 / 255.0, blue: 201.0 / 255.0, alpha: 1.0)
				], range: NSRange(location: 0, length: 9))
		
		label1.attributedText = attributedString
		label1.setLineHeight(lineHeight)
	}
	
	func decorizeLabel3(first: Bool = true) {
		let attributedString = NSMutableAttributedString(string: first ? "Проложить маршрут  \rЛенинский пр-т, 151" : "Проложить маршрут  \rпр-т Вернадского, дом 39" , attributes: [
			.font: UIFont(name: "Intro-Bold", size: 18)!,
			.foregroundColor: UIColor(white: 0.0, alpha: 1.0)	
			])
		
			attributedString.addAttributes([
				.font: UIFont(name: "Intro-Book", size: 14)!,
				.foregroundColor: UIColor(red: 0.0, green: 127.0 / 255.0, blue: 201.0 / 255.0, alpha: 1.0)
				], range: NSRange(location: 0, length: 17))
		
		label2.attributedText = attributedString
		label2.setLineHeight(lineHeight)
	}
	
	func decorizeLabel2(first: Bool = true) {
		let attributedString = NSMutableAttributedString(string: "Отправить письмо\rmail@prostudio.ru", attributes: [
			.font: UIFont(name: "Intro-Bold", size: 18)!,
			.foregroundColor: UIColor(white: 0.0, alpha: 1.0)
			])
		
			attributedString.addAttributes([
				.font: UIFont(name: "Intro-Book", size: 14)!,
				.foregroundColor: UIColor(red: 0.0, green: 127.0 / 255.0, blue: 201.0 / 255.0, alpha: 1.0)
				], range: NSRange(location: 0, length: 16))
		
		label3.attributedText = attributedString
		label3.setLineHeight(lineHeight)
	}
}

extension UILabel {
	
	func setLineHeight(_ lineHeight: CGFloat) {
		let text = self.text
		if let text = text {
			let attributeString = NSMutableAttributedString(attributedString: self.attributedText!)
			let style = NSMutableParagraphStyle()
			
			style.lineSpacing = lineHeight
			attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, text.count))
			self.attributedText = attributeString
		}
	}
}
