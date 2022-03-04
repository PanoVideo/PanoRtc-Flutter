//
//  RtcGroup.swift
//  pano_rtc
//
//  Copyright © 2022 Pano. All rights reserved.
//

import Foundation
import PanoRtc

protocol RtcGroupManagerInterface {
    func joinGroup(_ params: NSDictionary, _ callback: Callback)
    
    func subscribeGroup(_ params: NSDictionary, _ callback: Callback)
    
    func unsubscribeGroup(_ params: NSDictionary, _ callback: Callback)
    
    func leaveGroup(_ params: NSDictionary, _ callback: Callback)
    
    func inviteGroupUsers(_ params: NSDictionary, _ callback: Callback)
    
    func dismissGroup(_ params: NSDictionary, _ callback: Callback)
    
    func setDefaultGroup(_ params: NSDictionary, _ callback: Callback)
    
    func observeGroup(_ params: NSDictionary, _ callback: Callback)
    
    func unobserveGroup(_ params: NSDictionary, _ callback: Callback)
      
    func observeAllGroups(_ callback: Callback)
    
    func unobserveAllGroups(_ callback: Callback)
}

protocol RtcGroupManagerDelegate: AnyObject {
    func emit(_ methodName: String, _ data: Dictionary<String, Any?>?)
}

@objc
class RtcGroupManager: NSObject, RtcGroupManagerInterface {
    weak var delegate: RtcGroupManagerDelegate?
    private var manager: PanoRtcGroupManager?
    private lazy var managerDelegate: PanoRtcGroupManagerDelegateHandler = {
        PanoRtcGroupManagerDelegateHandler() { [weak self] methodName, data in
            self?.delegate?.emit(methodName, data)
        }
    }()
    
    func setup(manager: PanoRtcGroupManager?) {
        self.manager = manager
        self.manager?.delegate = self.managerDelegate
    }
    
    func cleanup() {
        manager?.delegate = nil
        manager = nil
    }
    
    @objc func joinGroup(_ params: NSDictionary, _ callback: Callback) {
        callback.code(manager?.joinGroup(params["groupId"] as! String, config: PanoRtcGroupConfig(map: params["config"] as! [String: Any])))
    }
    
    @objc func subscribeGroup(_ params: NSDictionary, _ callback: Callback) {
        callback.code(manager?.subscribeGroup(params["groupId"] as! String))
    }
    
    @objc func unsubscribeGroup(_ params: NSDictionary, _ callback: Callback) {
        callback.code(manager?.unsubscribeGroup(params["groupId"] as! String))
    }
    
    @objc func leaveGroup(_ params: NSDictionary, _ callback: Callback) {
        callback.code(manager?.leaveGroup(params["groupId"] as! String))
    }
    
    @objc func inviteGroupUsers(_ params: NSDictionary, _ callback: Callback) {
        guard let users = params["users"] as? [String] else {
            callback.code(PanoResult.invalidArgs)
            return
        }
        
        let userIds = users.map { NSNumber(value: UInt64($0) ?? 0) }
        callback.code(manager?.inviteGroupUsers(params["groupId"] as! String, users: userIds))
    }
    
    @objc func dismissGroup(_ params: NSDictionary, _ callback: Callback) {
        callback.code(manager?.dismissGroup(params["groupId"] as! String))
    }
    
    @objc func setDefaultGroup(_ params: NSDictionary, _ callback: Callback) {
        callback.code(manager?.setDefaultGroup(params["groupId"] as? String))
    }
    
    @objc func observeGroup(_ params: NSDictionary, _ callback: Callback) {
        callback.code(manager?.observeGroup(params["groupId"] as! String))
    }
    
    @objc func unobserveGroup(_ params: NSDictionary, _ callback: Callback) {
        callback.code(manager?.unobserveGroup(params["groupId"] as! String))
    }
      
    @objc func observeAllGroups(_ callback: Callback) {
        callback.code(manager?.observeAllGroups())
    }
    
    @objc func unobserveAllGroups(_ callback: Callback) {
        callback.code(manager?.unobserveAllGroups())
    }
}
