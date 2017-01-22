/*
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import Glasses

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

  public var glasses: Glasses = .dealWithIt {
    didSet {
      setNeedsDisplay()
    }
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  public init(glasses: Glasses, origin: CGPoint, width: CGFloat) {
    self.glasses = glasses
    let height = width * CGFloat(glasses.numPixelsHeight) / CGFloat(glasses.numPixelsWidth)
    super.init(frame: CGRect(x: origin.x, y: origin.y, width: width, height: height))
    backgroundColor = .clear
  }

  public convenience init(width: CGFloat) {
    self.init(glasses: .dealWithIt, origin: .zero, width: width)
  }

  override public func draw(_ rect: CGRect) {
    guard let context = UIGraphicsGetCurrentContext() else { return }

    let pixelWidth = rect.width / CGFloat(glasses.numPixelsWidth)

    let xOffset: CGFloat = floor((rect.width - pixelWidth * CGFloat(glasses.numPixelsWidth)) / 2.0)
    let yOffset: CGFloat = floor((rect.height - pixelWidth * CGFloat(glasses.numPixelsHeight)) / 2.0)

    for (y, pixelRow) in glasses.pixels.enumerated() {
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
