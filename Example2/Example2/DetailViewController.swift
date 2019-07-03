//
//  DetailViewController.swift
//  Example2
//
//  Created by Sam Meech-Ward on 2019-07-03.
//  Copyright © 2019 meech-ward. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  @IBOutlet weak var detailDescriptionLabel: UILabel!


  func configureView() {
    // Update the user interface for the detail item.
    if let detail = detailItem {
        if let label = detailDescriptionLabel {
            label.text = detail.timestamp!.description
        }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    configureView()
  }

  var detailItem: Event? {
    didSet {
        // Update the view.
        configureView()
    }
  }


}

