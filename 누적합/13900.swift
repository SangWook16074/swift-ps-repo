func solution_13900() -> Void {
    let n = Int(readLine()!)!
    let arr = readLine()!.split(separator: " ").map { Int(String($0))! }
    var pSum = Array(repeating: 0, count: n + 1)
    for i in 1 ... n {
        pSum[i] = pSum[i - 1] + arr[i - 1]
    }

    var ans = 0
    for i in 1 ... n {
        ans += arr[i - 1] * (pSum[n] - pSum[i])
    }
    print(ans)
}
