//
//  TextCell.swift
//  TextureTestApp
//
// 
//

import AsyncDisplayKit

class TextCell: ASCellNode {
    
    let textLabel = ASTextNode()
    
     init(text: String) {
        super.init()
        automaticallyManagesSubnodes = true
        setup()
        configure(text: text)
        
    }
    
    private func setup() {
        backgroundColor = .systemBackground
       // neverShowPlaceholders = true
    }
    
    private func configure(text: String) {
        textLabel.attributedText = NSAttributedString(string: text,
                                                      attributes: [NSAttributedString.Key.foregroundColor : UIColor.label])
          
    }
    
    override func layout() {
        super.layout()
        cornerRadius = self.frame.height / 2
        
//        layer.shadowPath = CGPath(roundedRect: frame, cornerWidth: cornerRadius, cornerHeight: cornerRadius, transform: nil)
    }
    override func nodeDidLayout() {
        super.nodeDidLayout()
       
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        shadowColor = UIColor.black.cgColor
        shadowOffset = CGSize(width: 5, height: 5)
        shadowRadius = CGFloat(3)
        shadowOpacity = 0.5
        
        
        clipsToBounds = false
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 4,
                                               left: 8,
                                               bottom: 4,
                                               right: 8),
                          child: textLabel)
        
    }
}
