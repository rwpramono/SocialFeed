//
//  PostsListVC.swift
//  SocialFeed
//
//  Created by Rachmat Wahyu Pramono on 30/03/24.
//

import Foundation
import UIKit

class PostsListVC: UIViewController {
    private var viewModel: PostsListVC
    
    init(viewModel: PostsListVC) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
