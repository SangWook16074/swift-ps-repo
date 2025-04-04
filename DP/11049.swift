func solution_11049() {
    let n = Int(readLine()!)!
    let arr = (0 ..< n).map { _ in readLine()!.split(separator: " ").map { Int(String($0))! } }
    var dp = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
    for d in 1 ..< n {
        for start in 0 ..< n - d {
            let end = start + d
            var result = Int.max
            for mid in start ..< end {
                result = min(result, dp[start][mid] + dp[mid + 1][end] + arr[start][0] * arr[mid][1] * arr[end][1])
            }
            dp[start][end] = result
        }
    }

    print(dp[0][n - 1])
}
