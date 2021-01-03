//
//  KeyValueCell.swift
//  RxEndPoint
//
//  Created by David on 1/2/21.
//

import UIKit
import SnapKit

class KeyValueCell: UITableViewCell {
    
    // MARK: - PROPERTIES
    
    static let Identifier = "KVCell"
    
    lazy var keyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    // MARK: - FUNCTIONS
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configureView() {
        contentView.addSubview(keyLabel)
        contentView.addSubview(valueLabel)
        
        keyLabel.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.left.equalTo(5)
            make.width.equalTo(80)
            make.bottom.equalTo(-5)
        }
        
        valueLabel.snp.makeConstraints { (make) in
            make.top.equalTo(5)
            make.left.equalTo(keyLabel.snp.right).offset(10)
            make.right.equalTo(5)
            make.bottom.equalTo(-5)
        }
    }

    static func dequeueReuseable(from tableView: UITableView) -> KeyValueCell {
        let reuseCell = tableView.dequeueReusableCell(withIdentifier: Identifier)
        if let cell = reuseCell as? KeyValueCell {
            return cell
        } else {
            return KeyValueCell(style: .default, reuseIdentifier: Identifier)
        }
    }
}
