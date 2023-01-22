//
//  MerchantsView.swift
//  GiftPesa
//
//  Created by Lawrence Magerer on 18/01/2023.
//

import UIKit

class MerchantsView: UIView {
    @IBOutlet weak var merchantsCollectionView: UICollectionView!
    var view: UIView!
    
    var merchants: [Merchant] = []
    
    override init(frame: CGRect) {
        // 1. setup any properties here
        
        // 2. call super.init(frame:)
        super.init(frame: frame)
        
        // 3. Setup view from .xib file
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        // 1. setup any properties here
        
        // 2. call super.init(coder:)
        super.init(coder: aDecoder)
        
        // 3. Setup view from .xib file
        xibSetup()
        setupTMerchantsCollectionView()
        
    }
    
    
    func xibSetup() {
        
        
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        //view.layer.cornerRadius = 15

        // Make the view stretch with containing view
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        
        addSubview(view)
        
        setupTMerchantsCollectionView()

    }
    
    // SETUP MERCHANTS COLLECTION VIEW
    func setupTMerchantsCollectionView(){
        self.merchantsCollectionView.register(UINib(nibName: "MerchantsSelectedCell", bundle: nil), forCellWithReuseIdentifier:"MerchantsSelectedCell")
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    

}
extension MerchantsView : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell : MerchantsSelectedCell? = collectionView.dequeueReusableCell(withReuseIdentifier : "MerchantsSelectedCell", for: indexPath) as? MerchantsSelectedCell
        
        return cell!
    }
    
    
}
