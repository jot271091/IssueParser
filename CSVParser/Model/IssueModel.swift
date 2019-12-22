import Foundation

class IssueModel {
    var fields: [[Int: Any]]
    
    init() {
        fields = [[Int: Any]]()
    }
    
    func populateFields(csvString: String) {
        let lines = csvString.components(separatedBy: "\n")
        for i in 0..<lines.count {
            let line = lines[i]
            let columns = line.components(separatedBy: ",")
            if(lines[0].components(separatedBy: ",").count == columns.count){
                var field : [Int: Any] = [:]
                for (columnNumber, column) in columns.enumerated() {
                    let key = columnNumber
                    field[key] = Utils.tryToConvertDateToPattern(dateString: column)
                }
                fields.append(field)
            }
            
        }
    }
}
