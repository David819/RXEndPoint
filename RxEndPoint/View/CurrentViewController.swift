//
//  CurrentViewController.swift
//  RxEndPoint
//
//  Created by David on 1/2/21.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CurrentViewController: UIViewController {
    
    // MARK: - PROPERITES
    
    private let viewModel = CurrentViewModel()
    
    private let bag = DisposeBag()

    lazy private var actionButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "stop.circle"), for: .normal)
        return btn
    }()
    
    lazy private var timestampLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .lightGray
        return label
    }()
    
    lazy private var mTable: UITableView = {
        let table = UITableView()
        table.register(KeyValueCell.self, forCellReuseIdentifier: KeyValueCell.Identifier)
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    
    // MARK: - FUNCTIONS
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureView()
        configureData()
    }
    
    private func configureView() {
        view.backgroundColor = .white
        
        navigationItem.title = "/users/defunkt"
        
        view.addSubview(timestampLabel)
        view.addSubview(mTable)
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
        
        
        timestampLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(40)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
        mTable.snp.makeConstraints { (make) in
            make.top.equalTo(timestampLabel.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
        actionButton.rx.controlEvent(.touchUpInside)
            .subscribe {[weak self] (e) in
                if self?.actionButton.tag == 0 {
                    self?.actionButton.tag = 1
                    self?.actionButton.setImage(UIImage(systemName: "restart.circle"), for: .normal)
                    self?.viewModel.stopLoad()
                } else {
                    self?.actionButton.tag = 0
                    self?.actionButton.setImage(UIImage(systemName: "stop.circle"), for: .normal)
                    self?.viewModel.startLoad()
                }
            }
            .disposed(by: bag)
                
        viewModel.publishedStr
            .bind(to: timestampLabel.rx.text)
            .disposed(by: bag)

        viewModel.publishedRcds
            .bind(to: mTable.rx.items(cellIdentifier: KeyValueCell.Identifier, cellType: KeyValueCell.self)) { row, rcd, cell in
                cell.selectionStyle = .none
                cell.keyLabel.text = rcd.timeInterval.toDateString()
                cell.valueLabel.text = String(data: rcd.jsonData ?? Data(), encoding: .utf8)
            }
            .disposed(by: bag)
    }
    
    private func configureData() {
        viewModel.loadHistory()
        viewModel.startLoad()
    }

}
