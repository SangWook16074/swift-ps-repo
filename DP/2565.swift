import Foundation
func solution_2565() {
    
    let n = Int(readLine()!)!
    let arr = (0 ..< n).map { _ -> (Int, Int) in
        let ab = readLine()!.split(separator: " ").compactMap { Int(String($0)) }
        let a = ab[0], b = ab[1]
        return (a, b)
    }.sorted { $0.0 < $1.0 }.map { $0.1 }
    var dp = [Int](repeating: 1, count: n)
    for i in 1 ..< n {
        for j in 0 ..< i {
            if arr[i] > arr[j] { dp[i] = max(dp[i], dp[j] + 1) }
        }
    }
    print(n - dp.max()!)

}
