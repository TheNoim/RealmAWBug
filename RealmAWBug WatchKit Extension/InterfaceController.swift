//
//  InterfaceController.swift
//  RealmAWBug WatchKit Extension
//
//  Created by Nils Bergmann on 08.12.17.
//  Copyright © 2017 Noim. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity
import RealmSwift


class InterfaceController: WKInterfaceController, WCSessionDelegate {

    @IBOutlet var loginButton: WKInterfaceButton!
    private var _session: WCSession?
    
    let syncServerURL = URL(string: "Your address")!
    let syncServerAuthURL = URL(string: "Your address")!
    
    var session: WCSession? {
        set(session) {
            self._session = session;
            if session != nil {
                loginButton.setEnabled(true);
            } else {
                loginButton.setEnabled(false);
            }
        }
        get {
            return self._session;
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        guard let currentUser = SyncUser.current else {
            return;
        }
        loginButton.setHidden(true);
        let config = Realm.Configuration(syncConfiguration: SyncConfiguration(user: currentUser, realmURL: syncServerURL))
        let realm = try! Realm(configuration: config)
        let count = realm.objects(Lesson.self).count;
        self.showMessage(title: "Info", message: "Lessons: \(count) Database is now open.");
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    @IBAction func TriggerLogin() {
        if let session = self.session {
            session.sendMessage(["action": "login"], replyHandler: { (message) in
                print(message);
                if let token = message["token"] {
                    let googleCredentials = SyncCredentials.google(token: token as! SyncCredentials.Token);
                    SyncUser.logIn(with: googleCredentials, server: self.syncServerAuthURL, onCompletion: {user, error in
                        if let user = user {
                            self.showMessage(title: "Info", message: "Login successfully. Open realm...", button: "OK");
                            let config = Realm.Configuration(syncConfiguration: SyncConfiguration(user: user, realmURL: self.syncServerURL))
                            Realm.asyncOpen(configuration: config, callbackQueue: DispatchQueue.main, callback: { (realm, error) in
                                if let realm = realm {
                                    let count = realm.objects(Lesson.self).count;
                                    self.showMessage(title: "Info", message: "Lessons: \(count) Database is now open.");
                                } else if let error = error {
                                    self.showMessage(title: "Error", message: error.localizedDescription);
                                }
                            })
                        } else if let error = error {
                            self.showMessage(title: "Error", message: error.localizedDescription);
                            print("\(error)");
                        }
                    });
                }
            }, errorHandler: { (error) in
                print(error.localizedDescription);
            })
        }
    }
    
    private func showMessage(title: String, message: String, button: String = "Cancel") {
        self.presentAlert(withTitle: title, message: message, preferredStyle: WKAlertControllerStyle.alert, actions: [WKAlertAction.init(title: button, style: WKAlertActionStyle.cancel, handler: {})])
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        self.session = session;
    }

}
