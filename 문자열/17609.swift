func solution_17609() {
    var ans = [String]()

    func isP(_ str : [String], _ start : Int, _ end : Int) -> Bool {
        var start = start, end = end
        while start < end {
            if str[start] == str[end] {
                start += 1
                end -= 1
            } else {
                return false
            }
        }
        return true
    }

    for _ in 0 ..< Int(readLine()!)! {
        let str = Array(readLine()!).map { String($0) }
        let size = str.count - 1
        var start = 0, end = size, result = 0
        while start < end {
            if str[start] == str[end] {
                start += 1
                end -= 1
            } else {
                if isP(str, start + 1, end) || isP(str, start, end - 1) {
                    result = 1
                } else {
                    result = 2
                }
                break
            }
        }
        ans.append("\(result)")
    }

    print(ans.joined(separator: "\n"))
}
