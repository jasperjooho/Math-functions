//
//  displayViewController.swift
//  Math functions
//
//  Created by user on 4/9/17.
//  Copyright © 2017 Obsearch Applications. All rights reserved.
//

import UIKit

class displayViewController: UIViewController {

    // MARK: - Properties
    var selectedFunction = ""
    let barHeight = UIApplication.shared.statusBarFrame.size.height
    var currentViewController:UIViewController?
    
    // General Properties
    let backButton = UIButton()
    let errorView:UIView = UIView()
    let errorLabel:UILabel = UILabel()
    var timer:Timer?
    var resultsArray = [String]()
    let resultsLabel:UILabel = UILabel()
    var faveMathFunctions = [String]()
    var faveButton:UIButton!
    
    // Binomial Expander properties
    let lBracket:UILabel = UILabel()
    let no1Field:DecimalMinusTextField = DecimalMinusTextField()
    let x1:UILabel = UILabel()
    let power1Field:DecimalMinusTextField = DecimalMinusTextField()
    let plus:UILabel = UILabel()
    let coField:DecimalMinusTextField = DecimalMinusTextField()
    let x2:UILabel = UILabel()
    let power2:DecimalMinusTextField = DecimalMinusTextField()
    let rBracket:UILabel = UILabel()
    let powerW:DecimalMinusTextField = DecimalMinusTextField()
    
    // Matrice Inverter Properties
    let matrixInverterA:DecimalMinusTextField = DecimalMinusTextField()
    let matrixInverterB:DecimalMinusTextField = DecimalMinusTextField()
    let matrixInverterC:DecimalMinusTextField = DecimalMinusTextField()
    let matrixInverterD:DecimalMinusTextField = DecimalMinusTextField()
    
    // Straight Line Equation Finder Propertiess
    let lineEquationFinderCoordinate1Label:UILabel = UILabel()
    let lineEquationFinderCoordinate2Label:UILabel = UILabel()
    let lineEquationFinderLeftBracket1:UILabel = UILabel()
    let lineEquationFinderRightBracket1:UILabel = UILabel()
    let lineEquationFinderComma1:UILabel = UILabel()
    let lineEquationFinderLeftBracket2:UILabel = UILabel()
    let lineEquationFinderRightBracket2:UILabel = UILabel()
    let lineEquationFinderComma2:UILabel = UILabel()
    let lineEquationFinderX1:DecimalMinusTextField = DecimalMinusTextField()
    let lineEquationFinderY1:DecimalMinusTextField = DecimalMinusTextField()
    let lineEquationFinderX2:DecimalMinusTextField = DecimalMinusTextField()
    let lineEquationFinderY2:DecimalMinusTextField = DecimalMinusTextField()
    var lineEquationFinderGraphView:GraphView!
    var lineEquationFinderInitialTouchPoint = CGPoint()
    var lineEquationFinderGradient:Double = 0.0
    var lineEquationFinderC:Double = 0.0
    var lineEquationFinderMaxX = 5
    var lineEquationFinderMinX = -5
    var lineEquationFinderMaxY = 5
    var lineEquationFinderMinY = -5
    var lineEquationFinderRangeX = 10.0
    var lineEquationFinderRangeY = 10.0
    
    // Matrix Multiplier Properties
    var matrixMultiplierLeftBracket1:UILabel!
    var matrixMultiplierRightBracket1:UILabel!
    var matrixMultiplierLeftBracket2:UILabel!
    var matrixMultiplierRightBracket2:UILabel!
    var matrixMultiplier11:DecimalMinusTextField = DecimalMinusTextField()
    var matrixMultiplier21:DecimalMinusTextField = DecimalMinusTextField()
    var matrixMultiplier31:DecimalMinusTextField = DecimalMinusTextField()
    var matrixMultiplier41:DecimalMinusTextField = DecimalMinusTextField()
    var matrixMultiplier51:DecimalMinusTextField = DecimalMinusTextField()
    var matrixMultiplier61:DecimalMinusTextField = DecimalMinusTextField()
    var matrixMultiplier71:DecimalMinusTextField = DecimalMinusTextField()
    var matrixMultiplier81:DecimalMinusTextField = DecimalMinusTextField()
    var matrixMultiplier91:DecimalMinusTextField = DecimalMinusTextField()
    var matrixMultiplier12:DecimalMinusTextField = DecimalMinusTextField()
    var matrixMultiplier22:DecimalMinusTextField = DecimalMinusTextField()
    var matrixMultiplier32:DecimalMinusTextField = DecimalMinusTextField()
    var matrixMultiplier42:DecimalMinusTextField = DecimalMinusTextField()
    var matrixMultiplier52:DecimalMinusTextField = DecimalMinusTextField()
    var matrixMultiplier62:DecimalMinusTextField = DecimalMinusTextField()
    var matrixMultiplier72:DecimalMinusTextField = DecimalMinusTextField()
    var matrixMultiplier82:DecimalMinusTextField = DecimalMinusTextField()
    var matrixMultiplier92:DecimalMinusTextField = DecimalMinusTextField()
    var matrixMultiplierRow1 = 2
    var matrixMultiplierColumn1 = 2
    var matrixMultiplierRow2 = 2
    var matrixMultiplierColumn2 = 2
    var matrixMultiplierRow1Label:UILabel!
    var matrixMultiplierColumn1Label:UILabel!
    var matrixMultiplierRow2Label:UILabel!
    var matrixMultiplierColumn2Label:UILabel!
    var matrixMultiplierRow1TextField:DecimalMinusTextField = DecimalMinusTextField()
    var matrixMultiplierColumn1TextField:DecimalMinusTextField = DecimalMinusTextField()
    var matrixMultiplierRow2TextField:DecimalMinusTextField = DecimalMinusTextField()
    var matrixMultiplierColumn2TextField:DecimalMinusTextField = DecimalMinusTextField()
    var matrixMultiplierXLabel:UILabel!
    
    // Standard To Vertex Form Properties
    var standardToVertexA:DecimalMinusTextField = DecimalMinusTextField()
    var standardToVertexB:DecimalMinusTextField = DecimalMinusTextField()
    var standardToVertexC:DecimalMinusTextField = DecimalMinusTextField()
    
    // Cosine Rules Properties
    var cRuleSide1TextField:DecimalMinusTextField = DecimalMinusTextField()
    var cRuleSide2TextField:DecimalMinusTextField = DecimalMinusTextField()
    var cRuleSide3Angle1TextField:DecimalMinusTextField = DecimalMinusTextField()
    var cRuleFindAngle = false
    var cRuleSwitch:UISwitch = UISwitch()
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadFaves()
        view.isUserInteractionEnabled = true
        
        // Set up notification to listen for Notification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShowing), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHiding), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        view.backgroundColor = .black
        
        // Set up the general properties
        createTopBar()
        createResultsBox()
        createCalculateButton()
        createFaveButton()
        
