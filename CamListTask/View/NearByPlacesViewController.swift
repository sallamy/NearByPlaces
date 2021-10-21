//
//  NearByPlacesViewController.swift
//  CamListTask
//
//  Created by mohamed salah on 10/21/21.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa
import SVProgressHUD

class NearByPlacesViewController: UIViewController, UITableViewDelegate {
    
    let disposeBag = DisposeBag()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    lazy var emptySate: EmptyErrorSateView = {
        let view = EmptyErrorSateView(state: .empty)
        view.isHidden = true
        return view
    }()
    
    var viewModel: NearByPlacesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = NearByPlacesViewModel()
        observeError()
        observeLoading()
        observeEmpty()
        registerTableView()
        buidUI()
        bindTableView()
        
        // Do any additional setup after loading the view.
    }
    
    func observeLoading() {
        viewModel?.isLoading.asObservable().subscribe { status in
            if let state = status.element, state == true{
                SVProgressHUD.show()
            }else {
                self.emptySate.isHidden = true
                SVProgressHUD.dismiss()
            }
        }.disposed(by: disposeBag)
    }
    
    func observeError() {
        viewModel?.error.asObservable().subscribe { status in
            if let error = status.element, error != "" {
                self.emptySate.state = .error
                self.emptySate.isHidden = false
            }
            print(status)
        }.disposed(by: disposeBag)
    }
    
    func observeEmpty() {
        viewModel?.isGetData.asObservable().subscribe { status in
            if let state = status.element, state == true, let places = self.viewModel?.places.value, places.isEmpty{
                self.emptySate.state = .empty
                self.emptySate.isHidden = false
            }
            
            print(status)
        }.disposed(by: disposeBag)
    }
    
    
    func buidUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: self.viewModel?.mode.title, style: .plain, target: self, action: #selector(modeTapped))
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.tableView)
        self.tableView.setConstraints(top: self.view.safeAreaLayoutGuide.topAnchor, bottom: self.view.bottomAnchor, leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor, paddingTop: 16,paddingLeading: 16, paddingTrailing: 16)
        view.addSubview(emptySate)
        emptySate.setConstraints( centerX: self.view.centerXAnchor, centerY: self.view.centerYAnchor,leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor )
    }
    
    func registerTableView(){
        self.tableView.register(NearByCellTableViewCell.self, forCellReuseIdentifier: NearByCellTableViewCell.idenetifier)
    }
    
    func bindTableView(){
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        self.viewModel?.places.bind(to: tableView.rx.items(cellIdentifier: NearByCellTableViewCell.idenetifier)) { row, dataSource, cell in
            guard let cell = cell as? NearByCellTableViewCell else { return }
            cell.setupData(model: dataSource)
        }
        .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func modeTapped(){
        switch self.viewModel?.mode {
        case .realTime:
            UserDefaults.standard.set(Mode.single.rawValue, forKey: "mode")
        case .single:
            UserDefaults.standard.set(Mode.realTime.rawValue, forKey: "mode")
            self.viewModel?.startRealtime()
        case .none:
            break
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: self.viewModel?.mode.title, style: .plain, target: self, action: #selector(modeTapped))
    }
}
