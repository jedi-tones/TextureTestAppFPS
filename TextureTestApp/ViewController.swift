//
//  ViewController.swift
//  TextureTestApp
//
//  
//

import AsyncDisplayKit

final class ViewController: ASDKViewController<ASDisplayNode> {
    
    private let collectionViewNode: ASCollectionNode
    private let text = TextModel.shared.getTextArray()
    private var prevTimestamp: CFTimeInterval?
    
    override init() {
        let layout = UICollectionViewFlowLayout()
        let colletionView = ASCollectionNode(collectionViewLayout: layout)
        self.collectionViewNode = colletionView
        
        super.init(node: colletionView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        collectionViewNode.backgroundColor = .white
        collectionViewNode.delegate = self
        collectionViewNode.dataSource = self
        
        let displayLink = CADisplayLink(target: self, selector: #selector(displayLinkUpdated(sender:)))
        displayLink.add(to: .main, forMode: .tracking)
        
    }
    
    @objc private func displayLinkUpdated(sender: CADisplayLink) {
        guard let prevTimestamp = prevTimestamp else {
            self.prevTimestamp = sender.timestamp
            return
        }
     
     //   let diff = sender.timestamp - prevTimestamp
        let fps = 1 / (sender.timestamp - prevTimestamp)
       // print("\(fps)")
        if (fps) < (60) {
            print("freez: \(fps)")
        }
        self.prevTimestamp = sender.timestamp
    }
    

}

extension ViewController: ASCollectionDelegate, ASCollectionDataSource {
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        text.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        let textToCell = text[indexPath.item]
        let nodeBlock = { () -> ASCellNode in
           return TextCell(text: textToCell )
        }
        
        return nodeBlock
    }
}
