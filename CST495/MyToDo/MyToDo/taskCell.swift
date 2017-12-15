//
//  taskCell.swift
//  MyToDo
//
//  Created by Dante  Lacey-Thompson on 12/13/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import Foundation
import UIKit

class taskCell: UITableViewCell {
    @IBOutlet weak var taskNoteLabel: UILabel!
    @IBOutlet weak var taskPriorityImage: UIImageView!
    @IBOutlet weak var taskDateLabel: UILabel!
    let dateFormatter = DateFormatter()
    
    var TM: Task!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configCell(TM: Task){
        self.TM = TM
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.short
        self.taskNoteLabel.adjustsFontSizeToFitWidth = true
        self.taskNoteLabel.text = TM.note
        self.taskPriorityImage.image = UIImage(named: TM.prioritylevel)
        self.taskDateLabel.adjustsFontSizeToFitWidth = true
        self.taskDateLabel.text = dateFormatter.string(from: TM.dueDate!)
    }
}
