//
//  CalendarView.swift
//  WaterDrop
//
//  Created by YuriyFpc on 11/14/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import UIKit

class CalendarView: UIView {
    
    struct Constants {
        static let backColor = UIColor.init(red: 89/255, green: 190/255, blue: 191/255, alpha: 1.0)
        static let titleSize: CGFloat = 19
        static let headerHeight: CGFloat = 70
        static let textColor = UIColor.white
        static let selectedColor = UIColor.red
    }
    
    var calendarView: JTACMonthView!
    
    let fullDateTitle: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .center
        l.backgroundColor = Constants.backColor
        l.font = UIFont.systemFont(ofSize: Constants.titleSize, weight: .medium)
        l.textColor = Constants.textColor
        return l
    }()
    
    let fullDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy MM dd"
        return df
    }()
    
    let monthYearFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MMM, yyyy"
        return df
    }()
    
    let shortDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "MMMM  d"
        return df
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    private func setupSubviews() {
        addSubview(fullDateTitle)
        fullDateTitle.topAnchor.constraint(equalTo: topAnchor).isActive = true
        fullDateTitle.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        fullDateTitle.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        fullDateTitle.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        calendarView = JTACMonthView()
        calendarView.backgroundColor = Constants.backColor
        calendarView.scrollingMode = .stopAtEachCalendarFrame
        calendarView.scrollDirection = .horizontal
        calendarView.showsHorizontalScrollIndicator = false
        calendarView.allowsMultipleSelection = true
        calendarView.allowsRangedSelection = true
        calendarView.register(DateCell.self, forCellWithReuseIdentifier: "dateCell")
        calendarView.register(DateHeader.self, forSupplementaryViewOfKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: "DateHeader")
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.calendarDelegate = self
        calendarView.calendarDataSource = self
        
        
        addSubview(calendarView)
        calendarView.topAnchor.constraint(equalTo: fullDateTitle.bottomAnchor).isActive = true
        calendarView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        calendarView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        calendarView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}

extension CalendarView: JTACMonthViewDelegate {
    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "DateHeader", for: indexPath) as! DateHeader
        header.monthTitle.text = shortDateFormatter.string(from: range.start)
        fullDateTitle.text = monthYearFormatter.string(from: range.start)
        return header
    }
    
    func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        return MonthSize(defaultSize: Constants.headerHeight)
    }
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, shouldSelectDate date: Date, cell: JTACDayCell?, cellState: CellState) -> Bool {
        return true
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState) {
        print("didSelectDate")
        configureCell(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState) {
        print("didDeselectDate")
        configureCell(view: cell, cellState: cellState)
    }
    
    // -- Helpers
    func configureCell(view: JTACDayCell?, cellState: CellState) {
        guard let cell = view as? DateCell  else { return }
        cell.dateLabel.text = cellState.text
        handleCellTextColor(cell: cell, cellState: cellState)
        handleCellSelected(cell: cell, cellState: cellState)
    }
    
    func handleCellSelected(cell: DateCell, cellState: CellState) {
        if cellState.isSelected {
            cell.selectedView.layer.cornerRadius =  13
            cell.selectedView.isHidden = false
        } else {
            cell.selectedView.isHidden = true
        }
    }
   
    func handleCellTextColor(cell: DateCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.dateLabel.textColor = Constants.textColor
        } else {
            cell.dateLabel.textColor = UIColor.clear
        }
    }
    
//    func handleCellSelected(cell: DateCell, cellState: CellState) {
//        cell.selectedView.isHidden = !cellState.isSelected
//        switch cellState.selectedPosition() {
//        case .left:
//            cell.selectedView.layer.cornerRadius = 20
//            cell.selectedView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
//        case .middle:
//            cell.selectedView.layer.cornerRadius = 0
//            cell.selectedView.layer.maskedCorners = []
//        case .right:
//            cell.selectedView.layer.cornerRadius = 20
//            cell.selectedView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
//        case .full:
//            cell.selectedView.layer.cornerRadius = 20
//            cell.selectedView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
//        default: break
//        }
//    }
}

extension CalendarView: JTACMonthViewDataSource {
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let startDate = fullDateFormatter.date(from: "2018 01 01")!
        let endDate = Date()
        return ConfigurationParameters(startDate: startDate,
                                       endDate: endDate,
                                       generateInDates: .forAllMonths,
                                       generateOutDates: .tillEndOfGrid)
    }
    
    
}
