func solution_9012() {
    var ans = [String]()
    for _ in 0 ..< Int(readLine()!)! {
        let ps = Array(readLine()!).map { String($0) }
        var stk = [String]()
        for c in ps {
            if c == "(" {
                stk.append(c)
            } else {
                if !stk.isEmpty && stk.last! == "(" {
                    stk.removeLast()
                } else {
                    stk.append(c)
                }
            }
        }
        ans.append(stk.isEmpty ? "YES" : "NO")
    }
    print(ans.joined(separator: "\n"))
}
