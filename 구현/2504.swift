import Foundation

func solution_2504() {
    var ans = 0, cnt = 1, flag = false
    let input = readLine()!.map { String($0) }
    var stk = [String]()
    for c in input {
        if c == "(" || c == "[" {
            stk.append(c)
            flag = true
            if c == "(" {
                cnt *= 2
            } else {
                cnt *= 3
            }
        } else {
            if stk.isEmpty {
                print(0)
                exit(0)
            }
            
            if stk.last == "(" && c == ")" {
                if flag {
                    ans += cnt
                }
                flag = false
                cnt /= 2
                stk.removeLast()
            } else if stk.last == "[" && c == "]" {
                if flag {
                    ans += cnt
                }
                flag = false
                cnt /= 3
                stk.removeLast()
            } else {
                print(0)
                exit(0)
            }
        }
    }
    if !stk.isEmpty {
        print(0)
    } else {
        print(ans)
    }
}
