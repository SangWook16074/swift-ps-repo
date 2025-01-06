func solution_1010() {
    var dp = [[Int]](repeating: [Int](repeating: 0, count: 30), count: 30)
    for i in 1 ... 29 {
        dp[1][i] = i
    }

    for i in 2 ... 29 {
        dp[i][i] = 1
    }

    for i in 2 ... 29 {
        if (i == 29) { continue }
        for j in i + 1 ... 29 {
            dp[i][j] += dp[i][j - 1] + dp[i - 1][j - 1]
        }
    }
    let t = Int(readLine()!)!
    for _ in 0 ..< t {
        let input = readLine()!.split(separator: " ").map { Int(String($0))! }
        let n = input[0], m = input[1]
        print(dp[n][m])
    }
}
