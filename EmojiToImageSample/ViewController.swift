//
//  ViewController.swift
//  EmojiToImageSample
//
//  Created by Tadashi on 2017/10/20.
//  Copyright © 2017 UBUNIFU Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var seg: UISegmentedControl!


	@IBOutlet weak var button: UIButton!
	@IBAction func button(_ sender: Any) {
		if let str = self.textField?.text {
			let image = self.emojiToImage(text: str,
			                              size: CGFloat(((seg.selectedSegmentIndex) + 1) * 320))
			self.imageView?.image = image
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()

		self.textField.delegate = self
		self.textField.layer.borderWidth = 0.5
		self.textField.layer.borderColor = UIColor.init(red: 1, green: 0, blue: 0.5, alpha: 1).cgColor

		self.imageView.layer.borderWidth = 0.5
		self.imageView.layer.borderColor = UIColor.init(red: 1, green: 0, blue: 0.5, alpha: 1).cgColor

		self.button.layer.borderWidth = 0.5
		self.button.layer.borderColor = UIColor.init(red: 1, green: 0, blue: 0.5, alpha: 1).cgColor
		self.button.layer.cornerRadius = 4.0

		if let str = self.textField?.text {
			let image = self.emojiToImage(text: str,
			                              size: CGFloat(((seg.selectedSegmentIndex) + 1) * 320))
			self.imageView?.image = image
		}
	}

	func emojiToImage(text: String, size: CGFloat) -> UIImage {

		let outputImageSize = CGSize.init(width: size, height: size)
		let baseSize = text.boundingRect(with: CGSize(width: 2048, height: 2048),
		                                 options: .usesLineFragmentOrigin,
		                                 attributes: [.font: UIFont.systemFont(ofSize: size / 2)], context: nil).size
		let fontSize = outputImageSize.width / max(baseSize.width, baseSize.height) * (outputImageSize.width / 2)
		let font = UIFont.systemFont(ofSize: fontSize)
		let textSize = text.boundingRect(with: CGSize(width: outputImageSize.width, height: outputImageSize.height),
		                                 options: .usesLineFragmentOrigin,
		                                 attributes: [.font: font], context: nil).size

		let style = NSMutableParagraphStyle()
		style.alignment = NSTextAlignment.center
		style.lineBreakMode = NSLineBreakMode.byClipping

		let attr : [NSAttributedStringKey : Any] = [NSAttributedStringKey.font : font,
		             NSAttributedStringKey.paragraphStyle: style,
		             NSAttributedStringKey.backgroundColor: UIColor.clear ]

		UIGraphicsBeginImageContextWithOptions(outputImageSize, false, 0)
		text.draw(in: CGRect(x: (size - textSize.width) / 2,
		                     y: (size - textSize.height) / 2,
		                     width: textSize.width,
		                     height: textSize.height),
		                     withAttributes: attr)
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		return image
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

extension ViewController: UITextFieldDelegate {

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.textField.resignFirstResponder()
		return	true
	}
}
