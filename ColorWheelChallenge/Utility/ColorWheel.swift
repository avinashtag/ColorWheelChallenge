//
//  ColorWheel.swift
//  ColorWheelChallenge
//
//  Created by Avinash on 19/08/2024.
//

import UIKit

struct ColorPath {
    var Path:UIBezierPath
    var Color:UIColor
}

@IBDesignable
class ColorWheel: UIView {
        
    private var colorPoints: [String: String] = [:]

    override init (frame : CGRect) {
        super.init(frame : frame)
        center = self.center
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        center = self.center
    }

    
    func color( at point: CGPoint) -> UIColor {
        let pointString = "\(Int(point.x)),\(Int(point.y))"
        guard let hex = colorPoints[pointString] else { return .clear }
        return UIColor(hexString: hex)
    }
    
    
    func point(for color: UIColor) -> CGPoint {
        guard let hex = color.toHexString() else { return .zero }
        let colorpoint = colorPoints.first(where: {$0.value == hex})
        guard let points = colorpoint?.key.components(separatedBy: ","), points.count == 2, let x = Double(points[0]), let y = Double(points[1]) else { return .zero }
        return CGPoint(x: x, y: y)
    }
     
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()
        let radius = min(rect.width, rect.height) / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        for y in stride(from: 0, through: rect.height, by: 1) {
            for x in stride(from: 0, through: rect.width, by: 1) {
                let dx = CGFloat(x) - center.x
                let dy = CGFloat(y) - center.y
                let distance = sqrt(dx * dx + dy * dy)
                guard distance <= radius else { continue }
                let angle = atan2(dy, dx)
                let hue = (angle + .pi) / (2 * .pi)
                let saturation = distance / radius
                let color = UIColor(hue: hue, saturation: saturation, brightness: 1.0, alpha: 1.0)
                context?.setFillColor(color.cgColor)
                context?.fill(CGRect(x: x, y: y, width: 1, height: 1))
                let point = CGPoint(x: x, y: y)
                let pointString = "\(Int(point.x)),\(Int(point.y))"
                colorPoints[pointString] = color.toHexString()
            }
        }
    }
   
}
