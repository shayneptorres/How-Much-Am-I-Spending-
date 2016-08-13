import UIKit
import QuartzCore

class CurrentSpendingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Item instances
    var items = [Item]()
    
    // MARK: - Variables
    var totalPrice = 0.00
    var defaults = NSUserDefaults.standardUserDefaults()
    let formatter = NSNumberFormatter()
    let CA_SALES_TAX = 0.08
    let cellReuseIdentifier = "cell"
    var color = UIColor( netHex:0x25FB79)
    var itemThatWasChanged = Item()
    var itemWasChanged = String()
    var showItemWasChanged = false
    var pause = NSTimer()
    var mode = String()
    var budget = 0.0
    var overspending = false
    var shouldShakeAlert = false
    var firstTime = false
    var spendModel = SpendingListModel()
    var hasCurrentTaxObj = false
    var currentTaxObj = TaxObj()
    var currentTaxAmount: Double = 0.0
    
    // MARK: - Outlet Variables
    @IBOutlet weak var totalPiceDisplay: UILabel!
    @IBOutlet weak var headBar: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var addItemButton: UIButton!
    @IBOutlet weak var clearAllButton: UIButton!
    @IBOutlet weak var itemWasChangedView: UILabel!
    @IBOutlet weak var amountTitle: UILabel!
    
    
    
    
    override func viewDidLoad() {
        // If there is a current list, set it as the Item array
        if defaults.valueForKey("firstTime") != nil {
            if defaults.objectForKey("currentTripItems") != nil {
                let itemsList = defaults.objectForKey("currentTripItems") as! NSData
                let encodedCurrentItemsData = NSKeyedUnarchiver.unarchiveObjectWithData(itemsList) as? [Item]
                self.items = encodedCurrentItemsData!
            } else {
            }
        }
        
        // If there is a current list, but it is empty, set the default view
        checkCurrentList()
        super.viewDidLoad()
        setAppearances()
        self.tableView.registerClass(ItemTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        currentTaxAmount = spendModel.setCurrentTaxObject()
//        setCurrentTaxObject()
        calculateTotalPrice()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CurrentSpendingsViewController.reloadTableData(_:)), name: "reload", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        checkCurrentList()
        totalPiceDisplay.hidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        if defaults.valueForKey("firstTime") == nil {
            showFirstTimeUserAlert(self)
        }
        defaults.setValue(firstTime, forKey: "firstTime")

        checkItemWasChangedValue()
        if showItemWasChanged {
            setShowItemWasChangedAppearance()
            itemWasChangedView.center.x -= view.bounds.width
            slideInItemWasChangedView()
            showItemWasChanged = false
        }
        totalPrice = 0
        calculateTotalPrice()
        totalPiceDisplay.center.x -= view.bounds.width
    }
    
    func setAppearances(){
        totalPiceDisplay.hidden = true
//        headBar.backgroundColor = color
        formatter.numberStyle = .CurrencyStyle
    }
    
    func setCurrentTaxObject(){
        if defaults.objectForKey("currentTaxObj") != nil{
            hasCurrentTaxObj = true
            
            let tempData = defaults.objectForKey("currentTaxObj") as! NSData
            let encodedData = NSKeyedUnarchiver.unarchiveObjectWithData(tempData)
            currentTaxObj = encodedData as! TaxObj
            currentTaxAmount = currentTaxObj.taxRate
        } else {
            defaults.setDouble(CA_SALES_TAX, forKey: "currentTaxAmount")
        }
    }
    
    func checkItemWasChangedValue(){
        if defaults.valueForKey("itemWasChanged") != nil {
        var tempStr = defaults.valueForKey("itemWasChanged")! as! String
        if tempStr == "added"
            || tempStr == "edited"
            || tempStr == "deleted"
        {
            itemWasChanged = defaults.valueForKey("itemWasChanged") as! String
            let tempData = defaults.valueForKey("itemThatWasChanged") as! NSData
            itemThatWasChanged = NSKeyedUnarchiver.unarchiveObjectWithData(tempData) as! Item
            showItemWasChanged = true
        } else {
            itemWasChanged = "noChange"
        }
        tempStr = ""
        defaults.setValue(tempStr, forKey: "itemWasChanged")
        }
    }
    
    // Settings for the itemWasChangedAlert
    func setShowItemWasChangedAppearance(){
        let appearanceObj = spendModel.setChangedItemAppearance(itemWasChanged, itemThatChanged: itemThatWasChanged.name)
        itemWasChangedView.backgroundColor = UIColor(netHex: appearanceObj.hex)
        itemWasChangedView.alpha = CGFloat(appearanceObj.alpha)
        itemWasChangedView.layer.masksToBounds = appearanceObj.bounds
        itemWasChangedView.layer.cornerRadius = CGFloat(appearanceObj.cornRad)
        itemWasChangedView.text = appearanceObj.text
    }
    
    func setAmountTitleAppearance(){
        amountTitle.backgroundColor = UIColor(netHex: 0xFFFFFF)
        amountTitle.layer.masksToBounds = true
        amountTitle.layer.cornerRadius = 5
    }
    
    func checkCurrentList(){
        if items.isEmpty {
            tableView.hidden = true
            clearAllButton.hidden = true
        } else {
            tableView.hidden = false
            clearAllButton.hidden = false
        }
    }
    
    // Calculates value of total price and begin slide in animation
    func calculateTotalPrice(){
        totalPiceDisplay.hidden = false
        totalPiceDisplay.textColor = UIColor(netHex: 0xFFFFFF)
        if defaults.valueForKey("mode") != nil {
            mode = defaults.valueForKey("mode") as! String
        } else {
            mode = "freeMode"
        }
        
        budget = defaults.doubleForKey("budget")
        amountTitle.text = spendModel.setTotalPrice(items, mode: mode).title
        totalPrice = spendModel.setTotalPrice(items, mode: mode).price
        totalPiceDisplay.text = (formatter.stringFromNumber(totalPrice)!)
        
        // slide in animaition
        UIView.animateWithDuration(0.3, animations: {
            self.totalPiceDisplay.center.x += self.view.bounds.width
            }, completion: {finished in self.checkForOverspending()})
    }

    
    // Animation Functions
    
    func slideOutTotalPriceDisplay(){
        UIView.animateWithDuration(0.3, animations: {
            self.totalPiceDisplay.center.x -= self.view.bounds.width
            }, completion: {finished in})
    }
    
    func slideInItemWasChangedView(){
        
        itemWasChangedView.hidden = false
        UIView.animateWithDuration(0.3, animations: {
            self.itemWasChangedView.center.x += self.view.bounds.width
            })
        pause = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(CurrentSpendingsViewController.slideOutItemWasChangedView), userInfo: nil, repeats: false)
    }
    
    func slideOutItemWasChangedView(){
        UIView.animateWithDuration(0.2, animations: {
            self.itemWasChangedView.center.x += self.view.bounds.width
            }, completion: {finished in self.resetItemWasChangedView();
                self.itemWasChangedView.hidden = true})
        pause = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(CurrentSpendingsViewController.resetItemWasChangedView), userInfo: nil, repeats: false)
    }
    
    func resetItemWasChangedView(){
        UIView.animateWithDuration(0.1, animations: {
            self.itemWasChangedView.center.x -= self.view.bounds.width
            }, completion: {finished in })
        showItemWasChanged = false
    }
    
    func shakeTotalPriceLabel(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.08
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(totalPiceDisplay.center.x - 10, totalPiceDisplay.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(totalPiceDisplay.center.x + 10, totalPiceDisplay.center.y))
        totalPiceDisplay.layer.addAnimation(animation, forKey: "position")
    }
    
    func checkForOverspending(){
        if mode == "budgetMode" {
            shouldShakeAlert = false
            if totalPrice <= 5 {
                totalPiceDisplay.textColor = UIColor(netHex: 0xC88009)
                shouldShakeAlert = true
            }
            if totalPrice <= 0 {
                totalPiceDisplay.textColor = UIColor(netHex: 0xFB3125)
                overspending = true
                shouldShakeAlert = true
            }
            if shouldShakeAlert {
                shakeTotalPriceLabel()
            }
        } else {
            
        }
    }
    
    
    // MARK: - Table View Functions
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "EditItem":
                let indexPath:NSIndexPath = self.tableView.indexPathForSelectedRow!
                if let eivc = segue.destinationViewController as?
                    EditItemViewController {
                    eivc.item = self.items[indexPath.row]
                }
            default: break
            }
        }
    }
    
    // Swipe to delete table view cell
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            items.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            let currentListData = NSKeyedArchiver.archivedDataWithRootObject(items)
            defaults.setObject(currentListData, forKey: "currentTripItems")
            UIView.animateWithDuration(0.3, animations: {
                self.totalPiceDisplay.center.x -= self.view.bounds.width
                }, completion: {finished in self.viewDidLoad()})
