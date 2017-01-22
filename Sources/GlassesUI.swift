//
//  GlassesUI.swift
//  DealWithIt
//
//  Created by Eric Cerney on 1/16/17.
//  Copyright © 2017 Eric Cerney. All rights reserved.
//

import UIKit

public class GlassesUI: UIView {
  public enum PixelColor: Int {
    case clear = 0, black, gray

    public var cgColor: CGColor {
      switch self {
      case .clear: return UIColor.clear.cgColor
      case .black: return UIColor.black.cgColor
      case .gray: return UIColor.gray.cgColor
      }
    }
  }

  public var pixels = [[Int]]()

  public var numPixelsHeight: Int {
    return pixels.count
  }

  public var numPixelsWidth: Int {
    return pixels.first?.count ?? 0
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  public init(pixels: [[Int]], origin: CGPoint, width: CGFloat) {
    self.pixels = pixels
    let pixelHeight = pixels.count
    let pixelWidth = pixels.first?.count ?? 0
    let height = width * CGFloat(pixelHeight) / CGFloat(pixelWidth)
    super.init(frame: CGRect(x: origin.x, y: origin.y, width: width, height: height))
    backgroundColor = .clear
  }

  public convenience init(pixels: [[Int]], width: CGFloat) {
    self.init(pixels: pixels, origin: .zero, width: width)
  }

  override public func draw(_ rect: CGRect) {
    guard let context = UIGraphicsGetCurrentContext() else { return }

    let pixelWidth = rect.width / CGFloat(numPixelsWidth)

    let xOffset: CGFloat = floor((rect.width - pixelWidth * CGFloat(numPixelsWidth)) / 2.0)
    let yOffset: CGFloat = floor((rect.height - pixelWidth * CGFloat(numPixelsHeight)) / 2.0)

    for (y, pixelRow) in pixels.enumerated() {
      for (x, pixel) in pixelRow.enumerated() {
        if let pixelColor = PixelColor(rawValue: pixel) {
          context.setFillColor(pixelColor.cgColor)
          let test = CGRect(x: CGFloat(x)*pixelWidth + xOffset, y: CGFloat(y)*pixelWidth + yOffset, width: pixelWidth + 0.5, height: pixelWidth + 0.5)
          context.addRect(test)
          context.fillPath()
        }
      }
    }
  }
}
