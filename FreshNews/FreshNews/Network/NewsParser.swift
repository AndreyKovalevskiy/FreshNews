//
//  NewsParser.swift
//  FreshNews
//
//  Created by Andrey Kovalevskiy on 27.12.20.
//

import Foundation

class NewsParser: NSObject, XMLParserDelegate {
   
    let data: Data
    let newsSource: NewsSourceProtocol
    
    var newsItems = [NewsItem]()
    var title: String?
    var sourceName: String?
    var sourceURL: String?
    var descriptionArticle: String?
    var date: String?
    var imageURL: String?
    
    var currentElement: String?
    
    init(data: Data, newsSource: NewsSourceProtocol) {
        self.data = data
        self.newsSource = newsSource
        
    }
    
    func parseXML() {
        let xmlParser = XMLParser(data: data)
        xmlParser.delegate = self
        xmlParser.parse()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
       
        switch elementName {
        case "item":
            title = nil
            sourceName = nil
            sourceURL = nil
            descriptionArticle = nil
            date = nil
            imageURL = nil
        case "enclosure":
            imageURL = attributeDict["url"]
        default:
            break
        }
        
        currentElement = elementName
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "title":
            title = string
        case "description":
            if descriptionArticle != nil {
                break
            } else {
                descriptionArticle = string
            }
        case "pubDate":
            date = string
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item" {
            newsItems.append(NewsItem(title: title!,
                                      sourceName: newsSource.name,
                                      sourceURL: URL(string: newsSource.url)!,
                                      description: descriptionArticle!,
                                      date: Date.fromXMLDateString(dateString: date!)!,
                                      image: nil,
                                      imageURL: URL(string: imageURL!)!,
                                      isRead: false))
            
        }
        currentElement = nil
    }
    
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        if currentElement == "description" {
            descriptionArticle = String.init(data: CDATABlock, encoding: .utf8)
            
            
        }
    }
    
}
