//
//  HomePageViewController.swift
//  ColorWheelChallenge
//
//  Created by Avinash on 19/08/2024.
//

import UIKit

class HomePageViewController: UITableViewController {

    enum CellView: Int {
        case colorWheel = 0
        case threeSegment
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch CellView(rawValue: indexPath.row) {
            
        case .colorWheel:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(ColorWheelCell.self)", for: indexPath) as? ColorWheelCell else { fatalError("ColorWheelCell nil")}
            return cell
            
        case .threeSegment:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(SegmentCell.self)", for: indexPath) as? SegmentCell else { fatalError("ColorWheelCell nil")}
            cell.didSelectColor = { color in
                let colorwheel = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ColorWheelCell
                colorwheel?.setColor(color)
            }
            return cell
            
        default:
            break
        }
        return UITableViewCell()
        
    }
}
