//
//  NFCViewController.swift
//  iOS11-Example
//
//  Created by Leon on 2017/9/29.
//  Copyright © 2017年 leon. All rights reserved.
//

import UIKit
import CoreNFC

class NFCViewController: UINavigationController {
    // Reference the NFC session
    private var nfcSession: NFCNDEFReaderSession!
    
    // Reference the found NFC messages
    private var nfcMessages: [[NFCNDEFMessage]] = []
    
    func initNFCSession() {
        // Create the NFC Reader Session
        self.nfcSession = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: false)
        self.nfcSession.alertMessage = "You can scan NFC-tags by holding them behind the top of your iPhone."
    }
    
    @objc func beginSession () {
        self.nfcSession.begin()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        self.initNFCSession()
        self.initRFIDSession()
        self.setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        let btn = UIButton(frame: CGRect.init(x: 100, y: 100, width: 100, height: 40))
        btn.addTarget(self, action: #selector(beginSession), for: .touchUpInside)
        btn.setTitleColor(UIColor.blue, for: .normal)
        btn.setTitle("开始扫描", for: .normal)
        self.view.addSubview(btn)
    }
    
    class func formattedTypeNameFormat(from typeNameFormat: NFCTypeNameFormat) -> String {
        switch typeNameFormat {
        case .empty:
            return "Empty"
        case .nfcWellKnown:
            return "NFC Well Known"
        case .media:
            return "Media"
        case .absoluteURI:
            return "Absolute URI"
        case .nfcExternal:
            return "NFC External"
        case .unchanged:
            return "Unchanged"
        default:
            return "Unknown"
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - RFID
    // Reference the RFID session
    private var rfidSession: NFCISO15693ReaderSession!
    
    // Reference the found NFC messages
    private var rfidTags: [[NFCISO15693Tag]] = []

    func initRFIDSession() {
        // Create the RFID Reader Session when the app starts
        // self.rfidSession = NFCISO15693ReaderSession(delegate: self, queue: nil)
        // self.rfidSession.alertMessage = "You can scan RFID-tags by holding them behind the top of your iPhone."
    }
}

// MARK: NFCNDEFReaderSessionDelegate

extension NFCViewController: NFCNDEFReaderSessionDelegate {

    
    //     Called when the reader-session expired, you invalidated the dialog or accessed an invalidated session
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("NFC-Session invalidated: \(error.localizedDescription)")
        // initialize a new session
        self.initNFCSession()
    }

    // Called when a new set of NDEF messages is found
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        print("New NFC Messages (\(messages.count)) detected:")

        for message in messages {
            print(" - \(message.records.count) Records:")
            for record in message.records {
                print("\t- TNF (TypeNameFormat): \(NFCViewController.formattedTypeNameFormat(from: record.typeNameFormat))")
                print("\t- Payload: \(String(data: record.payload, encoding: .utf8)!)")
                print("\t- Type: \(record.type)")
                print("\t- Identifier: \(record.identifier)\n")
            }
        }

        // Add the new messages to our found messages
        self.nfcMessages.append(messages)

        // Reload viewcontroller on the main-thread to display the new data-set
        DispatchQueue.main.async {

        }
    }

}

/*
// MARK: NFCReaderSessionDelegate

extension NFCViewController: NFCReaderSessionDelegate {
    
    func readerSession(_ session: NFCReaderSession, didInvalidateWithError error: Error) {
        print("Error reading RFID-Tag: \(error.localizedDescription)")
    }
 
    func readerSession(_ session: NFCReaderSession, didDetect tags: [NFCTag]) {
        print("\(tags.count) new RFID-Tags detected:")
        
        for tag in tags {
            let rfidTag = tag as! NFCISO15693Tag
            
            print("- Is available: \(rfidTag.isAvailable)")
            print("- Type: \(rfidTag.type)")
            print("- IC Manufacturer Code: \(rfidTag.icManufacturerCode)")
            print("- IC Serial Number: \(rfidTag.icSerialNumber)")
            print("- Identifier: \(rfidTag.identifier)")
            
            // Uncomment to send a custom command. Not sure, yet what to send here.
            //            rfidTag.sendCustomCommand(commandConfiguration: NFCISO15693CustomCommandConfiguration(manufacturerCode: rfidTag.icManufacturerCode,
            //                                                                                                customCommandCode: 0,
            //                                                                                                  requestParameters: nil),
            //                                      completionHandler: { (data, error) in
            //                                        guard error != nil else {
            //                                            return print("Error sending custom command: \(String(describing: error))")
            //                                        }
            //
            //                                        print("Data: \(data)")
            //            })
        }
        
        // Add the new tags to our found tags
        self.rfidTags.append(tags as! [NFCISO15693Tag])
        
        // Reload our viewController on the main-thread to display the new data-set
        DispatchQueue.main.async {

        }
    }
    
    func readerSessionDidBecomeActive(_ session: NFCReaderSession) {
        print("RFID-Tag (\(session)) session did become active")
    }
}
*/


