//
//  CXScrollView.swift
//  scrollMap
//
//  Created by Chris Xu on 6/12/16.
//  Copyright © 2016 Arash. All rights reserved.
//

import UIKit

class CXScrollView: UIScrollView {
    
    var contentView: UIView!
    var closeOffset: CGFloat = 30.0
    var buttonSize: CGSize = CGSize(width: 160, height: 44) {
        didSet {
            updatePositions()
        }
    }
    
    private(set) var firstButton: UIButton!
    private(set) var secondButton: UIButton!
    private(set) var thirdButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if let _ = self.superview {
            drawTheBottomLine()
            updatePositions()
        }
    }
    
    // hittest
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, withEvent: event)
        
        if hitView == self {
            return nil
        }
        
        return hitView
    }
    
    // Mark: - Private Method
    private func setup() {
        self.delegate = self
        
        self.pagingEnabled = true
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        let screenSize = UIScreen.mainScreen().bounds.size
        self.contentSize = CGSizeMake(screenSize.width, screenSize.height * 2 - self.closeOffset)
        
        self.contentView = UIView()
        
        self.contentView.frame = {
            let frame = CGRectOffset(UIScreen.mainScreen().bounds, 0, screenSize.height - self.closeOffset)
            return frame
        }()
        self.contentView.backgroundColor = UIColor.clearColor()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.contentView)
        
        self.firstButton = UIButton.init(type: .System)
        self.contentView.addSubview(self.firstButton)
        applyStyle(self.firstButton)
        
        self.secondButton = UIButton.init(type: .System)
        self.contentView.addSubview(self.secondButton)
        applyStyle(self.secondButton)
        
        self.thirdButton = UIButton.init(type: .System)
        self.contentView.addSubview(self.thirdButton)
        applyStyle(self.thirdButton)
    }
    
    private func drawTheBottomLine() {
        let line = CAShapeLayer()
        line.lineCap     = kCALineCapRound;
        line.lineJoin    = kCALineJoinRound;
        line.fillColor   = nil
        line.strokeColor = UIColor.darkGrayColor().CGColor
        line.lineWidth   = 7
        
        let path = UIBezierPath()
        let length: CGFloat = 44
        let screenSize = UIScreen.mainScreen().bounds.size
        path.moveToPoint(CGPointMake((screenSize.width - length)/2, self.closeOffset/2))
        path.addLineToPoint(CGPointMake((screenSize.width - length)/2 + length, self.closeOffset/2))
        
        line.path = path.CGPath
        self.contentView.layer.addSublayer(line)
    }
    
    private func applyStyle(button: UIButton) {
        button.layer.cornerRadius = 10.0
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.setTitleColor(UIColor.lightGrayColor(), forState: .Disabled)
        button.titleLabel?.font = UIFont.systemFontOfSize(16.0, weight: UIFontWeightHeavy)
        button.backgroundColor = UIColor.whiteColor()
    }
    
    private func updatePositions() {
        let center = CGPointMake(self.contentView.bounds.midX, self.contentView.bounds.midY)
        let spacing: CGFloat = 30.0
        firstButton.frame = {
            var frame = self.contentView.bounds
            frame.size = buttonSize
            return frame
        }()
        firstButton.center = CGPointMake(center.x, center.y - (buttonSize.height + spacing))

        secondButton.frame = {
            var frame = self.contentView.bounds
            frame.size = buttonSize
            return frame
            }()
        secondButton.center = center
        
        thirdButton.frame = {
            var frame = self.contentView.bounds
            frame.size = buttonSize
            return frame
            }()
        thirdButton.center = CGPointMake(center.x, center.y + (buttonSize.height + spacing))
    }
}

extension CXScrollView: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let scrollingProgress = scrollView.contentOffset.y / (CGRectGetHeight(scrollView.bounds) - self.closeOffset)
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7 * min(scrollingProgress, 1.0))
    }
}
