//
//  ViewColChanger.swift
//  ViewColorChanger
//
//  Created by Dante  Lacey-Thompson on 9/17/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import UIKit

public class ColorView : UIView{
    let colors : [UIColor] = [.red, .orange, .yellow, .green, .blue, .purple]
    var colorcounter = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // The Main Stuff
        let scheduledColorChanged = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { (timer) in  //1
            UIView.animate(withDuration: 2.0) {  //2
                self.layer.backgroundColor = self.colors[self.colorcounter % 6].cgColor  //3
                self.colorcounter+=1  //4
            }
        }
        
        scheduledColorChanged.fire()  //5
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
