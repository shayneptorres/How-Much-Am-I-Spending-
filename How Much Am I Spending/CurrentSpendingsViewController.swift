import UIKit
import QuartzCore

class CurrentSpendingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Item instances
    var items = [Item]()
    
    // MARK: - Variables
    var totalPrice = 0.00
    var defaults = NSUserDefaults.standardUserDefaults()
    let formatter = NSNumberFormatter()
    let CA_SALES_TAX = 0.0725
    let cellReuseIdentifier = "cell"
    var color = UIColor(netHex:0x25FB79)
    var showItemWasDeleted = false
    var pause = NSTimer()
    var mode = String()
    var budget = Double()
    var overspending = false
    var moneyLeft = Double()
    var shouldShakeAlert = false
    var firstTime = false
    
    // MARK: - Outlet Variables
    @IBOutlet weak var totalPiceDisplay: UILabel!
    @IBOutlet weak var headBar: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var addItemButton: UIButton!
    @IBOutlet weak var clearAllButton: UIButton!
    @IBOutlet weak var itemWasDeletedView: UILabel!
    @IBOutlet weak var amountTitle: UILabel!
    
    
    override func viewDidLoad() {
        // If there is a current list, set it as the Item array
        if defaults.objectForKey("currentTripItems") != nil {
            let itemsList = defaults.objectForKey("currentTripItems") as! NSData
            let encodedCurrentItemsData = NSKeyedUnarchiver.unarchiveObjectWithData(itemsList) as? [Item]
            self.items = encodedCurrentItemsData!
            print("current Items list found")
        } else {
            print("no current items list")
        }
        
        // If there is a current list, but it is empty, set the default view
        checkCurrentList()
        super.viewDidLoad()
        totalPiceDisplay.hidden = true
        headBar.backgroundColor = color
        formatter.numberStyle = .CurrencyStyle
        self.tableView.registerClass(ItemTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        calculateTotalPrice()
        totalPiceDisplay.text = "\(formatter.stringFromNumber(totalPrice)!)"
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTableData:", name: "reload", object: nil)
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
        showItemWasDeleted = defaults.boolForKey("itemWasDeleted")
        if showItemWasDeleted {
            setShowItemWasDeletedAppearance()
            let tempDeletedItemData = defaults.objectForKey("deletedItem") as! NSData
            let tempDeletedItem = NSKeyedUnarchiver.unarchiveObjectWithData(tempDeletedItemData)
            itemWasDeletedView.text = "'\(tempDeletedItem!.name)' was deleted"
            itemWasDeletedView.center.x -= view.bounds.width
            slideInItemWasDeletedView()
            showItemWasDeleted = false
            defaults.setBool(showItemWasDeleted, forKey: "itemWasDeleted")
        }
        totalPrice = 0
        calculateTotalPrice()
        if mode == "freeMode" {
            totalPiceDisplay.text = "\(formatter.stringFromNumber(totalPrice)!)"
        } else {
            totalPiceDisplay.text = "\(formatter.stringFromNumber(moneyLeft)!)"
        }
        totalPiceDisplay.center.x -= view.bounds.width
    }
    
    func setShowItemWasDeletedAppearance(){
        itemWasDeletedView.backgroundColor = UIColor(netHex: 0xFB3125)
        itemWasDeletedView.alpha = 0.85
        itemWasDeletedView.layer.masksToBounds = true
        itemWasDeletedView.layer.cornerRadius = 5
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
        
        if mode == "freeMode" {
            amountTitle.text = "Total Spendings:"
            if items.isEmpty{
            } else {
                for i in items{
                    totalPrice += (i.price + (i.price * CA_SALES_TAX)) * i.quantity
                }
            }
        } else {
            amountTitle.text = "Money Remaining:"
            budget = defaults.doubleForKey("budget")
            print("budget is set: \(budget)")
            moneyLeft = budget
            if items.isEmpty{
                totalPiceDisplay.text = (formatter.stringFromNumber(budget)!)
                print("Check 1: being set")
                print("budget is set: \(budget)")
            } else {
                for i in items {
                    moneyLeft -= ((i.price + (i.price * CA_SALES_TAX)) * i.quantity)
                }
                print("money left: \(moneyLeft)")
                print("budget: \(budget)")
                totalPrice = moneyLeft
            }
        }
        // slide in animaition
        UIView.animateWithDuration(0.3, animations: {
            self.totalPiceDisplay.center.x += self.view.bounds.width
            }, completion: {finished in self.checkForOverspending()})
    }
    
    // Animation Functions
    func slideInItemWasDeletedView(){
        itemWasDeletedView.hidden = false
        UIView.animateWithDuration(0.3, animations: {
            self.itemWasDeletedView.center.x += self.view.bounds.width
            })
            pause = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "slideOutItemWasDeletedView", userInfo: nil, repeats: false)
    }
    
    func slideOutItemWasDeletedView(){
        UIView.animateWithDuration(0.2, animations: {
            self.itemWasDeletedView.center.x += self.view.bounds.width
            }, completion: {finished in self.resetItemWasDeletedView();
                self.itemWasDeletedView.hidden = true})
        pause = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: "resetItemWasDeletedView", userInfo: nil, repeats: false)
    }
    
    func resetItemWasDeletedView(){
        UIView.animateWithDuration(0.1, animations: {
            self.itemWasDeletedView.center.x -= self.view.bounds.width
            }, completion: {finished in })
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
            if moneyLeft <= 5 {
                totalPiceDisplay.textColor = UIColor(netHex: 0xC88009)
                shouldShakeAlert = true
            }
            if moneyLeft <= 0 {
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
    
    // MARK: - Reload Table View
    func reload() {
        let itemsList = defaults.objectForKey("currentTripItems") as! NSData
        let encodedCurrentItemsData = NSKeyedUnarchiver.unarchiveObjectWithData(itemsList) as? [Item]
        self.items = encodedCurrentItemsData!
        self.tableView.reloadData()
        
    }
    
    func reloadTableData(notification: NSNotification) {
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
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You tapped cell number \(indexPath.row).")
        print(self.items[indexPath.row].name)
        print(self.items[indexPath.row].price)
        print(self.items[indexPath.row].quantity)
    }
    
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
        if mode == "freeMode" {
            totalPiceDisplay.text = "$0.00"
        } else {
            moneyLeft = budget
            print(budget)
            print("money Left: \(moneyLeft)")
            totalPiceDisplay.text = (formatter.stringFromNumber(budget)!)
            totalPiceDisplay.textColor = UIColor(netHex: 0xFFFFFF)
        }
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

