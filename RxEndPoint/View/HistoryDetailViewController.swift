//
//  HistoryDetailViewController.swift
//  RxEndPoint
//
//  Created by David on 1/2/21.
//

import UIKit

class HistoryDetailViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    var record: Record?
    
    lazy private var mTV: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.font = UIFont.systemFont(ofSize: 22)
        return textView
    }()
    
    // MARK: - FUNCTIONS
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = .white
        view.addSubview(mTV)
        
        mTV.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
        }
        
        guard let data = record?.jsonData, let str = String(data: data, encoding: .utf8) else {
            return
        }
        navigationItem.title = record?.timeInterval.toDateString()
        mTV.text = str
    }
}
