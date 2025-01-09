func solution_10844() {
    let n = Int(readLine()!)!
    var dp = [[Int]](repeating: [Int](repeating: 0, count: 10), count: n + 1)
    for i in 1 ... 9 {
        dp[1][i] = 1
    }
    if n == 1 { print(9) }
    else {
        for i in 2 ... n {
            for j in 0 ... 9 {
                if j == 0 {
                    dp[i][j] = dp[i - 1][1]
                } else if j == 9 {
                    dp[i][j] = dp[i - 1][8]
                } else {
                    dp[i][j] = dp[i - 1][j - 1] + dp[i - 1][j + 1]
                }
                dp[i][j] %= 1_000_000_000
            }
        }
        let ans = dp[n].reduce(0, +)
        print(ans % 1_000_000_000)
    }
}
