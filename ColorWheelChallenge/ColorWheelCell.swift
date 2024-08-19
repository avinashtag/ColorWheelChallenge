//
//  ColorWheelCell.swift
//  ColorWheelChallenge
//
//  Created by Avinash on 19/08/2024.
//

import UIKit

class ColorWheelCell: UITableViewCell {

    @IBOutlet private weak var colorWheel: ColorWheel!
    private var circlePointerSize = CGSizeMake(40, 40)
    private let colorPointer = UIView()
    private var originalCenter: CGPoint!
    
    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        
        let point = gesture.location(in: colorWheel)
        let cc = colorWheel.color(at: point)
        colorPointer.backgroundColor = colorWheel.color(at: point)
        colorPointer.frame = CGRect(x: point.x - circlePointerSize.width/2, y: point.y - circlePointerSize.height/2, width: circlePointerSize.width, height: circlePointerSize.height)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.setupWheel()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    private func setupWheel(){
        colorPointer.frame = CGRect(x: 0, y: 0, width: circlePointerSize.width, height: circlePointerSize.height)
        colorPointer.layer.cornerRadius = 20
        colorPointer.layer.borderColor = UIColor.white.cgColor
        colorPointer.layer.borderWidth = 3
        colorPointer.backgroundColor = .black
        colorPointer.clipsToBounds = true
        self.contentView.addSubview(colorPointer)
        colorPointer.center = colorWheel.convert(colorWheel.center, from:colorWheel.superview)
        
        let cgPoint = colorWheel.center
        colorPointer.backgroundColor = colorWheel.color(at: cgPoint)
        colorPointer.isUserInteractionEnabled = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        colorWheel.addGestureRecognizer(tapGestureRecognizer)
        self.setupPanGestureRecognizer()
    }
    
    func setColor(_ color: UIColor){
        let point = colorWheel.point(for: color)
        colorPointer.frame = CGRect(x: point.x - circlePointerSize.width/2, y: point.y - circlePointerSize.height/2, width: circlePointerSize.width, height: circlePointerSize.height)
    }
    
    private func setupPanGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        colorPointer.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        // Handle the pan gesture here
        switch gestureRecognizer.state {
        case .began:
            originalCenter = self.colorPointer.center
        case .changed:
            let radius = CGFloat ( min(colorWheel.bounds.size.width, colorWheel.bounds.size.height) / 2.0 ) * 0.90
            
            let touchPoint = gestureRecognizer.location(in: self.colorWheel)
            colorPointer.backgroundColor = colorWheel.color(at: touchPoint)
            
            let distance = CGPointDistance(touchPoint, colorWheel.center)
            if distance <= (radius ) {
                colorPointer.center = touchPoint
            }
        case .ended, .cancelled:
            break
        default:
            break
        }
    }
    
    func CGPointDistance(_ p1: CGPoint, _ p2: CGPoint) -> CGFloat {
        return sqrt(pow(p2.x-p1.x,2) + pow(p2.y-p1.y,2))
    }

}
