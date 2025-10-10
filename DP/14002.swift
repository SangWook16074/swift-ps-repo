import Foundation

func solution_14002() {
    let n = Int(readLine()!)!
    let arr = readLine()!.split(separator: " ").compactMap { Int(String($0)) }
    var dp = [[Int]](repeating: [1, -1], count: n + 1)
    var ans = 1, lastIndex = 0
    for i in 0 ..< n {
        for j in 0 ..< i {
            if arr[i] > arr[j] && dp[j][0] + 1 > dp[i][0] {
                dp[i][0] = dp[j][0] + 1
                dp[i][1] = j
            }
            
            if dp[i][0] > ans {
                ans = dp[i][0]
                lastIndex = i
            }
        }
    }
    print(ans)
    var result = [String]()
    while lastIndex != -1 {
        result.append("\(arr[lastIndex])")
        lastIndex = dp[lastIndex][1]
    }
    print(result.reversed().joined(separator: " "))
}
