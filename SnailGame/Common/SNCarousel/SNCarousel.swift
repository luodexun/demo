//
//  SNCarousel.swift
//  SnailGame
//
//  Created by Edison on 2019/12/19.
//  Copyright © 2019 DigitalSnail. All rights reserved.
//

import UIKit

protocol SNCarouselDelegate {
    func SNCarouselDidSelected(carousel:SNCarousel,index:Int) //轮播图点击代理
}

protocol SNCarouselDatasource {
    func numbersForCarousel() -> Int //轮播图数量
    func viewForCarousel(carousel:SNCarousel,indexPath:NSIndexPath,index:Int) -> UICollectionViewCell
}

class SNCarousel: UIView , UICollectionViewDelegate , UICollectionViewDataSource {
    
    var flowLayout : SNFlowLayout?
    
    var isAuto = true //是否自动轮播, 默认为true
    
    var autoTimInterval : TimeInterval = 3 //自动轮播时间间隔, 默认 3s
    
    var endless = true //是否开始无限轮播 true可以无限衔接
    
    var carouselView : UICollectionView?
    
    var currentIndex : Int?
    
    var infactIndex : Int?
    
    var addHeight : CGFloat? = 0.0
    
    var isPause : Bool = false //自动播放是否暂停
    
    var currentIndexPath : NSIndexPath? //当前展示在中间的cell下标
    
    var infactNumbers = 300
    
    var delegate : SNCarouselDelegate?
    
    var datasource : SNCarouselDatasource?
    
