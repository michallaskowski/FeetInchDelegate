
import UIKit

public class FeetInchDelegate : NSObject ,UITextFieldDelegate {
    
    public let expression: NSRegularExpression
    public let startingText: String = " ft  in."
    private var hasFeets: Bool = false
    
    override public init(){
        self.expression = try! NSRegularExpression(pattern: "^([0-9]?) ft ((?:[0-9]|10|11)?) in\\.$", options: NSRegularExpressionOptions())
        super.init()
    }
   
    /**
    * Find the position of inches in a string
    */
    public func positionOfValuesInString(string:String) -> (feets:NSRange, inches:NSRange)? {
        let matches = self.expression.matchesInString(string, options: NSMatchingOptions(), range: NSMakeRange(0, string.characters.count))
        guard matches.count == 1 else { return nil }
                
        let feetsPos = matches[0].rangeAtIndex(1)
        let inchesPos = matches[0].rangeAtIndex(2)
        
        return (feetsPos, inchesPos)
    }
    
    public func extractValuesFromString(string: String) -> (feets: Int?, inches: Int?) {
        guard let (feetRange, inchRange) = self.positionOfValuesInString(string) else { return (nil, nil) }
        let str = string as NSString
        let feets = Int(str.substringWithRange(feetRange))
        
        let inchString = str.substringWithRange(inchRange)
        let inches = Int(inchString)
        return (feets, inches)
    }
    
    /**
    * When started editing, check if it matches the regex. If not init proper text, move the cursor to feet position
    * Start observing if text did change
    */
    public func textFieldDidBeginEditing(textField: UITextField) {
        let matches = self.expression.matchesInString(textField.text!, options: NSMatchingOptions(), range: NSMakeRange(0, textField.text!.characters.count))
        if matches.count == 0 {
            textField.text = self.startingText
        }
        
        let (feets, _) = self.extractValuesFromString(textField.text!)
        self.hasFeets = feets != nil
        let offset = self.hasFeets ? 1 : 0
        let position:UITextPosition = textField.positionFromPosition(textField.beginningOfDocument, offset: offset)!
        textField.selectedTextRange = textField.textRangeFromPosition(position, toPosition: position)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldDidChange:", name: UITextFieldTextDidChangeNotification, object: textField)
    }
    
    /**
    * If text field finished editing unsubscribe from notifications
    */
    public func textFieldDidEndEditing(textField: UITextField) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    /**
    * If text was changed, check if user provided feet, then move the cursor to inches position
    */
    public func textFieldDidChange(notification:NSNotification){
        let textField = notification.object! as! UITextField
        guard let (feetsPos, inchesPos) = self.positionOfValuesInString(textField.text!) else { return }
        
        if feetsPos.length > 0 && self.hasFeets == false {
            let offset = inchesPos.location + inchesPos.length
            let position:UITextPosition = textField.positionFromPosition(textField.beginningOfDocument, offset: offset)!
            textField.selectedTextRange = textField.textRangeFromPosition(position, toPosition: position)
        }
        self.hasFeets = feetsPos.length > 0
    }
    
    /**
    * Check if characters pass regex test, and inches are between 0 and 11. (12 inches = 1 foot)
    */
    public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        let text = textField.text! as NSString
        let newText = text.stringByReplacingCharactersInRange(range, withString: string) as String
        let matches = self.expression.matchesInString(newText, options: NSMatchingOptions(), range: NSMakeRange(0, newText.characters.count))
        let matchOk = matches.count == 1
        
        return matchOk
    }
    
}
