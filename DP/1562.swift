func solution_1562() {
    let m = 1_000_000_000
    let n = Int(readLine()!)!
    var dp = [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: 0, count: 1024), count: 10), count: (n+1))
    for i in 1..<10 {
        dp[1][i][1<<i] = 1
    }
    if n > 1 {
        for n in 2...n {
            for i in 0..<10 {
                for j in 0..<1024 {
                    if i > 0 { dp[n][i][j|(1<<i)] += dp[n-1][i-1][j] }
                    if i < 9 { dp[n][i][j|(1<<i)] += dp[n-1][i+1][j] }
                    dp[n][i][j|(1<<i)] %= m
                }
            }
        }
    }
    print(dp[n].reduce(0) { ($0 + $1[1023])%m })
}
