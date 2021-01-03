//
//  HistoryListViewController.swift
//  RxEndPoint
//
//  Created by David on 1/2/21.
//

import UIKit
import RxSwift


class HistoryListViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    private let bag = DisposeBag()
    private let viewModel = HistoryListViewModel()

    lazy private var mTable: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.register(HistoryListCell.self, forCellReuseIdentifier: "HisCell")
        return table
    }()
    
    // MARK: - FUNCTIONS
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = .white
        
        title = "History"
        
        view.addSubview(mTable)
        
        mTable.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
        viewModel.records
            .bind(to: mTable.rx.items(cellIdentifier: "HisCell", cellType: HistoryListCell.self)) { row, rcd, cell in
                cell.textLabel?.text = rcd.timeInterval.toDateString()
            }
            .disposed(by: bag)
        mTable.rx.modelSelected(Record.self)
            .subscribe { [weak self] in
                let hdvc = HistoryDetailViewController()
                hdvc.record = $0.element
                self?.navigationController?.pushViewController(hdvc, animated: true)
            }
            .disposed(by: bag)

        viewModel.fetch()
    }
}

extension HistoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
