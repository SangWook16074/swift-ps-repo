func solution_7579() {
    typealias App = (memory: Int, cost: Int)

    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let n = input[0], m = input[1]
    let memories = readLine()!.split(separator: " ").map { Int(String($0))! }
    let costs = readLine()!.split(separator: " ").map { Int(String($0))! }
    let sum = costs.reduce(0) { $0 + $1 }
    var ans = Int.max
    var dp = [[Int]](repeating: [Int](repeating: 0, count: sum + 1), count: n + 1)
    var arr = [(memory: 0, cost: 0)]

    for i in 0 ..< n {
        arr.append((memory: memories[i], cost: costs[i]))
    }

    for i in 1 ... n {
        for j in 0 ... sum {
            dp[i][j] = dp[i - 1][j]
            if j - arr[i].cost >= 0 {
                dp[i][j] = max(dp[i][j], dp[i - 1][j - arr[i].cost] + arr[i].memory)
            }
            
            if dp[i][j] >= m {
                ans = min(ans, j)
            }
        }
    }
    print(ans)
}
