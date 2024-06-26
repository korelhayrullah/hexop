//
//  ContentView.swift
//  HEXOP
//
//  Created by Korel Hayrullah on 26.06.2024.
//

import SwiftUI
import AppKit

struct ContentView: View {
	// MARK: - PROPERTIES
	@StateObject
	private var colorComponents: ColorComponents = ColorComponents()
	
	@State
	private var color: Color = .black
	
	// MARK: - BODY
	var body: some View {
		VStack {
			ColorPicker("Selected Color", selection: $color)
			
			Button("Clear Selection") {
				colorComponents.clear()
				color = .black
			}
			
			HStack {
				VStack(alignment: .leading, spacing: 10) {
					Text("")
					Text("Hex #")
					Text("Decimal")
				}
				
				ComponentRow(title: "Red", component: .red)
				ComponentRow(title: "Green", component: .green)
				ComponentRow(title: "Blue", component: .blue)
				ComponentRow(title: "Alpha", component: .alpha)
			}
			.id(color)
			.padding(.top, 10)
			
			VStack(spacing: 10) {
				Text("Corresponding 8 digit HEX #")
				HStack(spacing: 10) {
					Text(colorComponents.getFullHexRepresentation())
					Button(action: {
						setPasteboard()
					}) {
						Text("Copy")
					}
				}
			}
			.padding(.top, 20)
		}
		.onChange(of: color) { value in
			colorComponents.decompose(value)
		}
	}
	
	@ViewBuilder
	private func ComponentRow(title: String, component: ColorComponents.Component) -> some View {
		VStack(spacing: 10) {
			Text(title)
			Text(colorComponents.getHex(component))
			Text("\(colorComponents.getDecimal(component))")
		}
	}
	
	private func setPasteboard() {
		let pasteboard = NSPasteboard.general
		pasteboard.clearContents()
		let string = "#" + colorComponents.getFullHexRepresentation()
		pasteboard.setString(string, forType: .string)
	}
}

#Preview {
	ContentView()
}
