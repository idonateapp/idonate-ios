//
//  BarcodeScannerView.swift
//  iDonate
//
//  Created by Richard Allen on 7/10/14.
//  Copyright (c) 2014 Lapdog. All rights reserved.
//

import UIKit
import AVFoundation

protocol BarcodeScannerViewDelegate {
    func didRecognizeBarcode(_ barcode: String)
}

@IBDesignable
class BarcodeScannerView: UIView, AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var delegate: BarcodeScannerViewDelegate?
    var bug = false
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.blue {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 5.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    var unhighlightedBorderColor: UIColor?
    fileprivate var camPreviewLayer = AVCaptureVideoPreviewLayer()
    fileprivate let captureSession = AVCaptureSession()
    fileprivate let videoCaptureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.masksToBounds = true
        unhighlightedBorderColor = borderColor
        startCamera()
    }
    
    override init(frame: CGRect)  {
        super.init(frame: frame)
    }
    
    fileprivate func startCamera() {
        captureSession.sessionPreset = AVCaptureSessionPreset1280x720
        guard let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice) else { return }
        
        captureSession.addInput(videoInput)
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global())
        //videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.background))
        videoOutput.videoSettings = nil
        
        let metaOutput = AVCaptureMetadataOutput()
        metaOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        captureSession.addOutput(videoOutput)
        captureSession.addOutput(metaOutput)
        
        camPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        camPreviewLayer.frame = bounds
        camPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        /*
         Modify the metadataObjectTypes to suit your specific needs. You should
         probably check what types are available to your device with this:
         println("\(metaOutput.metadataObjectTypes)")
         */
        
        metaOutput.metadataObjectTypes = [AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code]
        
        layer.addSublayer(camPreviewLayer)
        captureSession.startRunning()
        
        //camPreviewLayer!.connection.videoOrientation = videoOrientationForInterfaceOrientation()
    }
    
    //    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
    //        camPreviewLayer.connection.videoOrientation = videoOrientationForInterfaceOrientation()
    //    }
    //
    //    func videoOrientationForInterfaceOrientation() -> AVCaptureVideoOrientation {
    //        switch interfaceOrientation {
    //        case UIInterfaceOrientation.LandscapeLeft:
    //            return AVCaptureVideoOrientation.LandscapeLeft
    //        case UIInterfaceOrientation.LandscapeRight:
    //            return AVCaptureVideoOrientation.LandscapeRight
    //        case UIInterfaceOrientation.Portrait:
    //            return AVCaptureVideoOrientation.Portrait
    //        case UIInterfaceOrientation.PortraitUpsideDown:
    //            return AVCaptureVideoOrientation.PortraitUpsideDown
    //        default:
    //            return AVCaptureVideoOrientation.Portrait
    //        }
    //    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if (!bug) {
            if metadataObjects.count > 0 {
                //highlight()
            }
            
            for object in metadataObjects {
                didRecognizeBarcode((object as AnyObject).stringValue)
                break
            }
            bug = true
        }
    }
    
    fileprivate func didRecognizeBarcode(_ barcode: String) {
        delegate?.didRecognizeBarcode(barcode)
    }
    
    fileprivate func highlight() {
        /*
        if borderColor != UIColor.green {
            borderColor = UIColor.green
            let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: Selector(("unhighlight")), userInfo: nil, repeats: false)
            RunLoop.current.add(timer, forMode: RunLoopMode.defaultRunLoopMode)
        }*/
    }
    
    fileprivate func unhighlight() {
        //borderColor = unhighlightedBorderColor!
    }
    var prefersStatusBarHidden: Bool {
        return true
    }
}
