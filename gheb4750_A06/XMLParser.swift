//
//  XMLParser.swift
//  gheb4750_A06
//
//  Created by Delina Ghebrekristos on 2020-04-06.
//  Copyright © 2020 Delina Ghebrekristos. All rights reserved.
//

import Foundation
import UIKit

struct RSSItem{
    var imageLink: String
    var title: String
    var desc: String
    var link: String
}


class FeedParser: NSObject, XMLParserDelegate{
    
    private var rssItems: [RSSItem] = []
    private var currentElement = ""
    var processingElement = false
    private var currentTitle : String = "" {
        didSet{
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentImageName : String = "" {
        didSet{
            currentImageName = currentImageName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentDesc : String = "" {
        didSet{
            currentDesc = currentDesc.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentLink : String = "" {
        didSet{
            currentLink = currentLink.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    
    
    private var parseCompletionHandler : (([RSSItem]) -> Void)?
    
    func parseFeed(url: String, completionHandler: (([RSSItem]) -> Void)?){
        
        self.parseCompletionHandler = completionHandler
        
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                if let error = error {
                    print(error.localizedDescription)
                }
                return
            }
            
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
            
        }
        task.resume()
        
    }
    
    //MARK: -XML PARSER DELEGATE
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        
        if currentElement == "item" {
            processingElement = true
        }
        if processingElement{
            switch elementName {
                case "title":
                    currentElement = elementName
                    currentTitle = ""
                case "enclosure":
                    currentElement = elementName
                    currentImageName = attributeDict["url"]!
            case "description":
                    currentElement = elementName
                    currentDesc = ""
            case "link":
                    currentElement = elementName
                    currentLink = ""
            default:
                break
            }
        }
            
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String){
        
        switch currentElement {
        case "title":
            currentTitle += string
        case "enclosure":
            currentImageName += string
        case "description":
            currentDesc += string
        case "link":
            currentLink += string
            
        default:
            break;
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item"{
            let rssItem = RSSItem(imageLink: currentImageName, title: currentTitle, desc: currentDesc, link: currentLink)
            //print(rssItem)
            self.rssItems.append(rssItem)
        }
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        parseCompletionHandler?(rssItems)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
    
}
