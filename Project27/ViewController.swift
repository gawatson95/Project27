//
//  ViewController.swift
//  Project27
//
//  Created by Grant Watson on 10/27/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var currentDrawType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //drawRectangle()
        drawTwin()
    }
    
    
    @IBAction func redrawTapped(_ sender: Any) {
        currentDrawType += 1
        
        if currentDrawType > 9 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0:
            //drawRectangle()
            drawTwin()
        case 1:
            drawCircle()
        case 2:
            drawCheckerboard()
        case 3:
            drawRotatedSquares()
        case 4:
            drawLines()
        case 5:
            drawImagesAndText()
        case 6:
            drawEmoji()
        case 7:
            drawTwin()
        default:
            break
        }
    }
    
    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { context in
            // Draw rectangle here
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            
            context.cgContext.setFillColor(UIColor.red.cgColor)
            context.cgContext.setStrokeColor(UIColor.black.cgColor)
            context.cgContext.setLineWidth(10)
            
            context.cgContext.addRect(rectangle)
            context.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { context in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            
            context.cgContext.setFillColor(UIColor.red.cgColor)
            context.cgContext.setStrokeColor(UIColor.black.cgColor)
            context.cgContext.setLineWidth(10)
            
            context.cgContext.addEllipse(in: rectangle)
            context.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }
    
    func drawCheckerboard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { context in
            context.cgContext.setFillColor(UIColor.black.cgColor)
            
            for row in 0 ..< 8 {
                for col in 0 ..< 8 {
                    if (row + col).isMultiple(of: 2) {
                        context.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }
        
        imageView.image = image
    }
    
    func drawRotatedSquares() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { context in
            context.cgContext.translateBy(x: 256, y: 256)
            
            let rotations = 16
            let amount = Double.pi / Double(rotations)
            
            for _ in 0 ..< rotations {
                context.cgContext.rotate(by: CGFloat(amount))
                context.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }
            
            context.cgContext.setStrokeColor(UIColor.black.cgColor)
            context.cgContext.strokePath()
        }
        
        imageView.image = image
    }
    
    func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { context in
            context.cgContext.translateBy(x: 256, y: 256)
            
            var first = true
            var length: CGFloat = 256
            
            for _ in 0 ..< 256 {
                context.cgContext.rotate(by: .pi / 2)
                
                if first {
                    context.cgContext.move(to: CGPoint(x: length, y: 50))
                    first = false
                } else {
                    context.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }
                
                length *= 0.99
            }
            
            context.cgContext.setStrokeColor(UIColor.systemIndigo.cgColor)
            context.cgContext.strokePath()
        }
        
        imageView.image = image
    }
    
    func drawImagesAndText() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { context in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
            ]
            
            let string = "Mice go sqweak!"
            
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)
            
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
        }
        
        imageView.image = image
    }
    
    func drawEmoji() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { context in
            let face = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            
            context.cgContext.setFillColor(UIColor.yellow.cgColor)
            context.cgContext.addEllipse(in: face)
            context.cgContext.drawPath(using: .fill)
            
            
            let eye = CGRect(x: 100, y: 100, width: 100, height: 100)
            context.cgContext.setFillColor(UIColor.brown.cgColor)
            context.cgContext.addEllipse(in: eye)
            context.cgContext.drawPath(using: .fill)
            
            let eye2 = CGRect(x: 300, y: 100, width: 100, height: 100)
            context.cgContext.setFillColor(UIColor.brown.cgColor)
            context.cgContext.addEllipse(in: eye2)
            context.cgContext.drawPath(using: .fill)
            
            let mouth = CGPoint(x: 100, y: 350)
            context.cgContext.move(to: mouth)
            context.cgContext.setStrokeColor(UIColor.brown.cgColor)
            context.cgContext.setLineWidth(30)
            context.cgContext.addLine(to: CGPoint(x: 400, y: 350))
            context.cgContext.strokePath()
        }
        
        imageView.image = image
    }
    
    func drawTwin() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { context in
            let ctx = context.cgContext
            
            // T
            ctx.move(to: CGPoint(x: 0, y: 100))
            ctx.addLine(to: CGPoint(x: 100, y: 100))
            ctx.move(to: CGPoint(x: 50, y: 100))
            ctx.addLine(to: CGPoint(x: 50, y: 200))
            
            // W
            ctx.move(to: CGPoint(x: 120, y: 100))
            ctx.addLine(to: CGPoint(x: 130, y: 200))
            ctx.addLine(to: CGPoint(x: 140, y: 100))
            ctx.addLine(to: CGPoint(x: 150, y: 200))
            ctx.addLine(to: CGPoint(x: 160, y: 100))
            
            // I
            ctx.move(to: CGPoint(x: 180, y: 100))
            ctx.addLine(to: CGPoint(x: 180, y: 200))
            
            // N
            ctx.move(to: CGPoint(x: 200, y: 200))
            ctx.addLine(to: CGPoint(x: 200, y: 100))
            ctx.addLine(to: CGPoint(x: 240, y: 200))
            ctx.addLine(to: CGPoint(x: 240, y: 100))
            
            ctx.strokePath()
        }
        
        imageView.image = image
    }
}

