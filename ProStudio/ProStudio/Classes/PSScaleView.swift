//
//  PSScaleView.swift
//  ProStudio
//
//  Created by Danil Detkin on 03/11/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit

class PSScaleView: UIView {
	
	private func scaleIn() {
		UIView.animate(withDuration: 0.2) {
			self.transform = CGAffineTransform(scaleX: 0.84, y: 0.84)
		}
	}
	
	private func scaleOut() {
		UIView.animate(withDuration: 0.2) {
			self.transform = .identity
		}
	}
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		scaleIn()
		UIImpactFeedbackGenerator(style: .medium).impactOccurred()
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		scaleOut()	
		UIImpactFeedbackGenerator(style: .light).impactOccurred()
	}
}