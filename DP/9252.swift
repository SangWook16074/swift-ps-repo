func solution_9252() {
    let a = Array(readLine()!)
    let b = Array(readLine()!)
    let n = a.count, m = b.count
    var dp = [[Int]](repeating: [Int](repeating: 0, count: m + 1), count: n + 1)
    for i in 0 ..< n {
        for j in 0 ..< m {
            if a[i] == b[j] {
                dp[i + 1][j + 1] += dp[i][j] + 1
            } else {
                dp[i + 1][j + 1] = max(dp[i][j + 1], dp[i + 1][j])
            }
        }
    }
    print(dp[n][m])
    func back(_ i : Int, _ j : Int) -> String {
        if dp[i][j] == 0 { return "" }
        else if a[i - 1] == b[j - 1] { return back(i - 1, j - 1) + String(a[i-1]) }
        else if dp[i - 1][j] > dp[i][j - 1] { return back(i - 1, j) }
        else { return back(i, j - 1) }
        
    }
    if dp[n][m] != 0 {
        print(back(n, m))
    }
}
