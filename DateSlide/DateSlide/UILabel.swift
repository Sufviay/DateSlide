//
//  UILabel.swift
//  XYCharts
//
//  Created by 岁变 on 2018/2/2.
//  Copyright © 2018年 岁变. All rights reserved.
//

import UIKit

extension UILabel {
    
    func setUpLabel(frame: CGRect, text: String, textColor: UIColor, textFont: CGFloat) {
        self.frame = frame
        self.text = text
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: textFont)
        self.textAlignment = .center
    }
    
}