    init(frame:CGRect,delegate:SNCarouselDelegate,datasource:SNCarouselDatasource,flowLayout:SNFlowLayout) {
        super.init(frame: frame)
        self.flowLayout = flowLayout
        self.delegate = delegate
        self.datasource = datasource
        initCarouselView()
        configureView()
        NotificationCenter.default.addObserver(self, selector: #selector(appBecomeInactive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(appBecomeActive), name: UIApplication.didEnterBackgroundNotification, object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(appBecomeActive), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    func initCarouselView() {
        carouselView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout!)
        carouselView?.backgroundColor = UIColor.white
        carouselView?.clipsToBounds = false
        carouselView?.delegate = self
        carouselView?.dataSource = self
        carouselView?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(carouselView!)
        let views = ["view":carouselView]
        let margins = ["top" : "0","bottom" : "0"]
        var str = "H:|-0-[view]-0-|"
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: str, options: [], metrics: margins, views: views as [String : Any]))
        str = "V:|-top-[view]-top-|"
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: str, options: [], metrics: margins, views: views as [String : Any]))
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        newSuperview?.clipsToBounds = false
        super.willMove(toSuperview: newSuperview)
    }
    
    func controllerWillAppear() {
        resumePlay()
        adjustErrorCell(isScroll: true)
    }
    
    func controllerWillDisAppear() {
        pause()
        adjustErrorCell(isScroll: true)
    }
    
    @objc func appBecomeInactive(notification:NSNotification) {
        pause()
        self.adjustErrorCell(isScroll: true)
    }
    
    @objc func appBecomeActive(notification:NSNotification) {
        resumePlay()
        self.adjustErrorCell(isScroll: true)
    }
    
    func registerViewClass(viewClass:AnyClass,identifier:String) {
        carouselView?.register(viewClass, forCellWithReuseIdentifier: identifier)
    }
    
    //刷新轮播图
    func freshCarousel() {
        if numbers() <= 0 {
            return
        }
        carouselView?.reloadData()
        carouselView?.layoutIfNeeded()
        carouselView?.scrollToItem(at: originIndexPath() as IndexPath, at: .centeredHorizontally, animated: false)
        carouselView?.isUserInteractionEnabled = true
        if isAuto {
            play()
        }
    }
    
    func originIndexPath() -> NSIndexPath {
        let centerIndex = infactNumbers / numbers()
        if centerIndex <= 1 {
            currentIndexPath = NSIndexPath.init(row: numbers(), section: 0)
        } else {
            currentIndexPath = NSIndexPath.init(row: centerIndex / 2 * numbers(), section: 0)
        }
        return currentIndexPath!
    }
    
    //暂停轮播图后,可以调用改方法继续播放
    func resumePlay() {
        isPause = false
        play()
    }
    
    //轮播图暂停自动播放
    func pause() {
        isPause = true
        stop()
    }
    
    func play() {
        stop()
        if isPause {
            return
        }
        self.perform(#selector(nextCell), with: nil, afterDelay: autoTimInterval)
    }
    
    func stop() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(nextCell), object: nil)
        NSObject.cancelPreviousPerformRequests(withTarget: self)
    }
    
    //如果开启自动轮播,销毁前需要调用该方法,释放定时器.否则可能内存泄漏
    func releaseTimer() {
        stop()
    }
    
    @objc func nextCell() {
        if numbers() <= 0 {
            return
        }
        let maxIndex = 1
        if currentIndexPath!.row < infactNumbers - maxIndex {
            let indexPath = NSIndexPath.init(row: currentIndexPath!.row + 1, section: currentIndexPath!.section)
            carouselView?.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
            currentIndexPath = indexPath
        }
        self.perform(#selector(nextCell), with: nil, afterDelay: autoTimInterval)
    }
    
    func numbers() -> Int {
        if datasource != nil {
            return (datasource?.numbersForCarousel())!
        }
        return 0
    }
    
    func configureView() {
        self.backgroundColor = UIColor.white
        carouselView?.showsHorizontalScrollIndicator = false
        carouselView?.showsVerticalScrollIndicator = false
        carouselView?.decelerationRate = UIScrollView.DecelerationRate(rawValue: 0)
    }
    
    func adjustErrorCell(isScroll:Bool) {
        let indexPaths:NSArray = (carouselView?.indexPathsForVisibleItems as NSArray?)!
        let attriArr = NSMutableArray.init(capacity: indexPaths.count)
        indexPaths.enumerateObjects({ obj, idx, stop in
            let attri = self.carouselView?.layoutAttributesForItem(at: obj as! IndexPath)
            attriArr.add(attri as Any)
        })
        let centerX = carouselView!.contentOffset.x + carouselView!.frame.size.width * 0.5;
        var minSpace = CGFloat(MAXFLOAT)
        var shouldSet = true
        if indexPaths.count <= 2 {
            shouldSet = false
        }
        attriArr.enumerateObjects { (att, idx, stop) in
            let obj = att as! UICollectionViewLayoutAttributes
            obj.zIndex = 0
            if abs(minSpace) > abs(obj.center.x - centerX) && shouldSet {
                minSpace = obj.center.x - centerX
                self.currentIndexPath = obj.indexPath as NSIndexPath
            }
        }
        if isScroll {
            self.scrollViewWillBeginDecelerating(carouselView!)
        }
    }
    
    func checkOutofBounds() {
        if currentIndexPath?.row == infactNumbers - 1 {
            let origin = originIndexPath()
            let index = caculateIndex(factIndex: currentIndexPath!.row) - 1
            currentIndexPath = NSIndexPath.init(row: origin.row + index, section: origin.section)
            carouselView?.scrollToItem(at: currentIndexPath! as IndexPath, at: .centeredHorizontally, animated: false)
            carouselView?.isUserInteractionEnabled = true
        } else if currentIndexPath!.row == 0 {
            let origin = originIndexPath()
            let index = caculateIndex(factIndex: currentIndexPath!.row)
            currentIndexPath = NSIndexPath.init(row: origin.row + index, section: origin.section)
            carouselView?.scrollToItem(at: currentIndexPath! as IndexPath, at: .centeredHorizontally, animated: false)
            carouselView?.isUserInteractionEnabled = true
        }
    }
    
    func caculateIndex(factIndex:Int) -> Int {
        if numbers() <= 0 {
            return 0
        }
        let row = factIndex % numbers()
        return row
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if currentIndexPath != nil && currentIndexPath!.row < infactNumbers && currentIndexPath!.row >= 0 {
            carouselView?.scrollToItem(at: currentIndexPath! as IndexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.isPagingEnabled = false
        if(isAuto) {
            play()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollView.isPagingEnabled = true
        stop()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity.x > 0 {
            currentIndexPath = NSIndexPath.init(row: currentIndexPath!.row + 1, section: currentIndexPath!.section)
        } else if velocity.x < 0 {
            currentIndexPath = NSIndexPath.init(row: currentIndexPath!.row - 1, section: currentIndexPath!.section)
        } else if velocity.x == 0 {
            adjustErrorCell(isScroll: true)
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollView.isUserInteractionEnabled = true
        scrollView.isPagingEnabled = false
        play()
        checkOutofBounds()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if numbers() > 0 {
            return infactNumbers
        }
        return 0
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if datasource != nil {
            let cell = datasource?.viewForCarousel(carousel: self, indexPath: indexPath as NSIndexPath, index: caculateIndex(factIndex: indexPath.row))
            return cell!
        }
        return SNTempleteCell.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if delegate != nil {
            delegate?.SNCarouselDidSelected(carousel: self, index: caculateIndex(factIndex: indexPath.row))
        }
        adjustErrorCell(isScroll: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
