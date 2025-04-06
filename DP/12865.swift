func solution_12865() {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let n = input[0], k = input[1]
    var arr = [[0, 0]]
    for _ in 0 ..< n {
        let input = readLine()!.split(separator: " ").map { Int(String($0))! }
        let w = input[0], v = input[1]
        arr.append([w, v])
    }

    var dp = [[Int]](repeating: [Int](repeating: 0, count: k + 1), count: n + 1)
    for w in 1 ... k {
        for i in 1 ... n {
            let weight = arr[i][0], value = arr[i][1]
            if w < weight {
                dp[i][w] = dp[i - 1][w]
            } else {
                dp[i][w] = max(dp[i - 1][w - weight] + value, dp[i - 1][w])
            }
        }
    }
    print(dp[n][k])
}
