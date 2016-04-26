import UIKit
class CurrentSpendingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Item instances
    var items = [Item]()
    var i1 = Item(n: "thing", b: "brand", p: 10.00)
    
    // MARK: - Variables
    var totalPrice = 0.00
    var defaults = NSUserDefaults.standardUserDefaults()
    let formatter = NSNumberFormatter()
    let CA_SALES_TAX = 0.0725
    let cellReuseIdentifier = "cell"
    var color = UIColor(netHex:0x25FB79)
    
    // MARK: - Outlet Variables
    @IBOutlet weak var totalPiceDisplay: UILabel!
    @IBOutlet weak var headBar: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var addItemButton: UIButton!


    
    override func viewDidLoad() {
        // If there is a current list, set it as the Item array
        if defaults.objectForKey("currentTripItems") != nil {
            let itemsList = defaults.objectForKey("currentTripItems") as! NSData
            let encodedCurrentItemsData = NSKeyedUnarchiver.unarchiveObjectWithData(itemsList) as? [Item]
            self.items = encodedCurrentItemsData!
            print("current Items list found")
        } else {
            //if not, set a temp cell into the item array
//            i1 = Item(n: "You haven't add any items", b: "No Brand", p: 0.0)
//            items.append(i1)
            print("no current items list")
        }
        
        // If there is a currentllist, but it is empty, set a temp cell
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
        totalPrice = 0
        calculateTotalPrice()
        totalPiceDisplay.text = "\(formatter.stringFromNumber(totalPrice)!)"
        totalPiceDisplay.center.x -= view.bounds.width
    }
    
    func checkCurrentList(){
        if items.isEmpty {
            tableView.hidden = true
        } else {
            tableView.hidden = false
        }
    }
    
    // Calculates value of total price and begin slide in animation
    func calculateTotalPrice(){
        totalPiceDisplay.hidden = false
        if items.isEmpty{
        } else {
            for i in items{
                totalPrice += (i.price + (i.price * CA_SALES_TAX)) * i.quantity
            }
        }
        
        // slide in animaition
        UIView.animateWithDuration(0.55, animations: {
            self.totalPiceDisplay.center.x += self.view.bounds.width
            })
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
    
    // MARK: - Unwind Segues
    @IBAction func saveCurrentItem(segue:UIStoryboardSegue){}
    @IBAction func cancel(segue:UIStoryboardSegue){}
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

