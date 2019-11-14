//
//  SectionHeader.swift
//  WaterDrop
//
//  Created by YuriyFpc on 11/14/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import UIKit

class DateHeader: JTACMonthReusableView  {
    
    let monthTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .center
        l.textColor = CalendarView.Constants.textColor
        return l
    }()
    
    let weakDays: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.alignment = .fill
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func populateWeakDays() {
        let weakArr = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
        weakArr.forEach { (day) in
            let l = UILabel()
            l.text = day
            l.textAlignment = .center
            l.backgroundColor = UIColor.white.withAlphaComponent(0.3)
            l.textColor = CalendarView.Constants.textColor
            weakDays.addArrangedSubview(l)
        }
    }
    
    private func setupViews() {
        populateWeakDays()
        
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sv)
        
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.topAnchor.constraint(equalTo: topAnchor).isActive = true
        sv.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        sv.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        sv.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        sv.addArrangedSubview(monthTitle)
        sv.addArrangedSubview(weakDays)
    }
}
