//
//  BottomView.swift
//  SortPeople
//
//  Created by PCQ184 on 22/04/20.
//  Copyright © 2020 PCQ184. All rights reserved.
//

import UIKit

class BottomView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    var userModel: UserModel! {
           didSet{
               self.nameLabel.attributedText = self.attributeStringForModel(userModel: userModel)
//               self.imageViewBackground.image = UIImage(named:String(Int(1 + arc4random() % (8 - 1))))
           }
       }
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           commonInit()
       }
       
       func commonInit() {
           Bundle.main.loadNibNamed(BottomView.className, owner: self, options: nil)
           contentView.fixInView(self)
           
//           imageViewProfile.contentMode = .scaleAspectFill
//           imageViewProfile.layer.cornerRadius = 30
//           imageViewProfile.clipsToBounds = true
       }
       
       private func attributeStringForModel(userModel:UserModel) -> NSAttributedString{
           
           let attributedText = NSMutableAttributedString(string: userModel.name, attributes: [.foregroundColor: UIColor.white,.font:UIFont.boldSystemFont(ofSize: 25)])
           attributedText.append(NSAttributedString(string: "\nnums :\(userModel.num!) - (nib view)" , attributes: [.foregroundColor: UIColor.white,.font:UIFont.systemFont(ofSize: 18)]))
           return attributedText
       }

   }

   extension UIView{
       
       func fixInView(_ container: UIView!) -> Void{
           
           self.translatesAutoresizingMaskIntoConstraints = false;
           self.frame = container.frame;
           container.addSubview(self);
           NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
           NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
           NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
           NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
       }
   }

   extension NSObject {
       
       class var className: String {
           return String(describing: self)
       }
   }


