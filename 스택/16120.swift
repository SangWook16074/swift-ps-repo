import Foundation

func solution_16120() {
    var input = Array(readLine()!.reversed()).map { String($0) }
    if input.count == 1 {
        print(input.first == "P" ? "PPAP" : "NP")
        exit(0)
    }

    if input.count > 1 && input.count < 4 {
        print("NP")
        exit(0)
    }

    var stk = [String](), index = 0
    while index + 1 < input.count {
        let curr = input[index] + input[index + 1]
        if curr == "PA" {
            stk.append("PA")
            index += 2
        } else if curr == "PP" {
            if !stk.isEmpty {
                stk.removeLast()
                index += 1
            } else {
                print("NP")
                exit(0)
            }
        } else {
            // AP, AA
            print("NP")
            exit(0)
        }
    }
    print(stk.isEmpty ? "PPAP" : "NP")
}
