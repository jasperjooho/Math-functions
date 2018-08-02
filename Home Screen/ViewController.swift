//
//  ViewController.swift
//  Math functions
//
//  Created by user on 4/9/17.
//  Copyright © 2017 Obsearch Applications. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties
    // TODO: ?? Add new functions
    // TODO: Finish CRule function
    // Launch Time!!!
    
    var myTableView:UITableView!
    var faveMathFunctions = [String]()
    var nonFaveMathFunctions = [String]()
    var functionSelected:String?
    var isConnectedToInternet = false
    var ref:DatabaseReference!
    var noOfClicksForFunctions = [String:Int]()
    var mathFunctions = ["BExpander", "MInverter", "MMultiplier", "SLEFinder", "QuadraticStoV", "CRule"]
    var displayMathFunctionArray = [String]()
    
    // No of clicks value

    
    // MARK: - Life cycle of view controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkForInternet()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        createAppTitle()
        // Set up the table view
        retrieveDictionaryAndSetOrder { (success) -> Void in
            if success {
                // Do other tasks
                self.loadFaves()
                self.functionsModel(mathFunctions: self.displayMathFunctionArray)
                self.createTableView()
                
            }
        }

    }
    
    // Status bar configuration
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

    // MARK: - Internet Properties
    
    func checkForInternet() {
        if Reachability.isConnectedToNetwork() == true {
            isConnectedToInternet = true
            ref = Database.database().reference()
        } else {
        }
    }
    
    func retrieveNoClicksAndUpdate(functionSelected:String) {
        
        var currentFunction = ""
        
        if functionSelected == "Binomial Expander" {
            currentFunction = "BExpander"
        } else if functionSelected == "2x2 Matrix Inverter" {
            currentFunction = "MInverter"
        } else if functionSelected == "Matrix Multiplier" {
            currentFunction = "MMultiplier"
        } else if functionSelected == "Straight Line Equation Finder" {
            currentFunction = "SLEFinder"
        } else if functionSelected == "Quadratic: Standard to Vertex" {
            currentFunction = "QuadraticStoV"
        } else if functionSelected == "Cosine Rule" {
            currentFunction = "CRule"
        }
        
        if isConnectedToInternet == true {
            
            ref.child("functions").observeSingleEvent(of: .value, with: { (snapshot) in
                
                let functionsDict = snapshot.value as? NSDictionary
                
                // See if data is actually present
                if let actualFunctionsDict = functionsDict {
                    
                    // We actually have a functions dictionary
                    
                    self.noOfClicksForFunctions = actualFunctionsDict as! [String : Int]
                    
                    let currentValue = self.noOfClicksForFunctions[currentFunction]
                    if let currentValue = currentValue {
                        var newValue = currentValue
                        newValue += 1
                        self.ref.child("functions").child(currentFunction).setValue(newValue)
                    }
                } // End of optional binding
                
            })
            
        } else {

        }
    }
    
    // MARK: - Change Order of Table Depending on Popularity
    
    func retrieveDictionaryAndSetOrder(completion: @escaping (_ success: Bool) -> Void) {
        
        if isConnectedToInternet == true {
            
            ref.child("functions").observeSingleEvent(of: .value, with: { (snapshot) in
                
                let functionsDict = snapshot.value as? NSDictionary
                
                // See if data is actually present
                if let actualFunctionsDict = functionsDict {
                    
                    // We actually have a functions dictionary
                    
                    self.noOfClicksForFunctions = actualFunctionsDict as! [String : Int]
                    
                    // Order array
                    self.orderArrayForPopularity(array1: self.displayMathFunctionArray, orderDictionary: self.noOfClicksForFunctions)
                    self.setActualNames(mathFunctions: self.mathFunctions)
                    completion(true)
                    
                } // End of optional binding
                
            })
            
        } else {
           displayMathFunctionArray = ["Binomial Expander", "2x2 Matrix Inverter", "Matrix Multiplier", "Straight Line Equation Finder", "Quadratic: Standard to Vertex", "Cosine Rule"]
            completion(true)
        }
        
    }
    
    func orderArrayForPopularity(array1:Array<String>, orderDictionary:Dictionary<String, Int>) {
        var function1:String!
        var function2:String!
        var continueSort = true
        while continueSort {
            continueSort = false
            function1 = nil
            function2 = nil
            for function in mathFunctions {
                if function1 == nil {
                    function1 = function
                } else if function2 == nil {
                    function2 = function
                } else {
                    function1 = function2
                    function2 = function
                }
                
                if function1 == function {
                    
                } else if noOfClicksForFunctions[function2]! > noOfClicksForFunctions[function1]! {
                    mathFunctions = exchangeElementsInArray(element1: function1, element2: function2, Array: mathFunctions)
                    continueSort = true
                    break
                } else {
                    
                }
            }
            
        }
    }
    
    func exchangeElementsInArray(element1:String, element2:String, Array:Array<String>) -> Array<String> {
        var array = Array
        let index1 = array.index(of: element1)
        let index2 = array.index(of: element2)
        
        array.remove(at: index1!)
        array.remove(at: index2! - 1)
        array.insert(element2, at:index1!)
        array.insert(element1, at:index2!)
        return array
    }
    
    func setActualNames(mathFunctions:Array<String>) {
        var currentFunction = ""
        
        for function in mathFunctions {
            if function == "BExpander" {
                currentFunction = "Binomial Expander"
            } else if function == "MInverter" {
                currentFunction = "2x2 Matrix Inverter"
            } else if function == "MMultiplier" {
                currentFunction = "Matrix Multiplier"
            } else if function == "SLEFinder" {
                currentFunction = "Straight Line Equation Finder"
            } else if function == "QuadraticStoV" {
                currentFunction = "Quadratic: Standard to Vertex"
            } else if function == "CRule" {
                currentFunction = "Cosine Rule"
            }
            
            displayMathFunctionArray.append(currentFunction)
        }
    }

    
    // MARK: - Tableview Functions

    func createTableView() {

        let barHeight = UIApplication.shared.statusBarFrame.size.height
        myTableView = UITableView(frame: CGRect(x: 0, y: view.frame.height / 10 + 10 + barHeight, width: view.frame.width, height: view.frame.height - 10 - view.frame.height / 10 - barHeight))
        myTableView.register(FunctionTableViewCell.self, forCellReuseIdentifier: "mathCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.backgroundColor = .black
        self.view.addSubview(myTableView)
    }
    
    func createAppTitle() {
        let barHeight = UIApplication.shared.statusBarFrame.size.height
        let title = UILabel(frame: CGRect(x: 0, y: 10 + barHeight, width: view.frame.width, height: view.frame.height / 10))
        view.addSubview(title)
        title.text = "MathFunc"
        title.textAlignment = .center
        title.font = UIFont(name: "Courier", size: view.frame.height / 11)
        title.textColor = .white
        
    }

    func functionsModel(mathFunctions: [String]) {
        
        // Get a list of the fave ids
        let faveIds = faveMathFunctions
        
        // Clear nonfave and fave arrays
        nonFaveMathFunctions.removeAll()
        faveMathFunctions.removeAll()
        
        // Go through the list of places and seperate them out into fave and non fave
        for functions in mathFunctions {
            
            if faveIds.contains(functions) {
                
                // Is a fave
                faveMathFunctions.append(functions)
                
            } else {
                
                // Is not a fave
                nonFaveMathFunctions.append(String(functions))
            }
            
        }
        
        // Reload the tableview
        //myTableView.reloadData()

    }
    
    func getFunctionForIndex(indexPath:IndexPath) -> String {
        
        if myTableView.numberOfSections == 1 {
            
            // No faves
            return displayMathFunctionArray[indexPath.row]
            
        } else if myTableView.numberOfSections > 1 && indexPath.section == 0 {
            
            // Faves section
            return faveMathFunctions[indexPath.row]
            
        } else {
            
            // Non faves section
            return nonFaveMathFunctions[indexPath.row]
            
        }
        
    }
    
    func toggleFave(function:String) {
        if faveMathFunctions.contains(function) {
            faveMathFunctions = faveMathFunctions.filter { $0 != function }
        } else {
            faveMathFunctions.append(function)
        }
        functionsModel(mathFunctions: displayMathFunctionArray)
        saveFaves()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        // Return number of rows in tableview
        if tableView.numberOfSections == 1 {
            
            // There are no faves, so return the number of places
            return displayMathFunctionArray.count
            
        } else if tableView.numberOfSections > 1 && section == 0 {
            
            // Fave section, return number of faves
            return faveMathFunctions.count
            
        } else {
            
            // Non Faves section, return number of non faves
            return nonFaveMathFunctions.count
            
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellIdentifier:String = "mathCell"

        let cell = myTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as! FunctionTableViewCell
        
        // Get the function
        let function = getFunctionForIndex(indexPath: indexPath)
        cell.label.text = function
        cell.setSelected(true, animated: true)
        
        // Return the cell
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Set the function selected
        if myTableView.numberOfSections == 1 {
            functionSelected = displayMathFunctionArray[indexPath.row]
        } else if myTableView.numberOfSections > 1 && indexPath.section == 0 {
            functionSelected = faveMathFunctions[indexPath.row]
        } else {
            functionSelected = nonFaveMathFunctions[indexPath.row]
        }
        
        // Call perform segue
        performSegue(withIdentifier: "goToDisplay", sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        // Create a UIView for the background
        let headerView = UIView()
        headerView.backgroundColor = UIColor.black
        
        // Create a label
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(label)
        
        // Set auto layout constraints
        let leftLabelConstraint = NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: headerView, attribute: .left, multiplier: 1, constant: 20)
        let topLabelConstraint = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .top, multiplier: 1, constant: 10)

        
        // Add the constraints
        headerView.addConstraints([leftLabelConstraint, topLabelConstraint])
        
        // Set label text
        if tableView.numberOfSections == 1 {
            label.text = "All Functions"
        } else if tableView.numberOfSections > 1 && section == 0 {
            label.text = "Faves"
        } else {
            label.text = "All"
        }
        
        return headerView
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if faveMathFunctions.count > 0 {
            
            // There's at least 1 fave, so we need 2 sections
            return 2
            
        } else {
            
            return 1
            
        }
        
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // Get place
        let function = getFunctionForIndex(indexPath: indexPath)
        
        // Decide action text
        var actionText = "Fave"
        if tableView.numberOfSections > 1 && indexPath.section == 0 {
            // We're looking at row in the Fave section, so text should be Unfave
            actionText = "Unfave"
        }
        
        // Create action
        let tableAction = UITableViewRowAction(style: .normal, title: actionText) { (action, indexPath) in
            
            // Toggle the fave status
            self.toggleFave(function: function)
            
            // Update the tableview
            self.myTableView.reloadData()
            
        }
        
        return [tableAction]
        
    }
    
    // MARK: - Segue preparation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let displayVC = segue.destination as! displayViewController
        retrieveNoClicksAndUpdate(functionSelected: functionSelected!)
        displayVC.selectedFunction = functionSelected!
        
    }
}

