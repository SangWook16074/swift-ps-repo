func solution_11054() {
    let n = Int(readLine()!)!
    let arr = readLine()!.split(separator: " ").compactMap { Int(String($0)) }
    var dp = [[Int]](repeating: [1, 1], count: n)
    for i in 1 ..< n {
        for j in 0 ..< i {
            if arr[i] > arr[j] { dp[i][0] = max(dp[i][0], dp[j][0] + 1) }
        }
    }

    for i in stride(from: n - 1, to: -1, by: -1) {
        for j in stride(from: n - 1, to: i - 1, by: -1) {
            if arr[i] > arr[j] { dp[i][1] = max(dp[i][1], dp[j][1] + 1) }
        }
    }

    var ans = 0
    for i in 0 ..< n {
        ans = max(ans, dp[i][0] + dp[i][1] - 1)
    }
    print(ans)

}