        // Set the function that is selected
        if selectedFunction == "Binomial Expander" {
            createBinomialExpander()
        } else if selectedFunction == "2x2 Matrix Inverter" {
            createMatrixInverter()
        } else if selectedFunction == "Straight Line Equation Finder" {
            createStraightLineEquationFinder()
        } else if selectedFunction == "Matrix Multiplier" {
            createMatrixMultiplier()
        } else if selectedFunction == "Quadratic: Standard to Vertex" {
            createQuadraticStandardToVertex()
        } else if selectedFunction == "Cosine Rule" {
            createGeneralCRuleLayout()
            createSpecificCRuleLayout()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 2436:
                return false
            default:
                return true
            }
        }
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Hide Keyboard
        hideKeyBoard()
    }
    
    // MARK: - General layout functions
    
    func createCalculateButton() {
        
        let width = view.frame.width
        let height = view.frame.height
        
        // Create calculate button
        let calculateButton:UIButton = UIButton(type: .system)
        view.addSubview(calculateButton)
        calculateButton.backgroundColor = .gray
        calculateButton.setTitle("Calculate", for: .normal)
        calculateButton.setTitleColor(.black, for: .normal)
        calculateButton.addTarget(self, action: #selector(calculateTapped), for: .touchUpInside)
        calculateButton.layer.cornerRadius = (height / 18) / 2
        calculateButton.adjustsImageWhenHighlighted = true
        calculateButton.translatesAutoresizingMaskIntoConstraints = false
        
        let calculateButtonHeightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: calculateButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height / 18)
        let calculateButtonWidthConstraint:NSLayoutConstraint = NSLayoutConstraint(item: calculateButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width / 2)
        let calculateButtonLeftConstraint:NSLayoutConstraint = NSLayoutConstraint(item: calculateButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let calculateButtonTopConstraint:NSLayoutConstraint = NSLayoutConstraint(item: calculateButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: height / 2.4 + barHeight)
        calculateButton.addConstraints([calculateButtonWidthConstraint, calculateButtonHeightConstraint])
        view.addConstraints([calculateButtonTopConstraint, calculateButtonLeftConstraint])
        
    }
    
    func createTopBar() {
        
        let height = view.frame.height
        let width = view.frame.width
        
        // Create back button
        view.addSubview(backButton)
        backButton.setImage(UIImage(named: "backButton"), for: .normal)
        backButton.contentMode = .scaleToFill
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        let backButtonHeightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: backButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height / 20)
        let backButtonWidthConstraint:NSLayoutConstraint = NSLayoutConstraint(item: backButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height / 20)
        let backButtonLeftConstraint:NSLayoutConstraint = NSLayoutConstraint(item: backButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: width / 30)
        let backButtonTopConstraint:NSLayoutConstraint = NSLayoutConstraint(item: backButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: barHeight + height / 30)
        
        backButton.addConstraints([backButtonWidthConstraint, backButtonHeightConstraint])
        view.addConstraints([backButtonLeftConstraint, backButtonTopConstraint])
        
        let title:UILabel = UILabel()
        view.addSubview(title)
        title.text = selectedFunction
        title.textAlignment = .center
        title.textColor = .white
        title.font = UIFont(name: "Courier", size: height / 40)
        title.adjustsFontSizeToFitWidth = true
        title.numberOfLines = 0
        //        title.backgroundColor = .black
        title.translatesAutoresizingMaskIntoConstraints = false
        
        let titleCenterY:NSLayoutConstraint = NSLayoutConstraint(item: title, attribute: .centerY, relatedBy: .equal, toItem: backButton, attribute: .centerY, multiplier: 1, constant: 0)
        let titleLeft:NSLayoutConstraint = NSLayoutConstraint(item: title, attribute: .left, relatedBy: .equal, toItem: backButton, attribute: .right, multiplier: 1, constant: 5)
        let titleHeight:NSLayoutConstraint = NSLayoutConstraint(item: title, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height / 10)
        let titleRight:NSLayoutConstraint = NSLayoutConstraint(item: title, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 5)
        view.addConstraints([titleCenterY, titleLeft, titleRight])
        title.addConstraint(titleHeight)

    }
    
    func createResultsBox() {
        
        let height = view.frame.height
        let width = view.frame.width
        
        // Create line in middle for decoration
        let middleLine:UIView = UIView()
        view.addSubview(middleLine)
        middleLine.backgroundColor = .white
        middleLine.translatesAutoresizingMaskIntoConstraints = false
        
        let middleHeightContraint:NSLayoutConstraint = NSLayoutConstraint(item: middleLine, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 2)
        let middleWidthContraint:NSLayoutConstraint = NSLayoutConstraint(item: middleLine, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: width - width / 20)
        let middleTopContraint:NSLayoutConstraint = NSLayoutConstraint(item: middleLine, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: height / 2 + barHeight)
        let middleLeftContraint:NSLayoutConstraint = NSLayoutConstraint(item: middleLine, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: width / 40)
        middleLine.addConstraints([middleWidthContraint, middleHeightContraint])
        view.addConstraints([middleTopContraint, middleLeftContraint])
        
        // Add results label
        view.addSubview(resultsLabel)
        resultsLabel.text = "Results"
        resultsLabel.textColor = .white
        resultsLabel.textAlignment = .center
        resultsLabel.adjustsFontSizeToFitWidth = true
        resultsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let resultsLabelHeight:NSLayoutConstraint = NSLayoutConstraint(item: resultsLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height / 15)
        let resultsLabelWidth:NSLayoutConstraint = NSLayoutConstraint(item: resultsLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width / 2)
        let resultsLabelTop:NSLayoutConstraint = NSLayoutConstraint(item: resultsLabel, attribute: .top, relatedBy: .equal, toItem: middleLine, attribute: .bottom, multiplier: 1, constant: 0)
        let resultsLabelLeading:NSLayoutConstraint = NSLayoutConstraint(item: resultsLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: width / 4)
        
        resultsLabel.addConstraints([resultsLabelHeight, resultsLabelWidth])
        view.addConstraints([resultsLabelTop, resultsLabelLeading])
        
        
    }
    
    func createFaveButton() {
        
        let height = view.frame.height
        let width = view.frame.width
        
        faveButton = UIButton(frame: CGRect(x: 6.5 * width / 8, y: height / 2.4 + barHeight, width: height / 18, height: height / 18))
        view.addSubview(faveButton)
        setFaveButtonImage()
        backButton.contentMode = .scaleToFill
        faveButton.addTarget(self, action: #selector(faveButtonPressed), for: .touchUpInside)
    }
    
    func setFaveButtonImage() {
        if faveMathFunctions.contains(selectedFunction) {
            faveButton.setImage(UIImage(named: "favouriteFilled"), for: .normal)
        } else {
            faveButton.setImage(UIImage(named: "favourite"), for: .normal)
        }
    }
    
    @objc func faveButtonPressed(sender: UIButton!) {
        
        toggleFave(function: selectedFunction)
    }
    
    @objc func backButtonPressed(sender: UIButton!) {
        
        performSegue(withIdentifier: "goToHome", sender: self)
    }
    
    @objc func calculateTapped(sender: UIButton) {
        
        hideKeyBoard()
        
        if selectedFunction == "Binomial Expander" {
            createBinomialExpanderResults()
        } // End of Binomial expander
        else if selectedFunction == "2x2 Matrix Inverter" {
            createMatrixInverterResults()
        } else if selectedFunction == "Straight Line Equation Finder" {
            createStraightLineEquationFinderResults()
        } else if selectedFunction == "Matrix Multiplier" {
            createMatrixMultiplierResults()
        } else if selectedFunction == "Quadratic: Standard to Vertex" {
            createQuadraticStandardToVertexResults()
        } else if selectedFunction == "Cosine Rule" {
            cRuleCalculateAnswersAndDisplay()
        }
        
        resultsArray = []
    }
    
    // MARK: - Binomial Expander Functions
    
    func createBinomialExpander() {
        
        // Create variables
        let width = view.frame.width
        let height = view.frame.height
        _ = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
        let text1:CGFloat = width / 10 * 1.5
        let text2:CGFloat = width / 10 * 1.7
        
        // Create left Bracket
        createLabel(lBracket, text2)
        lBracket.text = "("
        lBracket.textColor = .white
        let lBracketLeftConstraint:NSLayoutConstraint = NSLayoutConstraint(item: lBracket, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: width / 15)
        view.addConstraint(lBracketLeftConstraint)
        
        // Create 1st x label
        createLabel(x1, text1)
        x1.text = "x"
        x1.textColor = .white
        let x1LeftConstraint:NSLayoutConstraint = NSLayoutConstraint(item: x1, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: width / 4.1)
        view.addConstraint(x1LeftConstraint)
        
        // Create no1 text field
        createTextField(no1Field)
        let no1FieldCenterYConstraint:NSLayoutConstraint = NSLayoutConstraint(item: no1Field, attribute: .centerY, relatedBy: .equal, toItem: x1, attribute: .centerY, multiplier: 1, constant: (height / 500))
        let no1FieldLeftConstraint:NSLayoutConstraint = NSLayoutConstraint(item: no1Field, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: width / 7)
        view.addConstraints([no1FieldCenterYConstraint, no1FieldLeftConstraint])
        
        // Create power of 1st x text field
        createTextField(power1Field)
        let power1FieldTopConstraint:NSLayoutConstraint = NSLayoutConstraint(item: power1Field, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: height / 4.3 + barHeight)
        let power1FieldLeftConstraint:NSLayoutConstraint = NSLayoutConstraint(item: power1Field, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: width / 3)
        view.addConstraints([power1FieldTopConstraint, power1FieldLeftConstraint])
        
        // Create + Label
        createLabel(plus, text1)
        plus.textColor = .white
        plus.text = "+"
        let plusLeftConstraint:NSLayoutConstraint = NSLayoutConstraint(item: plus, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: width / 2.3)
        view.addConstraint(plusLeftConstraint)
        
        
        // Create coefficient of x text field
        createTextField(coField)
        let coFieldCenterYConstraint:NSLayoutConstraint = NSLayoutConstraint(item: coField, attribute: .centerY, relatedBy: .equal, toItem: x1, attribute: .centerY, multiplier: 1, constant: (height / 500))
        let coFieldLeftConstraint:NSLayoutConstraint = NSLayoutConstraint(item: coField, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: width / 1.9)
        view.addConstraints([coFieldCenterYConstraint, coFieldLeftConstraint])
        
        // Create 2nd x label
        createLabel(x2, text1)
        x2.text = "x"
        x2.textColor = .white
        let x2LeftConstraint:NSLayoutConstraint = NSLayoutConstraint(item: x2, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: width / 1.6)
        view.addConstraint(x2LeftConstraint)
        
        // Create power of 2nd x text field
        createTextField(power2)
        let power2FieldTopConstraint:NSLayoutConstraint = NSLayoutConstraint(item: power2, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: height / 4.3 + barHeight)
        let power2FieldLeftConstraint:NSLayoutConstraint = NSLayoutConstraint(item: power2, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: width / 1.4)
        view.addConstraints([power2FieldTopConstraint, power2FieldLeftConstraint])

        // Create right bracket
        createLabel(rBracket, text2)
        rBracket.text = ")"
        rBracket.textColor = .white
        let rBracketRightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: rBracket, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: width / 1.25)
        view.addConstraint(rBracketRightConstraint)
        
        // Create power of whole thing text field
        createTextField(powerW)
        let powerWFieldTopConstraint:NSLayoutConstraint = NSLayoutConstraint(item: powerW, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: height / 4.3 + barHeight)
        let powerWFieldLeftConstraint:NSLayoutConstraint = NSLayoutConstraint(item: powerW, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: width / 1.13)
        view.addConstraints([powerWFieldTopConstraint, powerWFieldLeftConstraint])
        
    }
    
    func createBinomialExpanderResults() {
        
        // Set variables
        let height = view.frame.height
        let coFieldText = coField.text
        let no1FieldText = no1Field.text
        let power1FieldText = power1Field.text
        let powerWFieldText = powerW.text
        let power2FieldText = power2.text
        let allTexts = String(coFieldText! + no1FieldText! + power1FieldText! + powerWFieldText! + power2FieldText!)
        
        let slashSet = CharacterSet(charactersIn: "/")
        
        // Give errors
        if Double(coFieldText!) == nil || Double(no1FieldText!) == nil || Double(power1FieldText!) == nil || Double(powerWFieldText!) == nil || Double(power2FieldText!) == nil {
            
            if allTexts.rangeOfCharacter(from: slashSet) != nil {
                createErrorMessage("Please use decimal instead of fraction")
            } else {
                createErrorMessage("Please ensure all blanks contain numbers")
            }
        } else if Int(powerWFieldText!) == nil && Double(coFieldText!) != nil && Double(no1FieldText!) != nil && Double(power1FieldText!) != nil && Double(powerWFieldText!) != nil && Double(power2FieldText!) != nil  {
            createErrorMessage("Power of whole thing must be an integer")
        } else if Int(powerWFieldText!)! > 20 {
            
            createErrorMessage("Power of whole thing can't be higher than 20")
            
        } else if Int(powerWFieldText!)! < 1 {
            
            createErrorMessage("Power of whole thing can't be less than 1")
        } else {
            
            // Reset answers
            if let viewWithTag = view.viewWithTag(1) {
                viewWithTag.removeFromSuperview()
                
            }
            
            // Set variables
            let a = Double(no1FieldText!)
            let p1 = Double(power1FieldText!)
            let b = Double(coFieldText!)
            let p2 = Double(power2FieldText!)
            let n = Int(powerWFieldText!)
            let nDouble = Double(powerWFieldText!)
            let range = n!
            
            // Loop through each number
            for r in 0...range {
                
                let rDouble = Double(r)
                let m = factorial(n!) / (factorial(r) * factorial(n! - r))
                
                let co = Double(m) * (pow(a!, (nDouble!-rDouble))) * (pow(b!, rDouble))
                let Ap = p1! * (nDouble!-rDouble)
                let Bp = p2! * rDouble
                let Sp = Ap + Bp
                
                var finalResult = ""
                if Sp == 0 {
                    finalResult = String(co)
                } else if Sp == 1 {
                    finalResult = String(co) + "x"
                } else {
                    finalResult = String(co) + "x^" + String(Sp)
                }
                
                resultsArray.append(finalResult)
                
            } // End of loop
            
            var top:CGFloat = 0
            var number = 1
            
            // Create scroll view for the results
            let resultScrollView:UIScrollView! = UIScrollView()
            view.addSubview(resultScrollView)
            resultScrollView.tag = 1
            resultScrollView.isScrollEnabled = true
            resultScrollView.translatesAutoresizingMaskIntoConstraints = false
            let resultScrollTop:NSLayoutConstraint = NSLayoutConstraint(item: resultScrollView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: (height / 2) + 2 + (height / 15) + barHeight)
            let resultScrollLeading:NSLayoutConstraint = NSLayoutConstraint(item: resultScrollView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
            let resultScrollBottom:NSLayoutConstraint = NSLayoutConstraint(item: resultScrollView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: -20)
            let resultScrollTrailing:NSLayoutConstraint = NSLayoutConstraint(item: resultScrollView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
            view.addConstraints([resultScrollTop, resultScrollLeading, resultScrollBottom, resultScrollTrailing])
            
            // Add the results view
            let resultsView:UIView! = UIView()
            resultScrollView.addSubview(resultsView)
            resultsView.translatesAutoresizingMaskIntoConstraints = false
            let resultsTop:NSLayoutConstraint = NSLayoutConstraint(item: resultsView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: resultScrollView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
            let resultsLeading:NSLayoutConstraint = NSLayoutConstraint(item: resultsView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: resultScrollView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
            let resultsBottom:NSLayoutConstraint = NSLayoutConstraint(item: resultsView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: resultScrollView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
            let resultsTrailing:NSLayoutConstraint = NSLayoutConstraint(item: resultsView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: resultScrollView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
            let resultsWidth:NSLayoutConstraint = NSLayoutConstraint(item: resultsView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: view.frame.width)
            let resultsHeight:NSLayoutConstraint = NSLayoutConstraint(item: resultsView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: CGFloat(resultsArray.count) * (height / 20))
            resultsView.addConstraints([resultsWidth, resultsHeight])
            view.addConstraints([resultsTop, resultsLeading, resultsBottom, resultsTrailing])
            
            for results in resultsArray {
                
                let height1:CGFloat = view.frame.height / 20
                
                let resultsLabel:UILabel! = UILabel()
                resultsView.addSubview(resultsLabel)
                resultsLabel.text = String(number) + ". " + results
                resultsLabel.textColor = .white
                resultsLabel.translatesAutoresizingMaskIntoConstraints = false
                
                let resultsTopConstraint:NSLayoutConstraint = NSLayoutConstraint(item: resultsLabel, attribute: .top, relatedBy: .equal, toItem: resultsView, attribute: .top, multiplier: 1, constant: top)
                let resultsLeadingConstraint:NSLayoutConstraint = NSLayoutConstraint(item: resultsLabel, attribute: .leading, relatedBy: .equal, toItem: resultsView, attribute: .leading, multiplier: 1, constant: view.frame.width / 20)
                let resultsHeightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: resultsLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height1)
                let resultsWidthConstraint:NSLayoutConstraint = NSLayoutConstraint(item: resultsLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: view.frame.width - (view.frame.width / 20))
                resultsLabel.addConstraints([resultsHeightConstraint, resultsWidthConstraint])
                resultScrollView.addConstraints([resultsTopConstraint, resultsLeadingConstraint])
                
                top += height1
                number += 1
            }
        }
    }
    
    // MARK: - Matrix Inverter Functions
    
    func createMatrixInverter() {
        
        // Properties
        let width = view.frame.width
        let height = view.frame.height
        let bracketSize:CGFloat = width / 2.5
        
        // Create first bracket
        let firstBracket:UILabel = UILabel()
        createLabel(firstBracket, bracketSize)
        firstBracket.text = "["
        firstBracket.textColor = .white
        let firstBracketLeftConstraint:NSLayoutConstraint = NSLayoutConstraint(item: firstBracket, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: width / 5)
        view.addConstraint(firstBracketLeftConstraint)
        
        // Create second bracket
        let secondBracket:UILabel = UILabel()
        createLabel(secondBracket, bracketSize)
        secondBracket.text = "]"
        secondBracket.textColor = .white
        
        let secondBracketRightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: secondBracket, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -width / 5)
        view.addConstraint(secondBracketRightConstraint)
        
        // Implement a, b, c and d textfields
        createTextField(matrixInverterA)
        matrixInverterA.placeholder = "a"
        let matrixInverterALeftConstraint:NSLayoutConstraint = NSLayoutConstraint(item: matrixInverterA, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: width / 2.8)
        let matrixInverterATopConstraint:NSLayoutConstraint = NSLayoutConstraint(item: matrixInverterA, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: height / 4.4 + barHeight)
        view.addConstraints([matrixInverterALeftConstraint, matrixInverterATopConstraint])
        
        createTextField(matrixInverterB)
        matrixInverterB.placeholder = "b"
        let matrixInverterBRightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: matrixInverterB, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -width / 2.8)
        let matrixInverterBTopConstraint:NSLayoutConstraint = NSLayoutConstraint(item: matrixInverterB, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: height / 4.4 + barHeight)
        view.addConstraints([matrixInverterBRightConstraint, matrixInverterBTopConstraint])
        
        createTextField(matrixInverterC)
        matrixInverterC.placeholder = "c"
        let matrixInverterCLeftConstraint:NSLayoutConstraint = NSLayoutConstraint(item: matrixInverterC, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: width / 2.8)
        let matrixInverterCTopConstraint:NSLayoutConstraint = NSLayoutConstraint(item: matrixInverterC, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: height / 3.3 + barHeight)
        view.addConstraints([matrixInverterCLeftConstraint, matrixInverterCTopConstraint])
        
        createTextField(matrixInverterD)
        matrixInverterD.placeholder = "d"
        let matrixInverterDRightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: matrixInverterD, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -width / 2.8)
        let matrixInverterDTopConstraint:NSLayoutConstraint = NSLayoutConstraint(item: matrixInverterD, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: height / 3.3 + barHeight)
        view.addConstraints([matrixInverterDRightConstraint, matrixInverterDTopConstraint])
        
    }
    
    func createMatrixInverterResults() {
        
        // Properties
        let height = view.frame.height
        let a = matrixInverterA.text
        let b = matrixInverterB.text
        let c = matrixInverterC.text
        let d = matrixInverterD.text
        let allTexts = String(a! + b! + c! + d!)
        
        // Check for errors
        if Double(a!) == nil || Double(b!) == nil || Double(c!) == nil || Double(d!) == nil {
            
            let charset = CharacterSet(charactersIn: "/")
            if allTexts.rangeOfCharacter(from: charset) != nil {
                createErrorMessage("Please use decimal instead of fraction")
            } else {
                createErrorMessage("Ensure all blanks contain numbers")
            }
        } else {
            
            let denominator = Double(a!)! * Double(d!)! - Double(b!)! * Double(c!)!
            
            if denominator == 0 {
                createErrorMessage("Unable to Calculate, ad-bc can't be 0")
            } else {
                
                // Reset answers
                if let viewWithTag = view.viewWithTag(1) {
                    viewWithTag.removeFromSuperview()
                    
                }
                
                // Add results to array
                resultsArray.append(d!)
                resultsArray.append("-" + b!)
                resultsArray.append("-" + c!)
                resultsArray.append(a!)
                
                var top:CGFloat = 0
                var number = 0
                
                // Create scroll view for the results
                let resultScrollView:UIScrollView! = UIScrollView()
                view.addSubview(resultScrollView)
                resultScrollView.tag = 1
                resultScrollView.isScrollEnabled = true
                resultScrollView.isUserInteractionEnabled = true
                resultScrollView.translatesAutoresizingMaskIntoConstraints = false
                let resultScrollTop:NSLayoutConstraint = NSLayoutConstraint(item: resultScrollView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: (height / 2) + 2 + (height / 15) + barHeight)
                let resultScrollLeading:NSLayoutConstraint = NSLayoutConstraint(item: resultScrollView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
                let resultScrollBottom:NSLayoutConstraint = NSLayoutConstraint(item: resultScrollView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: -20)
                let resultScrollTrailing:NSLayoutConstraint = NSLayoutConstraint(item: resultScrollView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
                view.addConstraints([resultScrollTop, resultScrollLeading, resultScrollBottom, resultScrollTrailing])
                
                // Add the results view
                let resultsView:UIView! = UIView()
                resultScrollView.addSubview(resultsView)
                resultScrollView.isUserInteractionEnabled = true
                resultsView.translatesAutoresizingMaskIntoConstraints = false
                let resultsTop:NSLayoutConstraint = NSLayoutConstraint(item: resultsView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: resultScrollView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
                let resultsLeading:NSLayoutConstraint = NSLayoutConstraint(item: resultsView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: resultScrollView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
                let resultsBottom:NSLayoutConstraint = NSLayoutConstraint(item: resultsView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: resultScrollView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
                let resultsTrailing:NSLayoutConstraint = NSLayoutConstraint(item: resultsView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: resultScrollView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
                let resultsWidth:NSLayoutConstraint = NSLayoutConstraint(item: resultsView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: view.frame.width)
                let resultsHeight:NSLayoutConstraint = NSLayoutConstraint(item: resultsView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: CGFloat(resultsArray.count) * (height / 20))
                resultsView.addConstraints([resultsWidth, resultsHeight])
                view.addConstraints([resultsTop, resultsLeading, resultsBottom, resultsTrailing])
                
                // Loop through results and display them for matrice inverter
                for results in resultsArray {
                    
                    let height1:CGFloat = view.frame.height / 20
                    let letterArray = ["a", "b", "c", "d"]
                    
                    let resultsLabel:UILabel! = UILabel()
                    resultsView.addSubview(resultsLabel)
                    resultsLabel.text = letterArray[number] + " = " + results + " / " + String(denominator)
                    resultsLabel.textColor = .white
                    resultsLabel.translatesAutoresizingMaskIntoConstraints = false
                    
                    let resultsTopConstraint:NSLayoutConstraint = NSLayoutConstraint(item: resultsLabel, attribute: .top, relatedBy: .equal, toItem: resultsView, attribute: .top, multiplier: 1, constant: top)
                    let resultsLeadingConstraint:NSLayoutConstraint = NSLayoutConstraint(item: resultsLabel, attribute: .leading, relatedBy: .equal, toItem: resultsView, attribute: .leading, multiplier: 1, constant: view.frame.width / 20)
                    let resultsHeightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: resultsLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height1)
                    let resultsWidthConstraint:NSLayoutConstraint = NSLayoutConstraint(item: resultsLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: view.frame.width - (view.frame.width / 20))
                    resultsLabel.addConstraints([resultsHeightConstraint, resultsWidthConstraint])
                    resultScrollView.addConstraints([resultsTopConstraint, resultsLeadingConstraint])
                    
                    top += height1
                    number += 1
                    
                }
            }
        }

        matrixInverterA.text = ""
        matrixInverterB.text = ""
        matrixInverterC.text = ""
        matrixInverterD.text = ""
    }
    
    // MARK: - Straight Line Equation Finder Functions
    
    func createStraightLineEquationFinderGraphView(_ gradient:Double, _ c:Double, _ maxX:Int, _ minX:Int, _ maxY:Int, _ minY:Int) {
        
        // Properties
        let height1 = view.frame.height / 20
        let posMinX = -minX
        
        if let viewWithTag = view.viewWithTag(1001) {
            viewWithTag.removeFromSuperview()
        }
        
        var height = view.frame.height - height1 - view.frame.height / 2 - view.frame.height / 15
        var width = view.frame.width
        
        lineEquationFinderGraphView = GraphView(frame: CGRect(x: 0, y: barHeight + view.frame.height - height, width: view.frame.width, height: height))
        view.addSubview(lineEquationFinderGraphView)
        lineEquationFinderGraphView.tag = 1001
        lineEquationFinderGraphView.backgroundColor = UIColor.black
        lineEquationFinderGraphView.gradient = gradient
        lineEquationFinderGraphView.yIntercept = c
        lineEquationFinderGraphView.height = Double(height)
        lineEquationFinderGraphView.width = Double(width)
        lineEquationFinderGraphView.maxX = maxX
        lineEquationFinderGraphView.minX = minX
        lineEquationFinderGraphView.maxY = maxY
        lineEquationFinderGraphView.minY = minY
        
        // Draw axis labels
        height -= 30
        width -= 30
        let maxXLabel = UILabel(frame: CGRect(x: Double(view.frame.width) - 30, y: Double(maxY) * (Double(height) / Double(maxY - minY)) + 20, width: 30, height: 30))
        let minXLabel = UILabel(frame: CGRect(x: 0, y: Double(maxY) * (Double(height) / Double(maxY - minY)) + 20, width: 30, height: 30))
        let maxYLabel = UILabel(frame: CGRect(x: Double(posMinX) * (Double(width) / Double(maxX - minX)) + 20, y: 0, width: 30, height: 30))
        let minYLabel = UILabel(frame: CGRect(x: Double(posMinX) * (Double(width) / Double(maxX - minX)) + 20, y: Double(height), width: 30, height: 30))
        lineEquationFinderGraphView.addSubview(maxXLabel)
        lineEquationFinderGraphView.addSubview(minXLabel)
        lineEquationFinderGraphView.addSubview(maxYLabel)
        lineEquationFinderGraphView.addSubview(minYLabel)
        maxXLabel.text = String(maxX)
        minXLabel.text = String(minX)
        maxYLabel.text = String(maxY)
        minYLabel.text = String(minY)
        maxXLabel.textColor = .white
        minXLabel.textColor = .white
        maxYLabel.textColor = .white
        minYLabel.textColor = .white
        maxXLabel.textAlignment = .center
        minXLabel.textAlignment = .center
        maxYLabel.textAlignment = .center
        minYLabel.textAlignment = .center
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(straightLineEquationFinderPanGestureTriggered(_:)))
        lineEquationFinderGraphView.addGestureRecognizer(panGestureRecognizer)
        
        let zoomGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(straightLineEquationFinderPinchGestureTriggered(_:)))
        lineEquationFinderGraphView.addGestureRecognizer(zoomGestureRecognizer)
        
    }
    
    func createStraightLineEquationFinder() {
        
        // Properties
        let height = view.frame.height
        let width = view.frame.width
        
        // Add coordinate 1 label
        createLabel(lineEquationFinderCoordinate1Label, width / 25)
        lineEquationFinderCoordinate1Label.text = "1st Coordinate:"
        lineEquationFinderCoordinate1Label.textColor = .white
        let coordinate1LabelLeftConstraint:NSLayoutConstraint = NSLayoutConstraint(item: lineEquationFinderCoordinate1Label, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: width / 10)
        view.addConstraint(coordinate1LabelLeftConstraint)
        
        // Add brackets and comma for 1st coordinates
        createLabel(lineEquationFinderLeftBracket1, width / 10)
        lineEquationFinderLeftBracket1.text = "("
        lineEquationFinderLeftBracket1.textColor = .white
        let LeftBracket1LeftConstraint:NSLayoutConstraint = NSLayoutConstraint(item: lineEquationFinderLeftBracket1, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: width / 2)
        view.addConstraint(LeftBracket1LeftConstraint)
        
        createLabel(lineEquationFinderRightBracket1, width / 10)
        lineEquationFinderRightBracket1.text = ")"
        lineEquationFinderRightBracket1.textColor = .white
        let RightBracket1RightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: lineEquationFinderRightBracket1, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -width / 8)
        view.addConstraint(RightBracket1RightConstraint)
        
        createLabel(lineEquationFinderComma1, width / 20)
        lineEquationFinderComma1.text = ","
        lineEquationFinderComma1.textColor = .white
        let Comma1LeftConstraint:NSLayoutConstraint = NSLayoutConstraint(item: lineEquationFinderComma1, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: width / 1.5)
        view.addConstraint(Comma1LeftConstraint)
        
        // Add x and y textfields for 1st coordinates
        createTextField(lineEquationFinderX1)
        lineEquationFinderX1.placeholder = "x"
        let x1LeftConstraint:NSLayoutConstraint = NSLayoutConstraint(item: lineEquationFinderX1, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: width / 1.8)
        let x1TopConstraint:NSLayoutConstraint = NSLayoutConstraint(item: lineEquationFinderX1, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: height / 4.5 + barHeight)
        view.addConstraints([x1LeftConstraint, x1TopConstraint])
        
        createTextField(lineEquationFinderY1)
        lineEquationFinderY1.placeholder = "y"
        let y1RightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: lineEquationFinderY1, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -width / 5.6)
        let y1TopConstraint:NSLayoutConstraint = NSLayoutConstraint(item: lineEquationFinderY1, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: height / 4.5 + barHeight)
        view.addConstraints([y1RightConstraint, y1TopConstraint])
        
        // Add coordinate 2 label
        createLabel(lineEquationFinderCoordinate2Label, width / 25)
        lineEquationFinderCoordinate2Label.text = "2nd Coordinate:"
        lineEquationFinderCoordinate2Label.textColor = .white
        let coordinate2LabelLeftConstraint:NSLayoutConstraint = NSLayoutConstraint(item: lineEquationFinderCoordinate2Label, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: width / 10)
        view.addConstraint(coordinate2LabelLeftConstraint)
        
        // Add brackets and comma for 2nd coordinates
        createLabel(lineEquationFinderLeftBracket2, width / 10)
        lineEquationFinderLeftBracket2.text = "("
        lineEquationFinderLeftBracket2.textColor = .white
        let LeftBracket2LeftConstraint:NSLayoutConstraint = NSLayoutConstraint(item: lineEquationFinderLeftBracket2, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: width / 2)
        view.addConstraint(LeftBracket2LeftConstraint)
        
        createLabel(lineEquationFinderRightBracket2, width / 10)
        lineEquationFinderRightBracket2.text = ")"
        lineEquationFinderRightBracket2.textColor = .white
        let RightBracket2RightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: lineEquationFinderRightBracket2, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -width / 8)
        view.addConstraint(RightBracket2RightConstraint)
        
        createLabel(lineEquationFinderComma2, width / 20)
        lineEquationFinderComma2.text = ","
        lineEquationFinderComma2.textColor = .white
        let Comma2LeftConstraint:NSLayoutConstraint = NSLayoutConstraint(item: lineEquationFinderComma2, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: width / 1.5)
        view.addConstraint(Comma2LeftConstraint)
        
        // Add x and y textfields for 2nd coordinates
        createTextField(lineEquationFinderX2)
        lineEquationFinderX2.placeholder = "x"
        let x2LeftConstraint:NSLayoutConstraint = NSLayoutConstraint(item: lineEquationFinderX2, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: width / 1.8)
        let x2TopConstraint:NSLayoutConstraint = NSLayoutConstraint(item: lineEquationFinderX2, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: height / 3.25 + barHeight)
        view.addConstraints([x2LeftConstraint, x2TopConstraint])
        
        createTextField(lineEquationFinderY2)
        lineEquationFinderY2.placeholder = "y"
        let y2RightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: lineEquationFinderY2, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -width / 5.6)
        let y2TopConstraint:NSLayoutConstraint = NSLayoutConstraint(item: lineEquationFinderY2, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: height / 3.25 + barHeight)
        view.addConstraints([y2RightConstraint, y2TopConstraint])
        
    }

    func createStraightLineEquationFinderResults() {
        
        // Properties
        let height = view.frame.height
        let X1 = lineEquationFinderX1.text
        let Y1 = lineEquationFinderY1.text
        let X2 = lineEquationFinderX2.text
        let Y2 = lineEquationFinderY2.text
        let allTexts = X1! + Y1! + X2! + Y2!
        
        // Check for errors
        if Double(X1!) == nil || Double(Y1!) == nil || Double(X2!) == nil || Double(Y2!) == nil {
            let charset = CharacterSet(charactersIn: "/")
            if allTexts.rangeOfCharacter(from: charset) != nil {
                createErrorMessage("Please use decimal instead of fraction")
            } else {
                createErrorMessage("Ensure all blanks contain numbers")
            }
        } else {
            
            // Reset answers
            if let viewWithTag = view.viewWithTag(1) {
                viewWithTag.removeFromSuperview()
                
            }
            
            lineEquationFinderGradient = (Double(Y1!)! - Double(Y2!)!) / (Double(X1!)! - Double(X2!)!)
            lineEquationFinderC = Double(Y1!)! - (lineEquationFinderGradient * Double(X1!)!)
            var cAnswer = ""
            if lineEquationFinderC >= 0.0 {
                cAnswer = "+ " + String(lineEquationFinderC)
            } else if lineEquationFinderC < 0.0 {
                cAnswer = String(lineEquationFinderC)
            }
            
            let equation = "y = " + String(lineEquationFinderGradient) + "x " + cAnswer
            
            // Create scroll view for the results
            let resultScrollView:UIScrollView! = UIScrollView()
            view.addSubview(resultScrollView)
            resultScrollView.tag = 1
            resultScrollView.isScrollEnabled = true
            resultScrollView.isUserInteractionEnabled = true
            resultScrollView.translatesAutoresizingMaskIntoConstraints = false
            let resultScrollTop:NSLayoutConstraint = NSLayoutConstraint(item: resultScrollView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: (height / 2) + 2 + (height / 15) + barHeight)
            let resultScrollLeading:NSLayoutConstraint = NSLayoutConstraint(item: resultScrollView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
            let resultScrollBottom:NSLayoutConstraint = NSLayoutConstraint(item: resultScrollView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
            let resultScrollTrailing:NSLayoutConstraint = NSLayoutConstraint(item: resultScrollView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
            view.addConstraints([resultScrollTop, resultScrollLeading, resultScrollBottom, resultScrollTrailing])
            
            // Add the results view
            let resultsView:UIView! = UIView()
            resultScrollView.addSubview(resultsView)
            resultsView.isUserInteractionEnabled = true
            resultsView.translatesAutoresizingMaskIntoConstraints = false
            let resultsTop:NSLayoutConstraint = NSLayoutConstraint(item: resultsView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: resultScrollView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
            let resultsLeading:NSLayoutConstraint = NSLayoutConstraint(item: resultsView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: resultScrollView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
            let resultsBottom:NSLayoutConstraint = NSLayoutConstraint(item: resultsView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: resultScrollView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
            let resultsTrailing:NSLayoutConstraint = NSLayoutConstraint(item: resultsView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: resultScrollView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
            let resultsWidth:NSLayoutConstraint = NSLayoutConstraint(item: resultsView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: view.frame.width)
            let resultsHeight:NSLayoutConstraint = NSLayoutConstraint(item: resultsView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: CGFloat(resultsArray.count) * (height / 20))
            resultsView.addConstraints([resultsWidth, resultsHeight])
            view.addConstraints([resultsTop, resultsLeading, resultsBottom, resultsTrailing])
            
            // Create results label
            let height1:CGFloat = view.frame.height / 20
            
            let resultsLabel:UILabel! = UILabel()
            resultsView.addSubview(resultsLabel)
            resultsLabel.text = equation
            resultsLabel.textColor = .white
            resultsLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let resultsTopConstraint:NSLayoutConstraint = NSLayoutConstraint(item: resultsLabel, attribute: .top, relatedBy: .equal, toItem: resultsView, attribute: .top, multiplier: 1, constant: 0)
            let resultsLeadingConstraint:NSLayoutConstraint = NSLayoutConstraint(item: resultsLabel, attribute: .leading, relatedBy: .equal, toItem: resultsView, attribute: .leading, multiplier: 1, constant: view.frame.width / 20)
            let resultsHeightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: resultsLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height1)
            let resultsWidthConstraint:NSLayoutConstraint = NSLayoutConstraint(item: resultsLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: view.frame.width - (view.frame.width / 20))
            resultsLabel.addConstraints([resultsHeightConstraint, resultsWidthConstraint])
            resultScrollView.addConstraints([resultsTopConstraint, resultsLeadingConstraint])
            
            // TODO: Add gesture recogniser to drag and increase range of graph
            // Add the pan gesture recognizer to the graphView
            
            createStraightLineEquationFinderGraphView(lineEquationFinderGradient, lineEquationFinderC, 5, -5, 5, -5)
        }
        
        
    }
    
    @objc func straightLineEquationFinderPanGestureTriggered(_ sender:UIPanGestureRecognizer) {
        
        let currentTouchPoint = sender.location(in: self.view)
        
        if sender.state == .began {
            // Take note of the initial start x,y
            lineEquationFinderInitialTouchPoint = currentTouchPoint
            
            
        } else if sender.state == .changed {
            // Compare the x,y and shift the element down
            let yMovement = currentTouchPoint.y - lineEquationFinderInitialTouchPoint.y
            let xMovement = currentTouchPoint.x - lineEquationFinderInitialTouchPoint.x
            
            // Finger is being dragged down
            if yMovement >= lineEquationFinderGraphView.frame.height / 10  {
                
                lineEquationFinderMaxY += Int((yMovement / lineEquationFinderGraphView.frame.height) * 10)
                lineEquationFinderMinY += Int((yMovement / lineEquationFinderGraphView.frame.height) * 10)
                createStraightLineEquationFinderGraphView(lineEquationFinderGradient, lineEquationFinderC, lineEquationFinderMaxX, lineEquationFinderMinX, lineEquationFinderMaxY, lineEquationFinderMinY)
            }
            
            // Finger is being dragged up
            if yMovement <= -(lineEquationFinderGraphView.frame.height / 10) {
                
                lineEquationFinderMaxY += Int((yMovement / lineEquationFinderGraphView.frame.height) * 10)
                lineEquationFinderMinY += Int((yMovement / lineEquationFinderGraphView.frame.height) * 10)
                createStraightLineEquationFinderGraphView(lineEquationFinderGradient, lineEquationFinderC, lineEquationFinderMaxX, lineEquationFinderMinX, lineEquationFinderMaxY, lineEquationFinderMinY)
                
            }
            
            // Finger is being dragged left
            if xMovement <= -(lineEquationFinderGraphView.frame.width / 10) {
                
                lineEquationFinderMaxX -= Int((xMovement / lineEquationFinderGraphView.frame.width) * 10)
                lineEquationFinderMinX -= Int((xMovement / lineEquationFinderGraphView.frame.width) * 10)
                createStraightLineEquationFinderGraphView(lineEquationFinderGradient, lineEquationFinderC, lineEquationFinderMaxX, lineEquationFinderMinX, lineEquationFinderMaxY, lineEquationFinderMinY)
            }
            
            // Finger is being dragged right
            if xMovement >= lineEquationFinderGraphView.frame.width / 10 {
                
                lineEquationFinderMaxX -= Int((xMovement / lineEquationFinderGraphView.frame.width) * 10)
                lineEquationFinderMinX -= Int((xMovement / lineEquationFinderGraphView.frame.width) * 10)
                createStraightLineEquationFinderGraphView(lineEquationFinderGradient, lineEquationFinderC, lineEquationFinderMaxX, lineEquationFinderMinX, lineEquationFinderMaxY, lineEquationFinderMinY)
                
            }
            
        }
        
    }
    
    @objc func straightLineEquationFinderPinchGestureTriggered(_ sender:UIPinchGestureRecognizer) {
        
        if sender.state == .changed {
            
            var senderScale = sender.scale
            
            if sender.scale > 1 {
                senderScale = 1 - (sender.scale + 0.1)
            } else if sender.scale < 1 {
                senderScale = 1 - (sender.scale - 0.1)
            }
                
            senderScale = 1 + senderScale
            
            lineEquationFinderRangeX = Double(lineEquationFinderRangeX) * Double(senderScale)
            lineEquationFinderRangeY = Double(lineEquationFinderRangeY) * Double(senderScale)
            lineEquationFinderMinY = lineEquationFinderMaxY - Int(lineEquationFinderRangeY)
            lineEquationFinderMinX = lineEquationFinderMaxX - Int(lineEquationFinderRangeX)
            createStraightLineEquationFinderGraphView(lineEquationFinderGradient, lineEquationFinderC, lineEquationFinderMaxX, lineEquationFinderMinX, lineEquationFinderMaxY, lineEquationFinderMinY)
            sender.scale = 1.0
            
        }
        
    }
    
    // MARK: - Matrix Multiplier Function
    
    func createMatrixMultiplier() {
        
        createGeneralMatrixMultiplierProperties()
        createSpecificMatrixMultiplierProperties()

    }
    
    func createMatrixMultiplierResults() {
        
        // Reset answers
        if let viewWithTag = view.viewWithTag(1) {
            viewWithTag.removeFromSuperview()
            
        }
        
        hideKeyBoard()
        
        // Properties
        let matrix1Array = [matrixMultiplier11.text!, matrixMultiplier21.text!, matrixMultiplier31.text!, matrixMultiplier41.text!, matrixMultiplier51.text!, matrixMultiplier61.text!, matrixMultiplier71.text!, matrixMultiplier81.text!, matrixMultiplier91.text!]
        let matrix2Array = [matrixMultiplier12.text!, matrixMultiplier22.text!, matrixMultiplier32.text!, matrixMultiplier42.text!, matrixMultiplier52.text!, matrixMultiplier62.text!, matrixMultiplier72.text!, matrixMultiplier82.text!, matrixMultiplier92.text!]
        let height = view.frame.height
        let width = view.frame.width
        
        // Check for errors
        var noElementsMatrix1 = matrixMultiplierRow1 * matrixMultiplierColumn1
        var actualMatrix1Array = [String]()
        var noElementsMatrix2 = matrixMultiplierRow2 * matrixMultiplierColumn2
        var actualMatrix2Array = [String]()
        
        if matrixMultiplierColumn1 != matrixMultiplierRow2 {
            createErrorMessage("Column 1 must equal Row 2")
            return
        }
        
        for x in matrix1Array {
            actualMatrix1Array.append(x)
            noElementsMatrix1 -= 1
            if noElementsMatrix1 == 0 {
                break
            }
        }
        
        for x in matrix2Array {
            
            actualMatrix2Array.append(x)
            noElementsMatrix2 -= 1
            if noElementsMatrix2 == 0 {
                break
            }
        }
        
        for x in actualMatrix1Array {
            
            if Double(x) != nil {
                
            } else {
                createErrorMessage("Please fill in all matrix boxes with numbers")
                return
            }
        }
        
        for x in actualMatrix2Array {
            if Double(x) != nil {
                
            } else {
                createErrorMessage("Please fill in all matrix boxes with numbers")
                return
            }
            
        }
        
        // Multiply
        
        var matrix1RowsArray = [Array<Double>]()
        var matrix2ColumnsArray = [Array<Double>]()
        
        // Add element to row array for matrix 1
        var rowArray = [Double]()
        var rowCount1 = matrixMultiplierRow1
        var columnCount1 = matrixMultiplierColumn1
        for x in actualMatrix1Array {
            rowArray.append(Double(x)!)
            columnCount1 -= 1
            if columnCount1 == 0 {
                matrix1RowsArray.append(rowArray)
                columnCount1 = matrixMultiplierColumn1
                rowCount1 -= 1
                rowArray = []
                if rowCount1 == 0 {
                    break
                }
            }
        }
        
        // Add element to column array for matrix 2
        var columnArray = [Double]()
        let jump = matrixMultiplierColumn2
        var number = 0
        for count in 0..<matrixMultiplierColumn2 {
            number = count
            for _ in 0..<matrixMultiplierRow2 {
                columnArray.append(Double(actualMatrix2Array[number])!)
                number += jump
            }
            matrix2ColumnsArray.append(columnArray)
            columnArray = []
        }
        
        // Loop throught the rows and multiply them
        for x in matrix1RowsArray {
            
            for y in matrix2ColumnsArray {
                resultsArray.append(intChecker(double: (multiplyArray(array1: x, array2: y))))
            }
        }
        
        // Add the results to the view
        
        // Create scroll view for the results
        let resultScrollView:UIScrollView! = UIScrollView(frame: CGRect(x: 0, y: (height / 2) + 2 + (height / 15) + barHeight, width: width, height: height - ((height / 2) + 2 + (height / 15) + barHeight)))
        view.addSubview(resultScrollView)
        resultScrollView.tag = 1
        resultScrollView.isScrollEnabled = true
        resultScrollView.isUserInteractionEnabled = true
        
        // Add the results view
        let resultsView:UIView! = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height - ((height / 2) + 2 + (height / 15) + barHeight)))
        resultScrollView.addSubview(resultsView)
        resultsView.isUserInteractionEnabled = true
        resultsView.translatesAutoresizingMaskIntoConstraints = false
        
        // Display properties
        let displayHeight = resultsView.frame.height
        let displayWidth = resultsView.frame.width
        let no1ColumnRowWidth = displayWidth / 2
        let no1ColumnRowHeight = displayWidth / 2
        let no2ColumnRowWidth = displayWidth / 5
        let no2ColumnRowHeight = displayWidth / 5
        let no3ColumnRowWidth = width / 7.5
        let no3ColumnRowHeight = displayWidth / 7.5
        var left1Width = width / 3.85
        var top1Height = displayHeight / 8
        let element1Height:CGFloat!
        let element1Width:CGFloat!
        
        // Create brackets
        let leftResultBracket:UILabel = UILabel(frame: CGRect(x: width / 20, y: 0, width: width / 5, height: displayHeight / 1.2))
        resultsView.addSubview(leftResultBracket)
        leftResultBracket.text = "("
        leftResultBracket.textAlignment = .left
        leftResultBracket.textColor = .white
        leftResultBracket.font = leftResultBracket.font.withSize(displayHeight / 1.2)
        
        let rightResultBracket:UILabel = UILabel(frame: CGRect(x: 19 * width / 20 - width / 5, y: 0, width: width / 5, height: displayHeight / 1.2))
        resultsView.addSubview(rightResultBracket)
        rightResultBracket.text = ")"
        rightResultBracket.textColor = .white
        rightResultBracket.font = rightResultBracket.font.withSize(displayHeight / 1.2)
        
        // Set height and width of elements
        if matrixMultiplierRow1 == 3 || matrixMultiplierColumn2 == 3 {
            element1Height = no3ColumnRowHeight
            element1Width = no3ColumnRowWidth
        } else if matrixMultiplierRow1 == 2 || matrixMultiplierColumn2 == 2{
            element1Height = no2ColumnRowHeight
            element1Width = no2ColumnRowWidth
        } else {
            element1Height = no1ColumnRowHeight
            element1Width = no1ColumnRowWidth
        }
        
        // Set left and top constraints
        if matrixMultiplierRow1 == 1 && matrixMultiplierColumn2 == 2 {
            top1Height += element1Height - element1Height / 3.2
        } else if matrixMultiplierRow1 == 1 && matrixMultiplierColumn2 == 3 {
            top1Height += element1Height * 1.4
        } else if matrixMultiplierRow1 == 2 && matrixMultiplierColumn2 == 1 {
            left1Width += element1Width - element1Width / 4
        } else if matrixMultiplierRow1 == 3 && matrixMultiplierColumn2 == 1 {
            left1Width += element1Width * 1.4
        } else if matrixMultiplierRow1 == 3 && matrixMultiplierColumn2 == 2 {
            left1Width += element1Width / 1.5
        } else if matrixMultiplierRow1 == 2 && matrixMultiplierColumn2 == 3 {
            top1Height += element1Height / 1.5
        }
        
        // Layout Matrix 1
        var matrix1ArrayLabelCount = 0
        
        // Loop through the rows
        let leftConstraint = left1Width
        
        for _ in 0..<matrixMultiplierRow1 {
            left1Width = leftConstraint
            for _ in 0..<matrixMultiplierColumn2 {
                let label = UILabel(frame: CGRect(x: left1Width, y: top1Height, width: element1Width, height: element1Height))
                resultsView.addSubview(label)
                label.font = label.font.withSize(element1Width)
                label.adjustsFontSizeToFitWidth = true
                label.text = resultsArray[matrix1ArrayLabelCount]
                label.textAlignment = .center
                label.textColor = .white
                label.numberOfLines = 0
                matrix1ArrayLabelCount += 1
                left1Width += element1Width + element1Width / 2.3
            }
            
            top1Height += element1Height + element1Height / 2.1
        }
    
    }
    
    func createSpecificMatrixMultiplierProperties() {
        
        // Properties
        let width = view.frame.width
        let height = view.frame.height
        
        let no1ColumnRowWidth = width / 4
        let no1ColumnRowHeight = height / 8
        let no2ColumnRowWidth = width / 10
        let no2ColumnRowHeight = height / 20
        let no3ColumnRowWidth = width / 15
        let no3ColumnRowHeight = height / 30
        var left1Width = width / 10.5
        var top1Height = height / 4.4 + barHeight
        var left2Width = width / 1.48
        var top2Height = height / 4.4 + barHeight
        let element1Height:CGFloat!
        let element1Width:CGFloat!
        let element2Height:CGFloat!
        let element2Width:CGFloat!
        
        let placeHolderArray = ["a", "b", "c", "d", "e", "f", "g", "h", "i"]
        
        // Check if row or column are within limits
        if matrixMultiplierRow1 > 3 || matrixMultiplierColumn1 > 3 || matrixMultiplierRow2 > 3 || matrixMultiplierColumn2 > 3 {
            createErrorMessage("Row or column must be lower than 4")
            return
        } else if matrixMultiplierRow1 <= 0 || matrixMultiplierColumn1 <= 0 || matrixMultiplierRow2 <= 0 || matrixMultiplierColumn2 <= 0 {
            createErrorMessage("Row or column must be higher than 0")
            return
        }
        
        // Remove all the textfields
        matrixMultiplier11.removeFromSuperview()
        matrixMultiplier21.removeFromSuperview()
        matrixMultiplier31.removeFromSuperview()
        matrixMultiplier41.removeFromSuperview()
        matrixMultiplier51.removeFromSuperview()
        matrixMultiplier61.removeFromSuperview()
        matrixMultiplier71.removeFromSuperview()
        matrixMultiplier81.removeFromSuperview()
        matrixMultiplier91.removeFromSuperview()
        matrixMultiplier12.removeFromSuperview()
        matrixMultiplier22.removeFromSuperview()
        matrixMultiplier32.removeFromSuperview()
        matrixMultiplier42.removeFromSuperview()
        matrixMultiplier52.removeFromSuperview()
        matrixMultiplier62.removeFromSuperview()
        matrixMultiplier72.removeFromSuperview()
        matrixMultiplier82.removeFromSuperview()
        matrixMultiplier92.removeFromSuperview()
        
        // Set width and height of elements of matrix 1
        if matrixMultiplierRow1 == 3 || matrixMultiplierColumn1 == 3 {
            element1Height = no3ColumnRowHeight
            element1Width = no3ColumnRowWidth
        } else if matrixMultiplierRow1 == 2 || matrixMultiplierColumn1 == 2{
            element1Height = no2ColumnRowHeight
            element1Width = no2ColumnRowWidth
        } else {
            element1Height = no1ColumnRowHeight
            element1Width = no1ColumnRowWidth
        }
        
        // Set width and height of elements of matrix 2
        if matrixMultiplierRow2 == 3 || matrixMultiplierColumn2 == 3 {
            element2Height = no3ColumnRowHeight
            element2Width = no3ColumnRowWidth
        } else if matrixMultiplierRow2 == 2 || matrixMultiplierColumn2 == 2{
            element2Height = no2ColumnRowHeight
            element2Width = no2ColumnRowWidth
        } else {
            element2Height = no1ColumnRowHeight
            element2Width = no1ColumnRowWidth
        }
        
        // Set original left and top constraints for matrix 1
        if matrixMultiplierRow1 == 1 && matrixMultiplierColumn1 == 2 {
            top1Height += element1Height - element1Height / 3
        } else if matrixMultiplierRow1 == 1 && matrixMultiplierColumn1 == 3 {
            top1Height += element1Height * 1.4
        } else if matrixMultiplierRow1 == 2 && matrixMultiplierColumn1 == 1 {
            left1Width += element1Width - element1Width / 4
        } else if matrixMultiplierRow1 == 3 && matrixMultiplierColumn1 == 1 {
            left1Width += element1Width * 1.4
        } else if matrixMultiplierRow1 == 3 && matrixMultiplierColumn1 == 2 {
            left1Width += element1Width / 1.5
        } else if matrixMultiplierRow1 == 2 && matrixMultiplierColumn1 == 3 {
            top1Height += element1Height / 1.5
        }
        
        // Set original left and top constraints for matrix 2
        if matrixMultiplierRow2 == 1 && matrixMultiplierColumn2 == 2 {
            top2Height += element2Height - element2Height / 3
        } else if matrixMultiplierRow2 == 1 && matrixMultiplierColumn2 == 3 {
            top2Height += element2Height * 1.4
        } else if matrixMultiplierRow2 == 2 && matrixMultiplierColumn2 == 1 {
            left2Width += element2Width - element2Width / 4
        } else if matrixMultiplierRow2 == 3 && matrixMultiplierColumn2 == 1 {
            left2Width += element2Width * 1.4
        } else if matrixMultiplierRow2 == 3 && matrixMultiplierColumn2 == 2 {
            left2Width += element2Width / 1.5
        } else if matrixMultiplierRow2 == 2 && matrixMultiplierColumn2 == 3 {
            top2Height += element2Height / 1.5
        }
        
        // Layout Matrix 1
        var matrix1ArrayElementCount = 0
        
        // Loop through the rows
        let leftConstraint = left1Width
        
        for _ in 0..<matrixMultiplierRow1 {
            left1Width = leftConstraint
            for _ in 0..<matrixMultiplierColumn1 {
                let placeHolder = placeHolderArray[matrix1ArrayElementCount]
                switch (matrix1ArrayElementCount) {
                    
                case 0:createMatrixMultiplierTextField(textField: matrixMultiplier11, width: element1Width, height: element1Height, left: left1Width, top: top1Height, placeHolder: placeHolder)
                case 1:createMatrixMultiplierTextField(textField: matrixMultiplier21, width: element1Width, height: element1Height, left: left1Width, top: top1Height, placeHolder: placeHolder)
                case 2:createMatrixMultiplierTextField(textField: matrixMultiplier31, width: element1Width, height: element1Height, left: left1Width, top: top1Height, placeHolder: placeHolder)
                case 3:createMatrixMultiplierTextField(textField: matrixMultiplier41, width: element1Width, height: element1Height, left: left1Width, top: top1Height, placeHolder: placeHolder)
                case 4:createMatrixMultiplierTextField(textField: matrixMultiplier51, width: element1Width, height: element1Height, left: left1Width, top: top1Height, placeHolder: placeHolder)
                case 5:createMatrixMultiplierTextField(textField: matrixMultiplier61, width: element1Width, height: element1Height, left: left1Width, top: top1Height, placeHolder: placeHolder)
                case 6:createMatrixMultiplierTextField(textField: matrixMultiplier71, width: element1Width, height: element1Height, left: left1Width, top: top1Height, placeHolder: placeHolder)
                case 7:createMatrixMultiplierTextField(textField: matrixMultiplier81, width: element1Width, height: element1Height, left: left1Width, top: top1Height, placeHolder: placeHolder)
                case 8:createMatrixMultiplierTextField(textField: matrixMultiplier91, width: element1Width, height: element1Height, left: left1Width, top: top1Height, placeHolder: placeHolder)
                default:
                    createErrorMessage("Something went wrong")
                }
                matrix1ArrayElementCount += 1
                left1Width += element1Width + element1Width / 2.3
            }
            
            top1Height += element1Height + element1Height / 2.1
        }
        
        // Layout Matrix 2
        var matrix2ArrayElementCount = 0
        
        // Loop through the rows
        let left2Constraint = left2Width
        
        for _ in 0..<matrixMultiplierRow2 {
            left2Width = left2Constraint
            for _ in 0..<matrixMultiplierColumn2 {
                let placeHolder = placeHolderArray[matrix2ArrayElementCount]
                switch (matrix2ArrayElementCount) {
                    
                case 0:createMatrixMultiplierTextField(textField: matrixMultiplier12, width: element2Width, height: element2Height, left: left2Width, top: top2Height, placeHolder: placeHolder)
                case 1:createMatrixMultiplierTextField(textField: matrixMultiplier22, width: element2Width, height: element2Height, left: left2Width, top: top2Height, placeHolder: placeHolder)
                case 2:createMatrixMultiplierTextField(textField: matrixMultiplier32, width: element2Width, height: element2Height, left: left2Width, top: top2Height, placeHolder: placeHolder)
                case 3:createMatrixMultiplierTextField(textField: matrixMultiplier42, width: element2Width, height: element2Height, left: left2Width, top: top2Height, placeHolder: placeHolder)
                case 4:createMatrixMultiplierTextField(textField: matrixMultiplier52, width: element2Width, height: element2Height, left: left2Width, top: top2Height, placeHolder: placeHolder)
                case 5:createMatrixMultiplierTextField(textField: matrixMultiplier62, width: element2Width, height: element2Height, left: left2Width, top: top2Height, placeHolder: placeHolder)
                case 6:createMatrixMultiplierTextField(textField: matrixMultiplier72, width: element2Width, height: element2Height, left: left2Width, top: top2Height, placeHolder: placeHolder)
                case 7:createMatrixMultiplierTextField(textField: matrixMultiplier82, width: element2Width, height: element2Height, left: left2Width, top: top2Height, placeHolder: placeHolder)
                case 8:createMatrixMultiplierTextField(textField: matrixMultiplier92, width: element2Width, height: element2Height, left: left2Width, top: top2Height, placeHolder: placeHolder)
                default:
                    createErrorMessage("Something went wrong")
                }
                matrix2ArrayElementCount += 1
                left2Width += element2Width + element2Width / 2.3
            }
            
            top2Height += element2Height + element2Height / 2.1
        }
       
    }
    
    func createMatrixMultiplierTextField(textField:DecimalMinusTextField, width:CGFloat, height:CGFloat, left:CGFloat, top:CGFloat, placeHolder:String) {
        
        textField.frame = CGRect(x: left, y: top, width: width, height: height)
        view.addSubview(textField)
        textField.font = textField.font?.withSize(width)
        textField.keyboardType = UIKeyboardType.decimalPad
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = CGFloat(2)
        textField.layer.cornerRadius = textField.frame.height / 4
        textField.backgroundColor = .lightGray
        textField.placeholder = placeHolder
        textField.textAlignment = .center
        textField.addTarget(self, action: #selector(matrixMultiplierTextFieldDidBeginEditing(_:)), for: .editingDidBegin)
    }
    
    func createGeneralMatrixMultiplierProperties() {
        
        let width = view.frame.width
        let height = view.frame.height
        
        // Create x label
        matrixMultiplierXLabel = UILabel(frame: CGRect(x: width / 2 - width / 20, y: barHeight + height / 4, width: width / 10, height: width / 10))
        view.addSubview(matrixMultiplierXLabel)
        matrixMultiplierXLabel.font = matrixMultiplierXLabel.font.withSize(width / 10)
        matrixMultiplierXLabel.text = "x"
        matrixMultiplierXLabel.textColor = .white
        matrixMultiplierXLabel.textAlignment = .center
        
        // Create row1 Label
        matrixMultiplierRow1Label = UILabel(frame: CGRect(x: 0, y: barHeight + height / 9, width: width / 6, height: width / 20))
        view.addSubview(matrixMultiplierRow1Label)
        matrixMultiplierRow1Label.font = matrixMultiplierRow1Label.font.withSize(width / 30)
        matrixMultiplierRow1Label.text = "Row1:"
        matrixMultiplierRow1Label.textColor = .white
        matrixMultiplierRow1Label.textAlignment = .center
        
        // Create column1 Label
        matrixMultiplierColumn1Label = UILabel(frame: CGRect(x: width / 4, y: barHeight + height / 9, width: width / 6, height: width / 20))
        view.addSubview(matrixMultiplierColumn1Label)
        matrixMultiplierColumn1Label.font = matrixMultiplierColumn1Label.font.withSize(width / 30)
        matrixMultiplierColumn1Label.text = "Column1:"
        matrixMultiplierColumn1Label.textColor = .white
        matrixMultiplierColumn1Label.textAlignment = .center
        
        // Create row2 Label
        matrixMultiplierRow2Label = UILabel(frame: CGRect(x: width / 2, y: barHeight + height / 9, width: width / 6, height: width / 20))
        view.addSubview(matrixMultiplierRow2Label)
        matrixMultiplierRow2Label.font = matrixMultiplierRow2Label.font.withSize(width / 30)
        matrixMultiplierRow2Label.text = "Row2:"
        matrixMultiplierRow2Label.textColor = .white
        matrixMultiplierRow2Label.textAlignment = .center
        
        // Create column2 Label
        matrixMultiplierColumn2Label = UILabel(frame: CGRect(x: 3 * width / 4, y: barHeight + height / 9, width: width / 6, height: width / 20))
        view.addSubview(matrixMultiplierColumn2Label)
        matrixMultiplierColumn2Label.font = matrixMultiplierColumn2Label.font.withSize(width / 30)
        matrixMultiplierColumn2Label.text = "Column2:"
        matrixMultiplierColumn2Label.textColor = .white
        matrixMultiplierColumn2Label.textAlignment = .center
        
        // Create row1 Text Field
        matrixMultiplierRow1TextField = DecimalMinusTextField(frame: CGRect(x: width / 6, y: barHeight + height / 9, width: width / 12, height: width / 20))
        view.addSubview(matrixMultiplierRow1TextField)
        matrixMultiplierRow1TextField.backgroundColor = .lightGray
        matrixMultiplierRow1TextField.textAlignment = .center
        matrixMultiplierRow1TextField.placeholder = "2"
        matrixMultiplierRow1TextField.keyboardType = UIKeyboardType.decimalPad
        matrixMultiplierRow1TextField.layer.cornerRadius = width / 40
        matrixMultiplierRow1TextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        matrixMultiplierRow1TextField.addTarget(self, action: #selector(matrixMultiplierTextFieldDidBeginEditing(_:)), for: .editingDidBegin)
        
        // Create column1 Text Field
        matrixMultiplierColumn1TextField = DecimalMinusTextField(frame: CGRect(x: 5 * width / 12, y: barHeight + height / 9, width: width / 12, height: width / 20))
        view.addSubview(matrixMultiplierColumn1TextField)
        matrixMultiplierColumn1TextField.backgroundColor = .lightGray
        matrixMultiplierColumn1TextField.textAlignment = .center
        matrixMultiplierColumn1TextField.placeholder = "2"
        matrixMultiplierColumn1TextField.keyboardType = UIKeyboardType.decimalPad
        matrixMultiplierColumn1TextField.layer.cornerRadius = width / 40
        matrixMultiplierColumn1TextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        matrixMultiplierColumn1TextField.addTarget(self, action: #selector(matrixMultiplierTextFieldDidBeginEditing(_:)), for: .editingDidBegin)
        
        // Create row2 Text Field
        matrixMultiplierRow2TextField = DecimalMinusTextField(frame: CGRect(x: 8 * width / 12, y: barHeight + height / 9, width: width / 12, height: width / 20))
        view.addSubview(matrixMultiplierRow2TextField)
        matrixMultiplierRow2TextField.backgroundColor = .lightGray
        matrixMultiplierRow2TextField.textAlignment = .center
        matrixMultiplierRow2TextField.placeholder = "2"
        matrixMultiplierRow2TextField.keyboardType = UIKeyboardType.decimalPad
        matrixMultiplierRow2TextField.layer.cornerRadius = width / 40
        matrixMultiplierRow2TextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        matrixMultiplierRow2TextField.addTarget(self, action: #selector(matrixMultiplierTextFieldDidBeginEditing(_:)), for: .editingDidBegin)

        // Create column2 Text Field
        matrixMultiplierColumn2TextField = DecimalMinusTextField(frame: CGRect(x: 11 * width / 12, y: barHeight + height / 9, width: width / 12, height: width / 20))
        view.addSubview(matrixMultiplierColumn2TextField)
        matrixMultiplierColumn2TextField.backgroundColor = .lightGray
        matrixMultiplierColumn2TextField.textAlignment = .center
        matrixMultiplierColumn2TextField.placeholder = "2"
        matrixMultiplierColumn2TextField.keyboardType = UIKeyboardType.decimalPad
        matrixMultiplierColumn2TextField.layer.cornerRadius = width / 40
        matrixMultiplierColumn2TextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        matrixMultiplierColumn2TextField.addTarget(self, action: #selector(matrixMultiplierTextFieldDidBeginEditing(_:)), for: .editingDidBegin)

        // Create left bracket 1
        matrixMultiplierLeftBracket1 = UILabel(frame: CGRect(x: 0 * width / 12, y: barHeight + height / 4 - (height / 5 - width / 10) / 2, width: width / 12, height: height / 5))
        view.addSubview(matrixMultiplierLeftBracket1)
        matrixMultiplierLeftBracket1.text = "[ "
        matrixMultiplierLeftBracket1.font = matrixMultiplierLeftBracket1.font.withSize(width / 3)
        matrixMultiplierLeftBracket1.textColor = .white
        
        // Create right bracket 1
        matrixMultiplierRightBracket1 = UILabel(frame: CGRect(x: 4 * width / 12, y: barHeight + height / 4 - (height / 5 - width / 10) / 2, width: width / 12, height: height / 5))
        view.addSubview(matrixMultiplierRightBracket1)
        matrixMultiplierRightBracket1.text = "]"
        matrixMultiplierRightBracket1.font = matrixMultiplierRightBracket1.font.withSize(width / 3)
        matrixMultiplierRightBracket1.textColor = .white

        
        // Create left bracket 2
        matrixMultiplierLeftBracket2 = UILabel(frame: CGRect(x: 7 * width / 12, y: barHeight + height / 4 - (height / 5 - width / 10) / 2, width: width / 12, height: height / 5))
        view.addSubview(matrixMultiplierLeftBracket2)
        matrixMultiplierLeftBracket2.text = "[ "
        matrixMultiplierLeftBracket2.font = matrixMultiplierLeftBracket2.font.withSize(width / 3)
        matrixMultiplierLeftBracket2.textColor = .white
        
        // Create right bracket 2
        matrixMultiplierRightBracket2 = UILabel(frame: CGRect(x: 11 * width / 12, y: barHeight + height / 4 - (height / 5 - width / 10) / 2, width: width / 12, height: height / 5))
        view.addSubview(matrixMultiplierRightBracket2)
        matrixMultiplierRightBracket2.text = "]"
        matrixMultiplierRightBracket2.font = matrixMultiplierRightBracket2.font.withSize(width / 3)
        matrixMultiplierRightBracket2.textColor = .white

    }
    
    func multiplyArray(array1:Array<Double>, array2:Array<Double>) -> Double {
        if array1.count != array2.count {
            createErrorMessage("Something went wrong")
            return 0.0
        }
        var answer = 0.0
        var arrayCount = 0
        for x in array1 {
            answer += (x * array2[arrayCount])
            arrayCount += 1
        }
        
        return answer
    }
    
    @objc func matrixMultiplierTextFieldDidBeginEditing(_ textField:DecimalMinusTextField) {
        textField.text = ""
    }
    
    func setMatrixMultiplierTextFieldsToBlank() {
        matrixMultiplier11.text = ""
        matrixMultiplier21.text = ""
        matrixMultiplier31.text = ""
        matrixMultiplier41.text = ""
        matrixMultiplier51.text = ""
        matrixMultiplier61.text = ""
        matrixMultiplier71.text = ""
        matrixMultiplier81.text = ""
        matrixMultiplier91.text = ""
        matrixMultiplier12.text = ""
        matrixMultiplier22.text = ""
        matrixMultiplier32.text = ""
        matrixMultiplier42.text = ""
        matrixMultiplier52.text = ""
        matrixMultiplier62.text = ""
        matrixMultiplier72.text = ""
        matrixMultiplier82.text = ""
        matrixMultiplier92.text = ""
    }
    
    // MARK: - Quadratic: Standard to Vertex
    
    func createQuadraticStandardToVertex() {
        
        let width = view.frame.width
        let height = view.frame.height
        
        // Layout the labels
        let firstXLabel = UILabel(frame: CGRect(x: width / 4, y: height / 5 + barHeight, width: width / 10, height: height / 25))
        view.addSubview(firstXLabel)
        firstXLabel.text = "x"
        firstXLabel.textColor = .white
        firstXLabel.font = firstXLabel.font.withSize(width / 10)
        firstXLabel.textAlignment = .center
        firstXLabel.numberOfLines = 0
        
        let powerLabel = UILabel(frame: CGRect(x: width / 4 + width / 15, y: height / 5 + barHeight - height / 50, width: width / 20, height: height / 40))
        view.addSubview(powerLabel)
        powerLabel.text = "2"
        powerLabel.textColor = .white
        powerLabel.font = powerLabel.font.withSize(width / 20)
        powerLabel.textAlignment = .center
        powerLabel.numberOfLines = 0
        
        let firstPlusLabel = UILabel(frame: CGRect(x: width / 2.8, y: height / 5 + barHeight, width: width / 10, height: height / 20))
        view.addSubview(firstPlusLabel)
        firstPlusLabel.text = "+"
        firstPlusLabel.textColor = .white
        firstPlusLabel.font = firstPlusLabel.font.withSize(width / 10)
        firstPlusLabel.textAlignment = .center
        firstPlusLabel.numberOfLines = 0
        
        let secondXLabel = UILabel(frame: CGRect(x: width / 1.8, y: height / 5 + barHeight, width: width / 10, height: height / 20))
        view.addSubview(secondXLabel)
        secondXLabel.text = "x"
        secondXLabel.textColor = .white
        secondXLabel.font = secondXLabel.font.withSize(width / 10)
        secondXLabel.textAlignment = .center
        secondXLabel.numberOfLines = 0
        
        let secondPlusLabel = UILabel(frame: CGRect(x: width / 1.55, y: height / 5 + barHeight, width: width / 10, height: height / 20))
        view.addSubview(secondPlusLabel)
        secondPlusLabel.text = "+"
        secondPlusLabel.textColor = .white
        secondPlusLabel.font = secondPlusLabel.font.withSize(width / 10)
        secondPlusLabel.textAlignment = .center
        secondPlusLabel.numberOfLines = 0
        
        // Layout the textfields
        standardToVertexA = DecimalMinusTextField(frame: CGRect(x: width / 6.4, y: height / 5 + barHeight, width: width / 10, height: height / 20))
        view.addSubview(standardToVertexA)
        standardToVertexA.adjustsFontSizeToFitWidth = true
        standardToVertexA.minimumFontSize = 2
        standardToVertexA.keyboardType = UIKeyboardType.decimalPad
        standardToVertexA.font = standardToVertexA.font!.withSize(width / 10)
        standardToVertexA.layer.cornerRadius = width / 40
        standardToVertexA.placeholder = "a"
        standardToVertexA.textAlignment = .center
        standardToVertexA.backgroundColor = .lightGray
        
        standardToVertexB = DecimalMinusTextField(frame: CGRect(x: width / 2.15, y: height / 5 + barHeight, width: width / 10, height: height / 20))
        view.addSubview(standardToVertexB)
        standardToVertexB.adjustsFontSizeToFitWidth = true
        standardToVertexB.minimumFontSize = 2
        standardToVertexB.keyboardType = UIKeyboardType.decimalPad
        standardToVertexB.font = standardToVertexB.font!.withSize(width / 10)
        standardToVertexB.layer.cornerRadius = width / 40
        standardToVertexB.placeholder = "b"
        standardToVertexB.textAlignment = .center
        standardToVertexB.backgroundColor = .lightGray
        
        standardToVertexC = DecimalMinusTextField(frame: CGRect(x: width / 1.3, y: height / 5 + barHeight, width: width / 10, height: height / 20))
        view.addSubview(standardToVertexC)
        standardToVertexC.adjustsFontSizeToFitWidth = true
        standardToVertexC.keyboardType = UIKeyboardType.decimalPad
        standardToVertexC.minimumFontSize = 2
        standardToVertexC.font = standardToVertexC.font!.withSize(width / 10)
        standardToVertexC.layer.cornerRadius = width / 40
        standardToVertexC.placeholder = "c"
        standardToVertexC.textAlignment = .center
        standardToVertexC.backgroundColor = .lightGray
        
    }
    
    func createQuadraticStandardToVertexResults() {
        
        // Reset
        if let viewWithTag = view.viewWithTag(1) {
            viewWithTag.removeFromSuperview()
            
        }
        
        hideKeyBoard()
        resultsArray = []
        
        // Calculate results
        if Int(standardToVertexA.text!) == nil || Int(standardToVertexB.text!) == nil || Int(standardToVertexC.text!) == nil {
            createErrorMessage("Please fill in all blanks with integers")
            return
        }
        
        let height = view.frame.height
        let width = view.frame.width
        let aInput = Int(standardToVertexA.text!)!
        let bInput = Int(standardToVertexB.text!)!
        let cInput = Int(standardToVertexC.text!)!
        
        let quadraticStandardToVertexAnswerA = findHighestCommonFactor(aInput, bInput)
        resultsArray.append(String(quadraticStandardToVertexAnswerA))
        
        let quadraticStandardToVertexAnswerH = Double(-bInput) / Double(2 * aInput)
        resultsArray.append(intChecker(double: quadraticStandardToVertexAnswerH))
        
        let quadraticStandardToVertexAnswerK = Double(aInput) * pow(Double(quadraticStandardToVertexAnswerH), 2) + Double(bInput) * Double(quadraticStandardToVertexAnswerH) + Double(cInput)
        resultsArray.append(intChecker(double: quadraticStandardToVertexAnswerK))

        // Create scroll view for the results
        let resultScrollView:UIScrollView! = UIScrollView(frame: CGRect(x: 0, y: (height / 2) + 2 + (height / 15) + barHeight, width: width, height: height - ((height / 2) + 2 + (height / 15) + barHeight)))
        view.addSubview(resultScrollView)
        resultScrollView.tag = 1
        resultScrollView.isScrollEnabled = true
        resultScrollView.isUserInteractionEnabled = true
        
        // Add the results view
        let resultsView:UIView! = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height - ((height / 2) + 2 + (height / 15) + barHeight)))
        resultScrollView.addSubview(resultsView)
        resultsView.isUserInteractionEnabled = true
        resultsView.translatesAutoresizingMaskIntoConstraints = false
        
        // Properties
        let height1 = resultsView.frame.height
        let width1 = resultsView.frame.width
        var number = 0
        let nameArray = ["a", "h", "k"]
        var top:CGFloat = 0

        // Create results array and display it
        for results in resultsArray {

            let height1:CGFloat = view.frame.height / 20
            let resultsLabel:UILabel! = UILabel(frame: CGRect(x: view.frame.width / 20, y: top, width: view.frame.width - (view.frame.width / 20), height: height1))
            resultsView.addSubview(resultsLabel)
            resultsLabel.text = nameArray[number] + ": " + results
            resultsLabel.textColor = .white
            resultsLabel.alpha = 1
            
            
            top += height1
            number += 1
        }
        
        // Create ()+ results label (Overal)
        let overalDisplayResults:UILabel = UILabel(frame: CGRect(x: 0, y: height1 / 1.5 - height1 / 4, width: width1, height: height1 / 4))
        resultsView.addSubview(overalDisplayResults)
        overalDisplayResults.textAlignment = .center
        overalDisplayResults.text = "a (  x  -  h  )   +  k"
        overalDisplayResults.font = overalDisplayResults.font.withSize(height1 / 8)
        overalDisplayResults.textColor = .white
        
        // Create power label
        let powerLabel:UILabel = UILabel(frame: CGRect(x: width1 / 1.75, y: height1 / 1.6 - height1 / 4, width: width1 / 8, height: height1 / 4))
        resultsView.addSubview(powerLabel)
        powerLabel.textAlignment = .center
        powerLabel.text = "2"
        powerLabel.font = overalDisplayResults.font.withSize(height1 / 16)
        powerLabel.textColor = .white
        
    }
    
    // MARK: - Cosine Rule
    
    func createGeneralCRuleLayout() {
        
        // Properties
        let width = view.frame.width
        let height = view.frame.height
        
        // Create toggle button
        cRuleSwitch = UISwitch(frame: CGRect(x: width / 2 - width / 10, y: height / 2.9, width: width / 10, height: height / 10))
        view.addSubview(cRuleSwitch)
        cRuleSwitch.onTintColor = .gray
        cRuleSwitch.tintColor = .gray
        cRuleSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        cRuleSwitch.center.x = view.center.x
        
        // Create labels on both sides
        let findSideLabel:UILabel = UILabel(frame: CGRect(x: width / 2 - width / 10.1 - width / 5, y: height / 2.9, width: width / 5, height: height / 20))
        view.addSubview(findSideLabel)
        findSideLabel.text = "Find Side"
        findSideLabel.font = findSideLabel.font.withSize(height / 40)
        findSideLabel.textColor = .white
        
        let findAngleLabel:UILabel = UILabel(frame: CGRect(x: width / 1.9 + width / 10, y: height / 2.9, width: width / 4, height: height / 20))
        view.addSubview(findAngleLabel)
        findAngleLabel.text = "Find Angle"
        findAngleLabel.font = findAngleLabel.font.withSize(height / 40)
        findAngleLabel.textColor = .white
        
    }
    
    @objc func switchValueChanged(_ sender:UISwitch!) {
        
        if sender.isOn == true {
            cRuleFindAngle = true
            print(cRuleFindAngle)
        } else {
            cRuleFindAngle = false
            print(cRuleFindAngle)
        }
        
        createSpecificCRuleLayout()
    }

    func createSpecificCRuleLayout() {
        
        if let viewWithTag = view.viewWithTag(1002) {
            
            viewWithTag.removeFromSuperview()
        }
        
        // Cosine rule view
        let cRuleView = UIView(frame: CGRect(x: 0, y: barHeight + view.frame.height / 30 + view.frame.height / 20, width: view.frame.width, height: view.frame.height / 2 - view.frame.height / 30 - view.frame.height / 20 - view.frame.height / 10 - view.frame.height / 9))
        view.addSubview(cRuleView)
        cRuleView.tag = 1002
        
        // Properties
        let width = cRuleView.frame.width
        let height = cRuleView.frame.height
        
        // Create input labels and textfields
        let cRuleSide1Label:UILabel = UILabel(frame: CGRect(x: width / 3, y: height / 4, width: width / 5, height: height / 8))
        cRuleView.addSubview(cRuleSide1Label)
        cRuleSide1Label.textColor = .white
        cRuleSide1Label.text = "Side B:"
        cRuleSide1Label.font = cRuleSide1Label.font.withSize(width / 20)
        
        cRuleSide1TextField = DecimalMinusTextField(frame: CGRect(x: width / 1.8, y: height / 4, width: height / 5, height: height / 5))
        cRuleView.addSubview(cRuleSide1TextField)
        cRuleSide1TextField.placeholder = "B"
        cRuleSide1TextField.adjustsFontSizeToFitWidth = true
        cRuleSide1TextField.font = cRuleSide1TextField.font?.withSize(cRuleSide1TextField.frame.height)
        cRuleSide1TextField.minimumFontSize = 1
        cRuleSide1TextField.textAlignment = .center
        cRuleSide1TextField.backgroundColor = .gray
        cRuleSide1TextField.center.y = cRuleSide1Label.center.y
        cRuleSide1TextField.layer.cornerRadius = cRuleSide1TextField.frame.height / 8
        
        let cRuleSide2Label:UILabel = UILabel(frame: CGRect(x: width / 3, y: height / 1.8, width: width / 5, height: height / 8))
        cRuleView.addSubview(cRuleSide2Label)
        cRuleSide2Label.font = cRuleSide1Label.font.withSize(width / 20)
        cRuleSide2Label.textColor = .white
        cRuleSide2Label.text = "Side C:"
        
        cRuleSide2TextField = DecimalMinusTextField(frame: CGRect(x: width / 1.8, y: height / 4, width: height / 5, height: height / 5))
        cRuleView.addSubview(cRuleSide2TextField)
        cRuleSide2TextField.placeholder = "C"
        cRuleSide2TextField.adjustsFontSizeToFitWidth = true
        cRuleSide2TextField.font = cRuleSide2TextField.font?.withSize(cRuleSide1TextField.frame.height)
        cRuleSide2TextField.minimumFontSize = 1
        cRuleSide2TextField.textAlignment = .center
        cRuleSide2TextField.backgroundColor = .gray
        cRuleSide2TextField.center.y = cRuleSide2Label.center.y
        cRuleSide2TextField.layer.cornerRadius = cRuleSide2TextField.frame.height / 8
        
        // Set specific input labels
        let cRuleSide3Angle1Label:UILabel = UILabel(frame: CGRect(x: width / 3, y: height / 1.2, width: width / 5, height: height / 6))
        cRuleView.addSubview(cRuleSide3Angle1Label)
        cRuleSide3Angle1Label.font = cRuleSide1Label.font.withSize(width / 20)
        cRuleSide3Angle1Label.textColor = .white
        
        if cRuleFindAngle == false {
            
            cRuleSide3Angle1Label.text = "Angle A:"
            
        } else {
            
            cRuleSide3Angle1Label.text = "Side A:"
        }
        
        cRuleSide3Angle1TextField = DecimalMinusTextField(frame: CGRect(x: width / 1.8, y: height / 4, width: height / 5, height: height / 5))
        cRuleView.addSubview(cRuleSide3Angle1TextField)
        cRuleSide3Angle1TextField.placeholder = "A"
        cRuleSide3Angle1TextField.adjustsFontSizeToFitWidth = true
        cRuleSide3Angle1TextField.font = cRuleSide2TextField.font?.withSize(cRuleSide3Angle1TextField.frame.height)
        cRuleSide3Angle1TextField.minimumFontSize = 1
        cRuleSide3Angle1TextField.textAlignment = .center
        cRuleSide3Angle1TextField.backgroundColor = .gray
        cRuleSide3Angle1TextField.center.y = cRuleSide3Angle1Label.center.y
        cRuleSide3Angle1TextField.layer.cornerRadius = cRuleSide3Angle1TextField.frame.height / 8
        
    }
    
    func cRuleCalculateAnswersAndDisplay() {
        
        // Reset
        if let viewWithTag = view.viewWithTag(1) {
            viewWithTag.removeFromSuperview()
            
        }
        
        let height = view.frame.height
        let width = view.frame.width
        
        if Double(cRuleSide1TextField.text!) == nil || cRuleSide1TextField.text == "" || Double(cRuleSide2TextField.text!) == nil || cRuleSide2TextField.text == "" || Double(cRuleSide3Angle1TextField.text!) == nil || cRuleSide3Angle1TextField.text == "" {
            createErrorMessage("Please fill in all blanks with numbers")
            return
        }
        
        let sideB = Double(cRuleSide1TextField.text!)!
        let sideC = Double(cRuleSide2TextField.text!)!
        let sideAngleA = Double(cRuleSide3Angle1TextField.text!)!
        var answer = 0.0
        var answerText = ""
        
        if cRuleFindAngle == false {
            
            // Find side a
            answer = (pow(sideB, 2) + pow(sideC, 2) - 2 * sideB * sideC * cos(sideAngleA * M_PI / 180)).squareRoot()
            answer = roundTo(answer, toNearest: 0.001)
            answerText = "Side A: "
            
        } else {
            
            // Find angle a
            answer = acos((pow(sideB, 2) + pow(sideC, 2) - pow(sideAngleA, 2)) / (2 * sideB * sideC)) * 180 / M_PI
            answer = roundTo(answer, toNearest: 0.001)
            answerText = "Angle A: "

        }
        
        // Create scroll view for the results
        let resultScrollView:UIScrollView! = UIScrollView(frame: CGRect(x: 0, y: (height / 2) + 2 + (height / 15) + barHeight, width: width, height: height - ((height / 2) + 2 + (height / 15))))
        view.addSubview(resultScrollView)
        resultScrollView.tag = 1
        resultScrollView.isScrollEnabled = true
        resultScrollView.isUserInteractionEnabled = true
        
        // Add the results view
        let resultsView:UIView! = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height - ((height / 2) + 2 + (height / 15))))
        resultScrollView.addSubview(resultsView)
        resultsView.isUserInteractionEnabled = true
        resultsView.translatesAutoresizingMaskIntoConstraints = false
        
        let height1 = resultsView.frame.height
        let width1 = resultsView.frame.width
        
        // Create results label
        let resultLabel:UILabel = UILabel(frame: CGRect(x: width1 / 4, y: height1 / 3.5, width: width1 / 2, height: height1 / 5))
        resultsView.addSubview(resultLabel)
        resultLabel.text = answerText + String(answer)
        resultLabel.font = resultLabel.font.withSize(height1 / 6)
        resultLabel.adjustsFontSizeToFitWidth = true
        resultLabel.textColor = .white
        
        
    }
    
    // MARK: - Keyboard functions
    
    @objc func keyboardShowing() {
        
    }
    
    @objc func keyboardHiding() {
        
    }
    
    func hideKeyBoard() {
        
        // Remove Binomial Expander Keyboards
        no1Field.resignFirstResponder()
        coField.resignFirstResponder()
        power1Field.resignFirstResponder()
        power2.resignFirstResponder()
        powerW.resignFirstResponder()
        
        // Remove matrix Inverter Keyboards
        matrixInverterA.resignFirstResponder()
        matrixInverterB.resignFirstResponder()
        matrixInverterC.resignFirstResponder()
        matrixInverterD.resignFirstResponder()
        
        // Remove matrix multiplier keyboards
        matrixMultiplier11.resignFirstResponder()
        matrixMultiplier21.resignFirstResponder()
        matrixMultiplier31.resignFirstResponder()
        matrixMultiplier41.resignFirstResponder()
        matrixMultiplier51.resignFirstResponder()
        matrixMultiplier61.resignFirstResponder()
        matrixMultiplier71.resignFirstResponder()
        matrixMultiplier81.resignFirstResponder()
        matrixMultiplier91.resignFirstResponder()
        matrixMultiplier12.resignFirstResponder()
        matrixMultiplier22.resignFirstResponder()
        matrixMultiplier32.resignFirstResponder()
        matrixMultiplier42.resignFirstResponder()
        matrixMultiplier52.resignFirstResponder()
        matrixMultiplier62.resignFirstResponder()
        matrixMultiplier72.resignFirstResponder()
        matrixMultiplier82.resignFirstResponder()
        matrixMultiplier92.resignFirstResponder()
        matrixMultiplierRow1TextField.resignFirstResponder()
        matrixMultiplierColumn1TextField.resignFirstResponder()
        matrixMultiplierRow2TextField.resignFirstResponder()
        matrixMultiplierColumn2TextField.resignFirstResponder()
        
        // Remove Straight Line Equation Finder Keyboards
        lineEquationFinderX1.resignFirstResponder()
        lineEquationFinderY1.resignFirstResponder()
        lineEquationFinderX2.resignFirstResponder()
        lineEquationFinderY2.resignFirstResponder()
        
        // Remove Quadratic standard to vertex keyboards
        standardToVertexA.resignFirstResponder()
        standardToVertexB.resignFirstResponder()
        standardToVertexC.resignFirstResponder()
        
        // Remove Cosine Rule Keyboards
        cRuleSide1TextField.resignFirstResponder()
        cRuleSide2TextField.resignFirstResponder()
        cRuleSide3Angle1TextField.resignFirstResponder()
        
    }
    
    // MARK: - Helper functions
    
    func intChecker(double:Double) -> String {
        let answer = Double(double) - Double(Int(double))
        var finalAnswer = ""
        if answer == 0 {
            finalAnswer = String(Int(double))
        } else {
            finalAnswer = String(double)
        }
        return finalAnswer
    }
    
    func createTextField(_ textField:DecimalMinusTextField) {
        
        let width = self.view.frame.width / 10
        _ = self.view.frame.height
        
        textField.backgroundColor = .lightGray
        view.addSubview(textField)
        textField.font = textField.font?.withSize(width)
        textField.placeholder = "1"
        textField.adjustsFontSizeToFitWidth = true
        textField.textAlignment = .center
        textField.minimumFontSize = CGFloat(2)
        textField.layer.cornerRadius = width / 4
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let textFieldHeightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: textField, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: width)
        let textFieldWidthConstraint:NSLayoutConstraint = NSLayoutConstraint(item: textField, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: width)
        
        textField.addConstraints([textFieldWidthConstraint, textFieldHeightConstraint])
        
    }

    func createLabel(_ label:UILabel, _ fontSize:CGFloat) {
        
        let width = self.view.frame.width / 5
        let height = self.view.frame.height
        
        view.addSubview(label)
        label.textAlignment = .center
//        label.backgroundColor = .yellow
        label.sizeToFit()
        label.numberOfLines = 0
        label.font = UIFont(name: "Courier", size: fontSize)
        label.textColor = .white
        label.layer.cornerRadius = width / 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let labelCenterYConstraint:NSLayoutConstraint = NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: height / 3.6 + barHeight)
        
        if label == plus {
            labelCenterYConstraint.constant = height / 3.55 + barHeight
        } else if label == lineEquationFinderCoordinate1Label || label == lineEquationFinderLeftBracket1 || label == lineEquationFinderRightBracket1 {
            labelCenterYConstraint.constant = height / 4 + barHeight
        } else if label == lineEquationFinderCoordinate2Label || label == lineEquationFinderLeftBracket2 || label == lineEquationFinderRightBracket2 {
            labelCenterYConstraint.constant = height / 3 + barHeight
        } else if label == lineEquationFinderComma1 {
            labelCenterYConstraint.constant = height / 3.75 + barHeight
        } else if label == lineEquationFinderComma2 {
            labelCenterYConstraint.constant = height / 2.85 + barHeight
        } else {

        }
        
         view.addConstraint(labelCenterYConstraint)
        
    }
    
    func factorial(_ input:Int) -> Int {
        
        // Func for calculating factorial
        var n = input
        
        if n - 1 <= 0 {
            n = 1
            return(n)
        }
        
        for x in 1...(n-1) {
            n = n * x
        }
        
        if n == 0 {
            n = 1
        }
        
        return (n)
    }

    func createErrorMessage(_ error:String) {
        
        let height = self.view.frame.height
        let width = self.view.frame.width
        let Error = error
        
        // Create the error view
        view.addSubview(errorView)
        errorView.alpha = 0
        errorView.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 0.6)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        
        let errorViewHeightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: errorView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height / 20)
        let errorViewWidthConstraint:NSLayoutConstraint = NSLayoutConstraint(item: errorView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width)
        errorView.addConstraints([errorViewWidthConstraint, errorViewHeightConstraint])
        
        let errorViewTopConstraint:NSLayoutConstraint = NSLayoutConstraint(item: errorView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: barHeight)
        let errorViewLeftConstraint:NSLayoutConstraint = NSLayoutConstraint(item: errorView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        view.addConstraints([errorViewTopConstraint, errorViewLeftConstraint])
        
        // Add the errorLabel
        errorView.addSubview(errorLabel)
        errorLabel.sizeToFit()
        errorLabel.numberOfLines = 1
        errorLabel.text = Error
        errorLabel.textAlignment = .center
        errorLabel.textColor = .white
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.font = errorLabel.font.withSize(height / 30)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.center.y = errorView.center.y

        let errorLabelCenterXConstraint:NSLayoutConstraint = NSLayoutConstraint(item: errorLabel, attribute: .centerX, relatedBy: .equal, toItem: errorView, attribute: .centerX, multiplier: 1, constant: 0)
        let errorLabelWidthConstraint:NSLayoutConstraint = NSLayoutConstraint(item: errorLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 3 * view.frame.width / 4)
        //let errorLabelHeightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: errorLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: errorView.frame.height)
        errorLabel.addConstraints([errorLabelWidthConstraint])
        view.addConstraints([errorLabelCenterXConstraint])
        
        UIView.animate(withDuration: 0.25) {
            self.errorView.alpha = 1
        }
        if timer != nil {
            timer?.invalidate()
            
        }
        
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(timerTriggered(_:)), userInfo: nil, repeats: false)
    }
    
    @objc func timerTriggered(_ sender:Timer) {
        
        // Fade out the profile info and swiper down info views
        UIView.animate(withDuration: 0.25) {
            self.errorView.alpha = 0
        }
        
        
    }
    
    @objc func textFieldDidChange(_ textField: DecimalMinusTextField) {
        
        if textField == matrixMultiplierRow1TextField {
            if matrixMultiplierRow1TextField.text == nil {
                return
            } else if Int(matrixMultiplierRow1TextField.text!) == nil {
                return
            } else {
                matrixMultiplierRow1 = Int(matrixMultiplierRow1TextField.text!)!
                setMatrixMultiplierTextFieldsToBlank()
            }
        } else if textField == matrixMultiplierColumn1TextField {
            if matrixMultiplierColumn1TextField.text == nil {
                return
            } else if Int(matrixMultiplierColumn1TextField.text!) == nil {
                return
            } else {
                matrixMultiplierColumn1 = Int(matrixMultiplierColumn1TextField.text!)!
                setMatrixMultiplierTextFieldsToBlank()
            }
        } else if textField == matrixMultiplierRow2TextField {
            if matrixMultiplierRow2TextField.text == nil {
                return
            } else if Int(matrixMultiplierRow2TextField.text!) == nil {
                return
            } else {
                matrixMultiplierRow2 = Int(matrixMultiplierRow2TextField.text!)!
                setMatrixMultiplierTextFieldsToBlank()
            }
        } else if textField == matrixMultiplierColumn2TextField {
            if matrixMultiplierColumn2TextField.text == nil {
                return
            } else if Int(matrixMultiplierColumn2TextField.text!) == nil {
                return
            } else {
                matrixMultiplierColumn2 = Int(matrixMultiplierColumn2TextField.text!)!
                setMatrixMultiplierTextFieldsToBlank()
            }
        }
        createSpecificMatrixMultiplierProperties()
    }
    
    func findHighestCommonFactor(_ input1:Int, _ input2:Int) -> Int {
        
        var input1 = input1
        var input2 = input2
        
        if input1 < 0 {
            input1 = -input1
        }
        
        if input2 < 0 {
            input2 = -input2
        }
        
        let input1Factors = findFactorsOfNumber(input1)
        let input2Factors = findFactorsOfNumber(input2)
        
        var commonFactorsArray = [Int]()
        
        for x in input1Factors {
            for y in input2Factors {
                if y == x {
                    commonFactorsArray.append(y)
                }
            }
        }
        
        if commonFactorsArray == [] {
            return 1
        }
        
        return commonFactorsArray[commonFactorsArray.count - 1]
        
    }

    func findFactorsOfNumber(_ input:Int) -> Array<Int> {
        
        var factorsArray = [Int]()
        if input == 0 {
            factorsArray.append(0)
            return factorsArray
        }
        
        let factorInput = input
        var divider = 1
        var moreFactors = true
        
        while moreFactors == true {
            while divider <= (factorInput / 2) {
                if factorInput%divider == 0 {
                    factorsArray.append(divider)
                }
                divider += 1
            }
            factorsArray.append(factorInput)
            moreFactors = false
        }
        return factorsArray
    }
    
    func saveFaves() {
        
        let defaults = UserDefaults.standard
        defaults.set(faveMathFunctions, forKey: "faveFunctions")
        defaults.synchronize()
        
    }
    
    func loadFaves() {
        
        let defaults = UserDefaults.standard
        
        if let faveMathF = defaults.value(forKey: "faveFunctions") as? [String] {
            faveMathFunctions = faveMathF
        }
        
    }
    
    func toggleFave(function:String) {
        if faveMathFunctions.contains(function) {
            faveMathFunctions = faveMathFunctions.filter { $0 != function }
        } else {
            faveMathFunctions.append(function)
        }
        saveFaves()
        setFaveButtonImage()
    }
    
    func roundTo(_ value: Double, toNearest: Double) -> Double {
        return round(value / toNearest) * toNearest
    }
}

