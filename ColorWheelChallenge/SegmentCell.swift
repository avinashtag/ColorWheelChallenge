//
//  SegmentCell.swift
//  ColorWheelChallenge
//
//  Created by Avinash on 19/08/2024.
//

import UIKit

class SegmentCell: UITableViewCell {

    enum SegmentColor : Int{
        case teal = 0
        case green
        case orange
    }
    
    @IBOutlet private weak var segment: UISegmentedControl!
    var didSelectColor:((UIColor) -> ())?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        setupSegmentUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    private func setupSegmentUI(){
        let imageSize = CGSize(width: 40, height: 40)
        if let image = UIImage.createCircularImage(with: .wheelTeal, size: imageSize) {
            segment.setImage(image.withRenderingMode(.alwaysOriginal), forSegmentAt: 0)
        }
        if let image = UIImage.createCircularImage(with: .wheelGreen, size: imageSize) {
            segment.setImage(image.withRenderingMode(.alwaysOriginal), forSegmentAt: 1)
        }
        if let image = UIImage.createCircularImage(with: .wheelOrange, size: imageSize) {
            segment.setImage(image.withRenderingMode(.alwaysOriginal), forSegmentAt: 2)
        }
    }
    
    @IBAction private func segmentChange(_ sender: UISegmentedControl) {
        
        
        switch SegmentColor(rawValue: sender.selectedSegmentIndex) {
        case .teal:
            self.didSelectColor?(.wheelTeal)
            break
        case .green:
            self.didSelectColor?(.wheelGreen)
            break
        case .orange:
            self.didSelectColor?(.wheelOrange)
            break
        default:
            break
            
        }
    }

}
