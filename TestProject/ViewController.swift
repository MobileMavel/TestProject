//
//  ViewController.swift
//  TestProject
//
//  Created by Dev on 22/03/2024.

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let numbers = [5,5,4,6,2,8,3,7,1,9] // sample input
        //creating a parentview and giving the initial view width and height
        let parentView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        parentView.backgroundColor = .white
        view.addSubview(parentView)
        
        splitAndDivide(numbers, parentView: parentView)
    }
    
    func splitAndDivide(_ numbers: [Int], parentView: UIView) {
        // making sure that number count is greater than equal to 2
        guard numbers.count >= 2 else {
            print("Input list should contain at least two integers")
            return
        }

        let totalSum = numbers.reduce(0, +) //counting the sum of numbers

        guard totalSum % 2 == 0 else {
            print("Total sum of integers should be even")
            return
        }

        let targetSum = totalSum / 2

        var currentSum = 0
        var index = 0
        var firstPart: [Int] = []

        //assuming we will have equal sums
        //create the first half
        while currentSum < targetSum { //now creating groups based on the target sum
            currentSum += numbers[index]
            firstPart.append(numbers[index])
            index += 1
        }

        let secondPart = Array(numbers[index..<numbers.count]) //created the second half

        let firstSubview = UIView(frame: CGRect(x: 0, y: 0, width: parentView.bounds.width/2, height: parentView.bounds.height)) //first view
        let secondSubview = UIView(frame: CGRect(x: parentView.bounds.width/2, y: 0, width: parentView.bounds.width/2, height: parentView.bounds.height)) //second view

        parentView.addSubview(firstSubview)
        parentView.addSubview(secondSubview)

        firstSubview.translatesAutoresizingMaskIntoConstraints = false
        secondSubview.translatesAutoresizingMaskIntoConstraints = false

        //adding the constraints for the first and second half and how they are set in parent view
        NSLayoutConstraint.activate([
            firstSubview.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            firstSubview.topAnchor.constraint(equalTo: parentView.topAnchor),
            firstSubview.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            firstSubview.widthAnchor.constraint(equalTo: parentView.widthAnchor, multiplier: 0.5),

            secondSubview.leadingAnchor.constraint(equalTo: firstSubview.trailingAnchor),
            secondSubview.topAnchor.constraint(equalTo: parentView.topAnchor),
            secondSubview.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            secondSubview.widthAnchor.constraint(equalTo: parentView.widthAnchor, multiplier: 0.5)
        ])

        //now calling to create ratios of the parts and add them to the parent view
        splitAndDividePart(firstPart, parentView: firstSubview)
        splitAndDividePart(secondPart, parentView: secondSubview)

        view.layoutIfNeeded()
    }

    func splitAndDividePart(_ numbers: [Int], parentView: UIView) {
        guard !numbers.isEmpty else {
            return
        }

        let sum = numbers.reduce(0, +) //getting the total sum for which ratios are required

        var yOffset: CGFloat = 0
        for number in numbers {
            let height = parentView.bounds.height * CGFloat(number) / CGFloat(sum) //getting the height according to total sum ratio
            let subview = UIView()
            subview.backgroundColor = .random()
            subview.layer.borderColor = UIColor.black.cgColor
            subview.layer.borderWidth = 2
            parentView.addSubview(subview)

            //now setting its constraints to set them in parent view
            subview.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                subview.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
                subview.topAnchor.constraint(equalTo: parentView.topAnchor, constant: yOffset),
                subview.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
                subview.heightAnchor.constraint(equalToConstant: height)
            ])
            yOffset += height
        }
    }
}

//creating random color combo to show children
extension UIColor {
    static func random() -> UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
