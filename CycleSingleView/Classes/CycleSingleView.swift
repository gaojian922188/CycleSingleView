//
//  CycleSingleView.swift
//  CycleSingleView
//
//  Created by 檀路生 on 2018/1/31.
//  Copyright © 2018年 檀路生. All rights reserved.
//

import UIKit
public typealias ConfigCellClouse = (UITableViewCell,Any) -> ()

public class CycleSingleView: UIView {
    var timer: DispatchSourceTimer?
    @IBOutlet weak var tableView: UITableView!
    //默认是滚动到第二行
    var curIndexPath: IndexPath = IndexPath(row: 1, section: 0)
    public var timer_repeat: Int = 1//默认一秒
    public var dataSource: Array<Any> = [] {
        didSet {
            if dataSource.count < 2 {
                return
            }
            dataSource.insert(dataSource.last as Any, at: 0)
            //启动定时器
            timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
            
            timer?.setEventHandler {
                //滚动到下一行
                if self.curIndexPath.row < self.dataSource.count {
                    self.tableView.scrollToRow(at: self.curIndexPath, at: UITableViewScrollPosition.middle, animated: true)
                    self.curIndexPath = IndexPath(row: self.curIndexPath.row + 1, section: 0)
                } else if self.curIndexPath.row == self.dataSource.count {//最后一行
                    //瞬间滚动到第一行，所谓瞬间是这里的动画设置为false
                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.middle, animated: false)

                    self.curIndexPath = IndexPath(row: 1, section: 0)
                    //瞬间到第一行后，继续滚动
                    self.tableView.scrollToRow(at: self.curIndexPath, at: UITableViewScrollPosition.middle, animated: true)
                    self.curIndexPath = IndexPath(row: self.curIndexPath.row + 1, section: 0)
                }
            }
            
            timer?.schedule(deadline: .now(), repeating: .seconds(timer_repeat))
            timer?.resume()
        }
    }
    var clouse: ConfigCellClouse!
    var reuseIdentifier: String?
    //取得view
    public class func cycleSingleView() -> CycleSingleView? {
        if let url = Bundle(for: CycleSingleView.self).url(forResource: "CycleSingleView", withExtension: "bundle"),let bundle = Bundle(url: url), let cycleSingleView = bundle.loadNibNamed("CycleSingleView", owner: nil, options: nil)?.first as? CycleSingleView {
            return cycleSingleView
        } else {
            return nil
        }
    }
    //配置弹幕cell，可以通过nib名，类名创建
    public func configCell(nibName: String?,className: String?,reuseIdentifier: String, clouse: @escaping ConfigCellClouse) {
        if let nibName = nibName {
            tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        } else if let className = className {
            tableView.register(NSClassFromString(className), forCellReuseIdentifier: reuseIdentifier)
        } else {
            fatalError("参数nibName和参数className不能都未nil")
        }
        self.reuseIdentifier = reuseIdentifier
        self.clouse = clouse
    }
    override public func awakeFromNib() {
        tableView.estimatedRowHeight = 40
    }
    
}
extension CycleSingleView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let reuseIdentifier = reuseIdentifier else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        self.clouse(cell,dataSource[indexPath.row])
        return cell
    }
}


