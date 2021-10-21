//
//  EmptyErrorSateView.swift
//  task
//
//  Created by mohamed salah on 9/24/21.
//

import Foundation
import UIKit

enum StateView {
    case empty
    case error
    
    
    var text: String {
        switch self {
        case .empty:
            return "No Data Found !!"
        case .error:
            return "Something went wrong !!"
        }
    }
    var imageName: String {
        switch self {
        case .empty:
            return "empty"
        case .error:
            return "error"
            
        }
    }
}

class EmptyErrorSateView: UIView {
    var state: StateView? {
        didSet {
            self.setupData()
            
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = ""
        label.textAlignment = .center
        
        
        return label
    }()
    
    lazy var stateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init(state: StateView) {
        super.init(frame: .zero)
        self.state = state
        setupUI()
        setupData()
    }
    
    private   func setupData(){
        self.stateImageView.image = UIImage(named: self.state?.imageName ?? "")
        self.titleLabel.text = self.state?.text
    }
    
    func setupUI(){
        self.addSubview(titleLabel)
        self.addSubview(stateImageView)
        stateImageView.setConstraints(top: self.topAnchor,   leading: self.leadingAnchor, trailing: self.trailingAnchor, paddingTop: 10, paddingLeading: 16, paddingTrailing: 16,height: 200)
        titleLabel.setConstraints(top: stateImageView.bottomAnchor,  bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, paddingTop: 10, paddingBottom: 10, paddingLeading: 16, paddingTrailing: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
