//
//  ViewController.swift
//  RealmAWBug
//
//  Created by Nils Bergmann on 08.12.17.
//  Copyright © 2017 Noim. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate, GIDSignInUIDelegate {
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        print("Recived somthing....");
        if let action = message["action"] {
            print("Received: \(action)");
            switch(action as! String) {
            case "login":
                self.handleLoginRequest(replyHandler: replyHandler);
                break;
            default:
                return;
                break;
            }
        }
    }
    
    func handleLoginRequest(replyHandler: @escaping ([String : Any]) -> Void) {
        DispatchQueue.main.async {
            if let idToken = Share.shared.idToken {
                replyHandler(["token": idToken]);
            } else {
                Share.shared.callbacks.append(replyHandler);
                GIDSignIn.sharedInstance().signIn();
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self;
        if WCSession.isSupported() {
            let session = WCSession.default;
            session.delegate = self
            session.activate()
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("Session: \(activationState)")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Session did become inactive");
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("Session did deactivate");
    }


}

