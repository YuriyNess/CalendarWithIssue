//
//  DateCell.swift
//  WaterDrop
//
//  Created by YuriyFpc on 11/14/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import UIKit

class DateCell: JTACDayCell {
    let dateLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .center
        l.textColor = CalendarView.Constants.textColor
        return l
    }()
    
    let selectedView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = CalendarView.Constants.selectedColor
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(selectedView)
        selectedView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        selectedView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        selectedView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        selectedView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(dateLabel)
        dateLabel.constraintsTo(view: self)
    }
}
