//
//  NSMutableAttributedString+Ext.swift
//  TextKit
//
//  Created by 김승진 on 2021/09/03.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    /// bold
    /// (Bold)김현지 (normal) 소식만 보기
    ///
    /// In This example, 'bold' and `normal`
    ///
    ///     let formattedString = NSMutableAttributedString()
    ///     formattedString.bold("김현지", fontSize: 16.0).normal(" 소식만 보기", fontSize: 16.0)
    ///
    /// - Parameters:
    ///   - text: String
    ///   - fontSize: CGFloat
    ///   - color: optional(UIColor)
    /// - Returns: NSMutableAttributedString
    @discardableResult
    public func bold(_ text: String, fontSize: CGFloat, color: UIColor = .black) -> NSMutableAttributedString {
        let attributedString: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: fontSize),
                                                               .foregroundColor: color]
        let boldString = NSMutableAttributedString(string: text, attributes: attributedString)
        append(boldString)
        
        return self
    }
    
    /// normal
    ///
    /// In This example, 'bold' and `normal`
    ///
    ///     let formattedString = NSMutableAttributedString()
    ///     formattedString.bold("김현지", fontSize: 16.0).normal(" 소식만 보기", fontSize: 16.0)
    ///
    /// - Parameters:
    ///   - text: String
    ///   - fontSize: CGFloat
    ///   - color: optional(UIColor)
    /// - Returns: NSMutableAttributedString
    @discardableResult
    public func normal(_ text: String, fontSize: CGFloat, color: UIColor = .black) -> NSMutableAttributedString {
        let attributedString: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: fontSize),
                                                               .foregroundColor: color]
        let normal = NSMutableAttributedString(string: text, attributes: attributedString)
        append(normal)
        
        return self
    }
    
    /// style
    ///
    /// - Parameters:
    ///   - lineHeight: \n 간격 사이를 조절
    ///   - alignment: text 좌우 정렬
    /// - Returns: NSMutableAttributedString
    @discardableResult
    public func style(lineHeight: CGFloat, alignment: NSTextAlignment? = nil) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        
        if let alignment = alignment {
            paragraphStyle.alignment = alignment
        }
        
        paragraphStyle.lineSpacing = lineHeight
        
        self.addAttribute( .paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: self.length))
        
        return self
    }
    
    /// style
    ///
    /// - Parameters:
    ///   - lineHeight: \n 간격 사이를 조절
    ///   - alignment: text 좌우 정렬
    ///   - lineBreakMode: text wrapping and truncating 설정
    /// - Returns: NSMutableAttributedString
    @discardableResult
    public func style(lineHeight: CGFloat, alignment: NSTextAlignment? = nil, lineBreakMode: NSLineBreakMode) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = lineBreakMode
        
        if let alignment = alignment {
            paragraphStyle.alignment = alignment
        }
        
        paragraphStyle.lineSpacing = lineHeight
        
        self.addAttribute( .paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: self.length))
        
        return self
    }
    
    /// star
    /// 텍스트의 맨뒤에 빨간색 스타일의 star 를 붙입니다.
    /// - Returns: NSMutableAttributedString
    @discardableResult
    public func star() -> NSMutableAttributedString {
        let color = UIColor.init(red: 255.0/255.0, green: 92.0/255.0, blue: 92.0/255.0, alpha: 1.0)
        self.normal(" *", fontSize: 13.0, color: color)
        self.addAttribute(NSAttributedString.Key.baselineOffset, value: 2.0, range: NSRange(location: self.string.count - 1, length: 1))
        
        return self
    }
    
    /// underLine
    /// 전체 Text 를 Underline Style 을 입힙니다.
    /// - Returns: NSMutableAttributedString
    @discardableResult
    public func underLine(range: NSRange? = nil) -> NSMutableAttributedString {
        var nsRange = NSRange(location: 0, length: self.length)
        if let range = range {
            nsRange = range
        }
        self.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: nsRange)
        return self
    }
    
    /// image
    /// Text 의 맨 뒤에 이미지 String 을 추가합니다.
    /// - Parameters:
    ///   - image: UIImage
    ///   - fontSize: CGFloat
    /// - Returns: NSMutableAttributedString
