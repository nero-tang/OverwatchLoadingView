# OverwatchLoadingView

[![Version](https://img.shields.io/cocoapods/v/OverwatchLoadingView.svg?style=flat)](http://cocoapods.org/pods/OverwatchLoadingView)
[![License](https://img.shields.io/cocoapods/l/OverwatchLoadingView.svg?style=flat)](http://cocoapods.org/pods/OverwatchLoadingView)
[![Platform](https://img.shields.io/cocoapods/p/OverwatchLoadingView.svg?style=flat)](http://cocoapods.org/pods/OverwatchLoadingView)

Overwatching loading indicator written in Swift. This project is inspired by [OverWatchLoading](https://github.com/zhangyuChen1991/OverWatchLoading).

## Installation

OverwatchLoadingView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "OverwatchLoadingView"
```

## Example

![image](https://github.com/nero-tang/OverwatchLoadingView/blob/master/OverwatchLoadingView.gif)

### Usage

```swift
class ViewController: UIViewController {

	let loadingView = OverwatchLoadingView()

	override func viewDidLoad() {
	    super.viewDidLoad()
	
        view.addSubview(loadingView)
        
        // Custom configuration
        loadingView.animateInterval = 2
        loadingView.hidesWhenStopped = true
        loadingView.color = .red
        
        // Setup autolayout constraints as you wish
        ...
    }


    override func viewDidAppear(_ animated: Bool) {
	    super.viewDidAppear(animated)
	
		// Start animating
		loadingView.startAnimating()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Stop animating
        loadView.stopAnimating()
    }
}

```

## License

OverwatchLoadingView is available under the MIT license. See the LICENSE file for more info.
