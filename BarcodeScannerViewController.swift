//  ViewController.swift
//  BarcodeInventory
//
//  Created by Shrikar Archak on 1/20/15.
//  Copyright (c) 2015 Shrikar Archak. All rights reserved.
//

import UIKit
import AVFoundation

class BarcodeScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    let session = AVCaptureSession()
    
    var previewLayer : AVCaptureVideoPreviewLayer?
    var  identifiedBorder : DiscoveredBarCodeView?
    var timer : NSTimer?
    var itemData = String()
    
    /* Add the preview layer here */
    func addPreviewLayer() {
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer?.bounds = self.view.bounds
        previewLayer?.position = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds))
        self.view.layer.addSublayer(previewLayer!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var error : NSError?
        let videoInput: AVCaptureDeviceInput?
        let videoCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if let inp = videoInput {
            session.addInput(inp)
        } else {
            print(error)
        }
        addPreviewLayer()
        
        identifiedBorder = DiscoveredBarCodeView(frame: self.view.bounds)
        identifiedBorder?.backgroundColor = UIColor.clearColor()
        identifiedBorder?.hidden = true;
        self.view.addSubview(identifiedBorder!)
        
        
        /* Check for metadata */
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        print(output.availableMetadataObjectTypes)
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        session.startRunning()
    }
    
    override func viewWillAppear(animated: Bool) {
        session.startRunning()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(animated: Bool) {
        session.stopRunning()
    }
    
    func translatePoints(points : [AnyObject], fromView : UIView, toView: UIView)->[CGPoint]  {
    var translatedPoints : [CGPoint] = []
    for point in points {
    let dict = point as! NSDictionary
    let x = CGFloat((dict.objectForKey("X") as! NSNumber).floatValue)
    let y = CGFloat((dict.objectForKey("Y") as! NSNumber).floatValue)
    let curr = CGPointMake(x, y)
    let currFinal = fromView.convertPoint(curr, toView: toView)
    translatedPoints.append(currFinal)
    }
    return translatedPoints
    }
    
    func startTimer() {
        if timer?.valid != true {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: #selector(BarcodeScannerViewController.removeBorder), userInfo: nil, repeats: false)
        } else {
            timer?.invalidate()
        }
    }
    
    func removeBorder() {
        /* Remove the identified border */
        self.identifiedBorder?.hidden = true
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        for data in metadataObjects {
            let metaData = data as! AVMetadataObject
            let transformed = previewLayer?.transformedMetadataObjectForMetadataObject(metaData) as? AVMetadataMachineReadableCodeObject
            if let metaDatatext = transformed?.stringValue {
                itemData = (transformed?.stringValue)!
                performSegueWithIdentifier("showScannedItemDetails", sender: self)
            }
            print((transformed?.stringValue)!)
            if let unwraped = transformed {
                identifiedBorder?.frame = unwraped.bounds
                identifiedBorder?.hidden = false
                let identifiedCorners = self.translatePoints(unwraped.corners, fromView: self.view, toView: self.identifiedBorder!)
                identifiedBorder?.drawBorder(identifiedCorners)
                self.identifiedBorder?.hidden = false
                self.startTimer()
                
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
                case "showScannedItemDetails":
                    if let sid = segue.destinationViewController as? ScannedItemDetails {
                        sid.itemData = itemData
                    }
                break
            default: break
            }
        }
    }
}



//import AVFoundation
//import UIKit
//
//class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
//    var captureSession: AVCaptureSession!
//    var previewLayer: AVCaptureVideoPreviewLayer!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.backgroundColor = UIColor.blackColor()
//        captureSession = AVCaptureSession()
//        
//        let videoCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
//        let videoInput: AVCaptureDeviceInput
//        
//        do {
//            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
//        } catch {
//            return
//        }
//        
//        if (captureSession.canAddInput(videoInput)) {
//            captureSession.addInput(videoInput)
//        } else {
//            failed();
//            return;
//        }
//        
//        let metadataOutput = AVCaptureMetadataOutput()
//        
//        if (captureSession.canAddOutput(metadataOutput)) {
//            captureSession.addOutput(metadataOutput)
//            
//            metadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
//            metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypePDF417Code]
//        } else {
//            failed()
//            return
//        }
//        
//        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
//        previewLayer.frame = view.layer.bounds;
//        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
//        view.layer.addSublayer(previewLayer);
//        
//        captureSession.startRunning();
//    }
//    
//    func failed() {
//        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .Alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
//        presentViewController(ac, animated: true, completion: nil)
//        captureSession = nil
//    }
//    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        if (captureSession?.running == false) {
//            captureSession.startRunning();
//        }
//    }
//    
//    override func viewWillDisappear(animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        if (captureSession?.running == true) {
//            captureSession.stopRunning();
//        }
//    }
//    
//    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
//        captureSession.stopRunning()
//        
//        if let metadataObject = metadataObjects.first {
//            let readableObject = metadataObject as! AVMetadataMachineReadableCodeObject;
//            
//            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
//            foundCode(readableObject.stringValue);
//        }
//        
//        dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    func foundCode(code: String) {
//        print(code)
//    }
//    
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
//    
//    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
//        return .Portrait
//    }
//}