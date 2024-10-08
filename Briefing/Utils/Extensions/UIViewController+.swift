//
//  UIViewController+.swift
//  Briefing
//
//  Created by BoMin on 2023/08/19.
//

import Foundation
import UIKit
import SafariServices

extension UIViewController {
    func openURLInSafari(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.modalPresentationStyle = .pageSheet
        present(safariViewController, animated: true, completion: nil)
    }
    
    func openURLInExternalSafari(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

//MARK: Related to Files
extension UIViewController {
    func createTextFile(withName fileName: String, containing contents: [String]) {
        let documentFolder = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

        let textPath = documentFolder.appendingPathComponent(fileName)

        let combinedContents = contents.joined(separator: "\n")

        if let data = combinedContents.data(using: .utf8) {
            do {
                try data.write(to: textPath)
                print("File written at \(textPath)")
            } catch let e {
                print("Error writing to file: \(e.localizedDescription)")
            }
        } else {
            print("Error encoding string.")
        }
    }
    
    func deleteFile(withName fileName: String) {
        let documentFolder = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let textPath = documentFolder.appendingPathComponent(fileName)

        do {
            try FileManager.default.removeItem(at: textPath)
            print("File deleted at \(textPath)")
        } catch let e {
            print("Error deleting file: \(e.localizedDescription)")
        }
    }
    
    func fileExists(withName fileName: String) -> Bool {
        let documentFolder = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let textPath = documentFolder.appendingPathComponent(fileName)
        return FileManager.default.fileExists(atPath: textPath.path)
    }
    
    func countFilesByDate() {
        
    }
    
    func readTextFile(fileName: String) -> String? {
        let documentFolder = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let textPath = documentFolder.appendingPathComponent(fileName)

        do {
            let text = try String(contentsOf: textPath, encoding: .utf8)
            return text
        } catch {
            print("Error reading text file")
            return nil
        }
    }
}

extension UIViewController {
    
    func addSwipeGestureToDismiss() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.direction = .right
        self.view.addGestureRecognizer(swipeGesture)
    }
    
    @objc private func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
}
