//
//  GwowingCalendarView.swift
//  EasyTraining
//
//  Created by YuriyFpc on 11/14/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import UIKit

class GwowingCalendarView: UIView {
    
    private struct Constants {
        static let cornerRadius: CGFloat = 4
    }
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var rightLabel: UILabel!
    
    lazy var subview: UIView = {
        let v = UIView()
        v.isHidden = true
        v.layer.cornerRadius = Constants.cornerRadius
        v.isUserInteractionEnabled = true
        return v
    }()
    
    override func awakeFromNib() {
        leftView.layer.cornerRadius = Constants.cornerRadius
        leftView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        rightView.layer.cornerRadius = Constants.cornerRadius
        rightView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromXib()
        addAnimatableSubview()
        setupGestures()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromXib()
        addAnimatableSubview()
        setupGestures()
    }
    
    private func setupGestures() {
        leftView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hadnleTapLeft)))
    }
    
    @objc
    private func hadnleTapLeft() {
        animateAppearence(fromLeft: true)
    }

    @objc
    private func hadnleTapSubview() {
        animateDissapear(fromLeft: true)
    }
    
    
    private func loadViewFromXib() {
        let v =  Bundle.main.loadNibNamed("GwowingCalendarView", owner: self, options: nil)?.first as! UIView
        addSubview(v)
        v.constraintsTo(view: self)
    }
    
    private func addAnimatableSubview() {
        addSubview(subview)
    }
    
    var timer: Timer!
    func animateAppearence(fromLeft: Bool) {
        let startView = fromLeft == true ? leftView! : rightView!
        subview.backgroundColor = startView.backgroundColor
        subview.frame = startView.frame
        subview.isHidden = false
        let newRect =  CGRect(x: subview.frame.origin.x, y: subview.frame.origin.y, width: (subview.frame.width * 2) + 4, height: subview.frame.height * 3)
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.subview.frame = newRect
        }) { (_) in
            self.timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (timer) in
                self.animateDissapear(fromLeft: true)
            })
        }
    }
    
    func animateDissapear(fromLeft: Bool) {
        let startView = fromLeft == true ? leftView! : rightView!
        let newRect =  startView.frame
        UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.subview.frame = newRect
        }) { (_) in
            self.subview.isHidden = true
        }
    }
}

extension UIView {
    func constraintsTo(view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func constraintsTo(view: UIView, insets: UIEdgeInsets) {
        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(equalTo: view.leftAnchor, constant: insets.left).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor, constant: -insets.right).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom).isActive = true
    }
}