//            pause = NSTimer.scheduledTimerWithTimeInterval(0.75, target: self, selector: #selector(CurrentSpendingsViewController.calculateTotalPrice), userInfo: nil, repeats: false)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    // Reload Table View
    func reload() {
        let itemsList = defaults.objectForKey("currentTripItems") as! NSData
        let encodedCurrentItemsData = NSKeyedUnarchiver.unarchiveObjectWithData(itemsList) as? [Item]
        self.items = encodedCurrentItemsData!
        self.tableView.reloadData()
        
    }
    
    func reloadTableData(s: NSNotification) {
        reload()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // number of rows in table view
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // create a cell for each table view row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Item", forIndexPath: indexPath) as! ItemTableViewCell
        cell.item = self.items[indexPath.row]
        return cell
    }
    
    // method to run when table view cell is tapped
 
    
    // MARK: - Alerts
    @IBAction func ShowClearAllAlert(sender: UIButton) {
        let clearAllAlert = UIAlertController(title: "Clear All", message: "Are you sure you want to clear all items on the current list?", preferredStyle: UIAlertControllerStyle.Alert)
        let confirmAction = UIAlertAction(
            title: "Yes", style: UIAlertActionStyle.Destructive) { (action) in
                self.clearAll()
        }
        let dissmissAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Default) { (action) in}
        clearAllAlert.addAction(confirmAction)
        clearAllAlert.addAction(dissmissAction)
        self.presentViewController(clearAllAlert, animated: true, completion: nil)
    }
    
    // Welcome alert for first time users
    @IBAction func showFirstTimeUserAlert(sender: CurrentSpendingsViewController){
        let firstTimeAlert = UIAlertController(title: "Welcome!", message: "You are currently in FreeSpend Mode. If you would like to change to BudgetMode or if you have no idea what either is, go to the settings tab and learn about both.", preferredStyle: UIAlertControllerStyle.Alert)
        let dissmissAction = UIAlertAction(title: "Cool!", style: UIAlertActionStyle.Default) { (action) in}
        firstTimeAlert.addAction(dissmissAction)
        self.presentViewController(firstTimeAlert, animated: true, completion: nil)
    }
    
    func clearAll(){
        items.removeAll()
        let currentListData = NSKeyedArchiver.archivedDataWithRootObject(items)
        defaults.setObject(currentListData, forKey: "currentTripItems")
        checkCurrentList()
        slideOutTotalPriceDisplay()
        calculateTotalPrice()
    }
    // MARK: - Unwind Segues
    @IBAction func saveCurrentItem(segue:UIStoryboardSegue){}
    @IBAction func cancel(segue:UIStoryboardSegue){}
    @IBAction func backToCurrentSpendings(segue:UIStoryboardSegue){}
}

// MARK: - Custom Colors, use HEX to set color
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

// MARK: - Custom Dynamic Labels
extension UILabel {
    func resizeHeightToFit(heightConstraint: NSLayoutConstraint) {
        let attributes = [NSFontAttributeName : font]
        numberOfLines = 0
        lineBreakMode = NSLineBreakMode.ByWordWrapping
        let rect = text!.boundingRectWithSize(CGSizeMake(frame.size.width, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
        heightConstraint.constant = rect.height
        setNeedsLayout()
    }
}

