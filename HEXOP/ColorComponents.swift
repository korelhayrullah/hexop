//
//  ColorComponents.swift
//  HEXOP
//
//  Created by Korel Hayrullah on 26.06.2024.
//

import SwiftUI
import AppKit

class ColorComponents: ObservableObject {
	// MARK: - PROPERTIES
	@Published
	private(set) var red: CGFloat
	
	@Published
	private(set) var green: CGFloat
	
	@Published
	private(set) var blue: CGFloat
	
	@Published
	private(set) var alpha: CGFloat
	
	// MARK: - INIT
	init(red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0) {
		self.red = red
		self.green = green
		self.blue = blue
		self.alpha = alpha
	}
	
	// MARK: - FUNCTIONS
	func decompose(_ color: Color) {
		let comps = NSColor(color).cgColor.components
		self.red = comps?[0] ?? 0
		self.green = comps?[1] ?? 0
		self.blue = comps?[2] ?? 0
		self.alpha = comps?[3] ?? 0
	}
	
	func compose() -> Color {
		return Color(NSColor(red: red, green: green, blue: blue, alpha: alpha))
	}
	
	func clear() {
		self.red = 0
		self.green = 0
		self.blue = 0
		self.alpha = 0
	}
	
	func getDecimal(_ component: Component) -> Int {
		switch component {
		case .red:
			return Int(red * 255)
		case .green:
			return Int(green * 255)
		case .blue:
			return Int(blue * 255)
		case .alpha:
			return Int(alpha * 255)
		}
	}
	
	func getHex(_ component: Component) -> String {
		return String(format: "%02X", getDecimal(component))
	}
	
	func getFullHexRepresentation() -> String {
		return Component
			.allCases
			.sorted(by: {$0.rawValue < $1.rawValue })
			.reduce(into: "", { $0 += getHex($1)} )
	}
}

extension ColorComponents {
	enum Component: Int, CaseIterable {
		case red 		= 0
		case green 	= 1
		case blue 	= 2
		case alpha 	= 3
	}
}
