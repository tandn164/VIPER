//
//  UIImageView+.swift
//  MVPBasic
//
//  Created by Nguyễn Đức Tân on 03/08/2023.
//

import Foundation
import Alamofire
import SDWebImage

extension UIImageView {
    func setImage(withPath path: String?) {
        guard let url = try? path?.asURL() else {
            return
        }
        self.sd_setImage(with: url)
    }
    
    func setImage(withPath path: String?, placeholderImage placeholder: UIImage? = nil){
        guard let url = try? path?.asURL() else {
            self.image =  placeholder
            return
        }
        self.sd_setImage(with: url, placeholderImage: placeholder)
    }
}
