func solution_11722() {
    let n = Int(readLine()!)!
    let arr = readLine()!.split(separator: " ").compactMap { Int(String($0)) }
    var dp = [Int](repeating: 1, count: n)
    for i in stride(from: n - 1, to: -1, by: -1) {
        for j in stride(from: n - 1, to: i - 1, by: -1) {
            if arr[i] > arr[j] { dp[i] = max(dp[i], dp[j] + 1) }
        }
    }
    print(dp.max()!)
}
