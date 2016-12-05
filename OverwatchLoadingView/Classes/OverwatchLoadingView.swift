import UIKit

fileprivate let numberOfHexagons = 7

fileprivate let criticalAlpha: CGFloat = 0.7 // Threshold that triggers the animation of the next hexagon

@IBDesignable public class OverwatchLoadingView: UIView {
    
    private var isAnimationHiding = false
    
    private var displayLink: CADisplayLink?
    
    private var animateIncrement: CGFloat = 1 / 20
    
    private var hexagonViews: [HexagonView] {
        return subviews.flatMap { $0 as? HexagonView }
    }
    
    @IBInspectable public var animateInterval: TimeInterval = 2 {
        didSet {
            animateIncrement = CGFloat(0.1 / animateInterval)
        }
    }
    
    @IBInspectable public var color = UIColor(red: 0.937, green: 0.608, blue: 0.196, alpha: 1.0) {
        didSet {
            hexagonViews.forEach { $0.color = color }
        }
    }
    
    @IBInspectable public var hidesWhenStopped = false
    
    private(set) public var isAnimating: Bool = false
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    deinit {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    private func setup() {
        for _ in 0..<numberOfHexagons {
            let hexagonView = HexagonView(color: self.color)
            addSubview(hexagonView)
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        let length = min(bounds.width, bounds.height)
        
        let spacing = length / 50
        
        let sqrt3: CGFloat = sqrt(3)
        
        let radius = (length - 2 * spacing) / (3 * sqrt3)
        
        let centerRadius = radius * sqrt3 + spacing
        
        hexagonViews
            .enumerated()
            .forEach { (index, view) in
                let center: CGPoint
                if index < 6 {
                    let rad = 60 * CGFloat(index - 2) / 180  * .pi // Starting from the top left hexagon
                    center = CGPoint(x: bounds.midX + centerRadius * cos(rad),
                                     y: bounds.midY + centerRadius * sin(rad))
                } else {
                    center = CGPoint(x: bounds.midX, y: bounds.midY)
                }
                
                view.radius = radius
                
                let origin = CGPoint(x: center.x - radius / 2 * sqrt3, y: center.y - radius)
                let size = CGSize(width: sqrt3 * radius, height: 2 * radius)
                
                view.frame = CGRect(origin: origin, size: size)
            }
    }
    
    public func startAnimating() {
        guard  !isAnimating else { return }
        displayLink = CADisplayLink(target: self, selector: #selector(tick(_:)))
        displayLink!.add(to: RunLoop.main, forMode: .commonModes)
        isAnimating = true
    }
    
    public func stopAnimating() {
        guard isAnimating else { return }
        displayLink?.invalidate()
        displayLink = nil
        isAnimating = false
        if hidesWhenStopped {
            hexagonViews.forEach { $0.alpha = 0 }
        }
    }
    
    @objc fileprivate func tick(_ displayLink: CADisplayLink) {
        if isAnimationHiding {
            // Hide hexagons
            hexagonViews.first?.hide(increment: animateIncrement)
            hexagonViews.enumerated()
                .forEach { (index, view) in
                    if view.alpha <= 1 - criticalAlpha {
                        if index == 6 {
                            hexagonViews.first?.show(increment: animateIncrement)
                        } else {
                            hexagonViews[index + 1].hide(increment: animateIncrement)
                        }
                        
                    }
                }
            
            if hexagonViews.last?.alpha == 0 {
                isAnimationHiding = false
            }
        } else {
            // Show hexagons
            hexagonViews.first?.show(increment: animateIncrement)
            hexagonViews.enumerated()
                .forEach { (index, view) in
                    if view.alpha >= criticalAlpha {
                        if index == 6 {
                            hexagonViews.first?.hide(increment: animateIncrement)
                        } else {
                            hexagonViews[index + 1].show(increment: animateIncrement)
                        }
                    }
                }
            if hexagonViews.last?.alpha == 1 {
                isAnimationHiding = true
            }
        }
    }

    
}

fileprivate let theta: CGFloat = .pi / 3

fileprivate let offsetFactor = tan(theta / 2)

fileprivate let sin30 = sin(30 / 180 * CGFloat.pi)

fileprivate let cos30 = cos(30 / 180 * CGFloat.pi)

fileprivate class HexagonView: UIView {
    
    var radius: CGFloat = 1
    
    var color: UIColor
    
    init(color: UIColor) {
        self.color = color
        super.init(frame: .zero)
        self.alpha = 0
        self.isOpaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate override func draw(_ rect: CGRect) {
        guard alpha != 0 else { return }
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        let radius = self.radius * alpha
        
        let cornerRadius = 0.1 * radius
        
        let offset = cornerRadius * offsetFactor
        
        let path = UIBezierPath()
        
        var point = CGPoint(x: center.x + radius * cos30, y: center.y - radius * sin30 + offset)
        
        var angle: CGFloat = .pi / 2
        
        path.move(to: point)
        
        // Draw
        for _ in 0..<6 {
            point = CGPoint(x: point.x + (radius - offset * 2) * cos(angle),
                            y: point.y + (radius - offset * 2) * sin(angle))
            
            path.addLine(to: point)
            
            let center = CGPoint(x: point.x + cornerRadius * cos(angle + .pi / 2),
                                 y: point.y + cornerRadius * sin(angle + .pi / 2))
            
            path.addArc(withCenter: center, radius: cornerRadius, startAngle: angle - .pi / 2, endAngle: angle + theta - .pi / 2, clockwise: true)
            
            point = path.currentPoint
            
            angle += theta
        }
        
        path.close()
        
        color.setFill()
        
        path.fill()
    }
    
    func show(increment: CGFloat) {
        guard alpha < 1 else { return }
        alpha = min(1, alpha + increment)
        setNeedsDisplay()
    }
    
    func hide(increment: CGFloat) {
        guard alpha > 0 else { return }
        alpha = max(0, alpha - increment)
        setNeedsDisplay()
    }
}
