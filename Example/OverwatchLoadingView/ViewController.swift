//
//  ViewController.swift
//  OverwatchLoadingView
//
//  Created by Archangel on 11/30/2016.
//  Copyright (c) 2016 Archangel. All rights reserved.
//

import UIKit
import OverwatchLoadingView

class ViewController: UIViewController {

    @IBOutlet weak var loadingView: OverwatchLoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadingView.animateInterval = 1.3
        loadingView.hidesWhenStopped = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadingView.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

