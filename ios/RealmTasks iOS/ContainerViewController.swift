////////////////////////////////////////////////////////////////////////////
//
// Copyright 2016 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

import Cartography
import RealmSwift
import UIKit

class ContainerViewController: UIViewController {
    private var titleLabel = UILabel()
    private var titleTopConstraint: NSLayoutConstraint?
    override var title: String? {
        didSet {
            if let title = title {
                titleLabel.text = title
                ZeroKitManager.shared.zeroKit.decrypt(cipherText: title) { [weak self] plainText, _ in
                    if let plainText = plainText, let currentTitle = self?.title, currentTitle == title {
                        self?.titleLabel.text = plainText
                    }
                }
            }
            titleTopConstraint?.constant = (title != nil) ? 20 : 0
            UIView.animate(withDuration: 0.2) {
                self.titleLabel.alpha = (self.title != nil) ? 1 : 0
                self.titleLabel.superview?.layoutIfNeeded()
            }
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVC()
        setupTitleBar()
    }

    private func addChildVC() {
        let firstList = try! Realm().objects(TaskList.self).first!
        let vc = ViewController(parent: firstList, colors: UIColor.taskColors())
        title = firstList.text
        addChildViewController(vc)
        view.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
    }

    private func setupTitleBar() {
        let titleBar = UIToolbar()
        titleBar.barStyle = .blackTranslucent
        view.addSubview(titleBar)
        constrain(titleBar) { titleBar in
            titleBar.left == titleBar.superview!.left
            titleBar.top == titleBar.superview!.top
            titleBar.right == titleBar.superview!.right
            titleBar.height >= 20
            titleBar.height == 20 ~ UILayoutPriorityDefaultHigh
        }

        titleLabel.font = .boldSystemFont(ofSize: 13)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleBar.addSubview(titleLabel)
        constrain(titleLabel) { titleLabel in
            titleLabel.left == titleLabel.superview!.left
            titleLabel.right == titleLabel.superview!.right
            titleLabel.bottom == titleLabel.superview!.bottom - 5
            titleTopConstraint = (titleLabel.top == titleLabel.superview!.top + 20)
        }
    }
}
