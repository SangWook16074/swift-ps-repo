import Foundation

func solution_1019() {
    let input = readLine()!
    let arr = input.reversed().map { Int(String($0))! }
    let n = Int(input)!
    var ans = Array(repeating: 0, count: 10)
    for (i, num) in arr.enumerated() {
        let p = Int(pow(10.0, Double(i)))
        
        for j in 0 ... 9 {
            ans[j] += n / (p * 10) * p
        }
        
        if num > 0 {
            for j in 1 ..< num {
                ans[j] += p
            }
        } else {
            ans[0] -= p
        }
        
        ans[num] += n % p + 1
    }
    print(ans.map { String($0) }.joined(separator: " "))
}
