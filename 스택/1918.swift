func solution_1918() {
    let str = readLine()!.compactMap { String($0) }
    var stk = [String](), ans = ""
    for c in str {
        if c == "(" { stk.append(c) }
        else if c == ")" {
            while let last = stk.last, last != "(" {
                ans += stk.popLast()!
            }
            stk.removeLast()
        }
        else if c == "*" || c == "/" {
            while let last = stk.last, last == "*" || last == "/" {
                ans += stk.popLast()!
            }
            stk.append(c)
        }
        else if c == "+" || c == "-" {
            while let last = stk.last, last != "(" {
                ans += stk.popLast()!
            }
            stk.append(c)
        }
        else {
            ans += c
        }
    }

    while !stk.isEmpty {
        ans += stk.popLast()!
    }
    print(ans)

}
