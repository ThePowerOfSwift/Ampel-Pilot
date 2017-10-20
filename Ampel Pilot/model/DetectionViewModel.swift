//
//  DetectionViewModel.swift
//  Ampel Pilot
//
//  Created by Patrick Valenta on 16.10.17.
//  Copyright © 2017 Patrick Valenta. All rights reserved.
//

import AVFoundation

class DetectionViewModel {
    typealias BoundFunction = (()->())?
    
    let dataManager: DataManager
    private var settings: Settings?
    
    public var capturePreset: AVCaptureSession.Preset {
        return settings?.resolution ?? .hd1920x1080
    }
    
    public var confidenceThreshold: Float {
        return settings?.confidenceThreshold ?? 0.3
    }
    
    public var iouThreshold: Float {
        return settings?.iouThreshold ?? 0.5
    }
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func initFetch(_ complete: @escaping () -> ()) {
        self.dataManager.fetchSettings { [weak self] settings in
            self?.settings = settings
            
            DispatchQueue.main.async {
                complete()
            }
        }
    }
}