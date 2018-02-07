//
//  DateSliderViewController.swift
//  XYCharts
//
//  Created by 岁变 on 2018/2/2.
//  Copyright © 2018年 岁变. All rights reserved.
//

import UIKit

let WIDTH: CGFloat = UIScreen.main.bounds.width
let SLIDEW: CGFloat = 14
let SLIDEH: CGFloat = 20

let PRICEBGX: CGFloat = 25
let PRICEBGY: CGFloat = 200
let PRICEBGW: CGFloat = WIDTH - 50
let PRICEBGH: CGFloat = 20
let PRICEMAX: CGFloat = WIDTH * 0.5 + (PRICEBGW * 0.5 - SLIDEW * 0.5 - 5)
let PRICEMIN: CGFloat = WIDTH * 0.5 - (PRICEBGW * 0.5 - SLIDEW * 0.5 - 5)
let RECTWIDTH: CGFloat = PRICEMAX - PRICEMIN
let PROGRESSH: CGFloat = 2
let PROGRESSY: CGFloat = PRICEBGY + (PRICEBGH - 2) / 2




class DateSliderViewController: UIViewController {
    
    
    let leftSlide = UIImageView()
    let rigthSlide = UIImageView()
    
    let leftValue = UILabel()
    let rigthValue = UILabel()
    let midValue = UILabel()
    
    let progressBackView = UIView()
    
    let leftResultLabel = UILabel()
    let rightResultLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView.init(frame: CGRect(x: PRICEBGX, y: PRICEBGY, width: PRICEBGW, height: PRICEBGH))
        imageView.image = UIImage.init(named: "WechatIMG3492")
        self.view.addSubview(imageView)
        
        let leftRect = CGRect(x: PRICEBGX , y: imageView.frame.maxY + 2, width: 30, height: 15)
        let leftText = DateTool.getLeftTimeText(-15)
        leftValue.setUpLabel(frame: leftRect, text: leftText, textColor: UIColor.gray, textFont: 10)
        self.view.addSubview(leftValue)
        
        let rightRect = CGRect(x: imageView.frame.maxX - 20, y: imageView.frame.maxY + 2, width: 30, height: 15)
        let rightText = DateTool.getRightTimeText(15)
        rigthValue.setUpLabel(frame: rightRect, text: rightText, textColor: UIColor.gray, textFont: 10)
        self.view.addSubview(rigthValue)
        
        let midRect = CGRect(x: imageView.frame.midX - 20, y: imageView.frame.maxY + 2, width: 40, height: 16)
        let midText = DateTool.getMidTimeText(0)
        midValue.setUpLabel(frame: midRect, text: midText, textColor: UIColor.black, textFont: 12)
        self.view.addSubview(midValue)
        
        
        //左滑块
        leftSlide.frame = CGRect(x: imageView.center.x - SLIDEW * 0.5 , y: imageView.frame.minY - SLIDEH, width: SLIDEW, height: SLIDEH)
        leftSlide.image = UIImage.init(named: "shangbashou")
        self.view.addSubview(leftSlide)
        
        //右滑块
        rigthSlide.frame = CGRect(x: imageView.center.x - SLIDEW * 0.5, y: imageView.frame.maxY, width: SLIDEW, height: SLIDEH)
        rigthSlide.image = UIImage.init(named: "xiabashou")
        self.view.addSubview(rigthSlide)
        
        //进度条颜色
        progressBackView.frame = CGRect(x: leftSlide.center.x, y: PROGRESSY, width: rigthSlide.center.x - leftSlide.center.x, height: PROGRESSH)
        progressBackView.backgroundColor = UIColor.gray
        self.view.addSubview(progressBackView)

        
        //添加滑动手势
        let leftPanRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(leftSlideMove(pan:)))
        leftPanRecognizer.maximumNumberOfTouches = 1
        leftPanRecognizer.minimumNumberOfTouches = 1
        leftSlide.isUserInteractionEnabled = true
        leftSlide.addGestureRecognizer(leftPanRecognizer)
        
        let rightPanRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(rightSlideMove(pan:)))
        rightPanRecognizer.maximumNumberOfTouches = 1
        rightPanRecognizer.minimumNumberOfTouches = 1
        rigthSlide.isUserInteractionEnabled = true
        rigthSlide.addGestureRecognizer(rightPanRecognizer)
        
        leftResultLabel.frame = CGRect(x: 20, y: 400, width: 100, height: 50)
        leftResultLabel.text = DateTool.getMidTimeText(0)
        
        rightResultLabel.frame = CGRect(x: WIDTH - 120, y: 400, width: 100, height: 50)
        rightResultLabel.text = DateTool.getMidTimeText(0)
        self.view.addSubview(leftResultLabel)
        self.view.addSubview(rightResultLabel)
    }
    
    
    @objc func leftSlideMove(pan: UIPanGestureRecognizer) {
        let point = pan.translation(in: leftSlide)
        var x: CGFloat = leftSlide.center.x + point.x
        if x > rigthSlide.center.x {
            x = rigthSlide.center.x
        } else if(x < PRICEMIN) {
            x = PRICEMIN
        }
        leftSlide.center = CGPoint(x: x, y: leftSlide.center.y)
        pan.setTranslation(.zero, in: self.view)
        updataData()
    }
    
    
    @objc func rightSlideMove(pan: UIPanGestureRecognizer) {
        let point = pan.translation(in: rigthSlide)
        var x: CGFloat = rigthSlide.center.x + point.x
        if x > PRICEMAX {
            x = PRICEMAX
        } else if(x < leftSlide.center.x) {
            x = leftSlide.center.x
        }
        rigthSlide.center = CGPoint(x: x, y: rigthSlide.center.y)
        pan.setTranslation(.zero, in: self.view)
        updataData()
    }
    
    func updataData() {
        let progressBackViewRect = CGRect(x: leftSlide.center.x, y: PROGRESSY, width: rigthSlide.center.x - leftSlide.center.x, height: PROGRESSH)
        progressBackView.frame = progressBackViewRect
        
        let leftText = coordinateTurnToNumber(axis: leftSlide.center.x)
        leftResultLabel.text = leftText
        
        let rigthText = coordinateTurnToNumber(axis: rigthSlide.center.x)
        rightResultLabel.text = rigthText
        
    }
    
    
    //坐标转换成数字
    func coordinateTurnToNumber(axis: CGFloat) -> String {
        //将滑条分成30份，取每份的长度
        let everyLenght = RECTWIDTH / 30.0
        //滑动的距离
        let lenght = axis - PRICEMIN
        let count = Int(lenght / everyLenght)
        
        //左面的日期date
        let minDate = DateTool.getTimeDateWith(-15)
        //滑动位置的日期
        var newComponent = DateComponents()
        newComponent.day = count
        let moveDate = Calendar.current.date(byAdding: newComponent, to: minDate) ?? Date()
        
        let returnstr = DateTool.cleanString(dateStr: DateTool.dateTurnString(date: moveDate))
        return returnstr
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