//    @discardableResult
//    public func image(_ image: UIImage, fontSize: CGFloat) -> NSMutableAttributedString {
//        let textAttachment = NSTextAttachment()
//
//        textAttachment.bounds = CGRect(x: 0, y: (font.capHeight - image.size.height).rounded() / 2, width: image.size.width, height: image.size.height)
//        textAttachment.image = image
//
//        self.normal("  ", fontSize: fontSize)
//
//        let attrStringWithImage = NSAttributedString(attachment: textAttachment)
//
//        self.replaceCharacters(in: NSRange(location: self.length - 1, length: 1), with: attrStringWithImage)
//
//        return self
//    }
    
    @discardableResult
    public func replace(text: String, font: UIFont) -> NSMutableAttributedString {
        guard let range = string.range(of: text) else { return self }
        
        self.replace(font: font, range: string.nsRange(from: range))
        
        return self
    }
    
    @discardableResult
    public func replace(text: String, color: UIColor) -> NSMutableAttributedString {
        guard let range = string.range(of: text) else { return self }
        
        self.replace(color: color, range: string.nsRange(from: range))
        
        return self
    }
    
    @discardableResult
    public func replace(font: UIFont, range: NSRange) -> NSMutableAttributedString {
        beginEditing()
        self.enumerateAttribute( .font, in: range) { (_, range, _) in
            removeAttribute( .font, range: range)
            addAttribute( .font, value: font, range: range)
        }
        endEditing()
        
        return self
    }
    
    @discardableResult
    public func replace(color: UIColor, range: NSRange) -> NSMutableAttributedString {
        beginEditing()
        self.enumerateAttribute( .foregroundColor, in: range) { (_, range, _) in
            removeAttribute( .foregroundColor, range: range)
            addAttribute( .foregroundColor, value: color, range: range)
        }
        endEditing()
        
        return self
    }
    
    @discardableResult
    public func replaceStrikethrough(range: NSRange) -> NSMutableAttributedString {
        self.addAttribute( .strikethroughStyle, value: 1, range: range)
        
        return self
    }
    
    @discardableResult
    public func addUnderlined(text: String) -> NSMutableAttributedString {
        guard let range = string.range(of: text) else { return self }
        let nsRange = string.nsRange(from: range)

        beginEditing()
        self.enumerateAttribute( .underlineStyle, in: nsRange) { (_, range, _) in
            addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        }
        endEditing()
        
        return self
    }
    
//    @discardableResult
//    public func compareBold(text: String) -> NSMutableAttributedString {
//        guard !text.isEmpty || !self.string.isEmpty else { return self }
//        let boldFont = UIFont.boldSystemFont(ofSize: font.pointSize)
//        do {
//            let regex = try NSRegularExpression(pattern: text, options: [])
//            let results = regex.matches(in: string,
//                                        options: [],
//                                        range: NSRange(location: 0, length: string.count))
//
//            for result in results {
//                for i in 0 ..< result.numberOfRanges {
//                    let range = result.range(at: i)
//                    self.replace(font: boldFont, range: range)
//                }
//            }
//        } catch let error as NSError {
//            print("func compareBold invalid regex: \(error.localizedDescription)")
//        }
//
//        return self
//    }
    
    @discardableResult
    public func compareStrikethrough(text: String) -> NSMutableAttributedString {
        guard !text.isEmpty || !self.string.isEmpty else { return self }
        do {
            let regex = try NSRegularExpression(pattern: text, options: [])
            let results = regex.matches(in: string,
                                        options: [],
                                        range: NSRange(location: 0, length: string.count))
            
            for result in results {
                for i in 0 ..< result.numberOfRanges {
                    let range = result.range(at: i)
                    self.replaceStrikethrough(range: range)
                }
            }
        } catch let error as NSError {
            print("func compareStrikethrough invalid regex: \(error.localizedDescription)")
        }
        
        return self
    }
}

fileprivate extension StringProtocol where Index == String.Index {
    func nsRange(from range: Range<Index>) -> NSRange {
        return NSRange(range, in: self)
    }
    
    func nsRanges(of string: Self, options: String.CompareOptions = [], range: Range<Index>? = nil, locale: Locale? = nil) -> [NSRange] {
        var start = range?.lowerBound ?? startIndex
        let end = range?.upperBound ?? endIndex
        var ranges: [NSRange] = []
        while start < end, let range = self.range(of: string, options: options, range: start..<end, locale: locale ?? .current) {
            ranges.append(NSRange(range, in: self))
            start = range.upperBound
        }
        return ranges
    }
}
