//
//  UIImage+Extension.swift
//  ColorWheelChallenge
//
//  Created by Avinash on 19/08/2024.
//

import Foundation
import CoreImage
import UIKit

extension UIImage{
    
    static func createCircularImage( with color: UIColor, size: CGSize)-> UIImage?{
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { fatalError("UIGraphicsGetCurrentContext nil")}
        context.setFillColor(color.cgColor)
        context.fillEllipse(in: CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
