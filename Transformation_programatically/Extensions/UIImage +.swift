//
//  UIImage.swift
//  Transformation_programatically
//
//  Created by Ravshanbek Tursunbaev on 2023/04/07.
//

import UIKit

extension UIImage{
    
    //Main Images
    static var pandaLiftingBarbelImage: UIImage{
        return UIImage(named: "panda_lifting_barbel")!
    }
    
    static var pandaBulkingImage: UIImage{
        return UIImage(named: "panda_bulking")!
    }
    
    static var pandaExhaustedImage: UIImage{
        return UIImage(named: "panda_exhausted")!
    }
    
    static var pandaLyingImage: UIImage{
        return UIImage(named: "panda_lying")!
    }
    
    //Tabbar Images
    static var runImage:(filled:UIImage, plain: UIImage) {
        let filled = UIImage.init(systemName: "figure.run.circle.fill")!
        let plain = UIImage.init(systemName: "figure.run.circle")!
        return (filled: filled, plain: plain)
    }
    
    static var chartImage:(filled:UIImage, plain: UIImage) {
        let filled = UIImage.init(systemName: "chart.bar.doc.horizontal.fill")!
        let plain = UIImage.init(systemName: "chart.bar.doc.horizontal")!
        return (filled: filled, plain: plain)
    }
    
    static var plusImage:(filled:UIImage, plain: UIImage) {
        let filled = UIImage.init(systemName: "plus.circle.fill")!
        let plain = UIImage.init(systemName: "plus.circle")!
        return (filled: filled, plain: plain)
    }
    
    //Button Images
    static var stopButtonImageFilled: UIImage{
        return UIImage.init(systemName: "stop.fill")!
    }
    
    static var startButtonImageFilled: UIImage{
        return UIImage.init(systemName: "play.fill")!
    }
    
    static var photoImage:(filled:UIImage, plain: UIImage) {
        let filled = UIImage.init(systemName: "photo.circle.fill")!
        let plain = UIImage.init(systemName: "photo.circle")!
        return (filled: filled, plain: plain)
    }
    
    static var chevronImage: UIImage{
        return UIImage.init(systemName: "chevron.forward")!
    }
}
