func solution_14938() {
    let nmr = readLine()!.split(separator: " ").map { Int(String($0))! }
    let n = nmr[0], m = nmr[1], r = nmr[2]
    let INF = 9999999
    var dist = [[Int]](repeating: [Int](repeating: INF, count: n + 1), count: n + 1)
    var items = [0] + readLine()!.split(separator: " ").map { Int(String($0))! }

    for _ in 0 ..< r {
        let input = readLine()!.split(separator: " ").map { Int(String($0))! }
        let a = input[0], b = input[1], l = input[2]
        dist[a][b] = l
        dist[b][a] = l
    }

    for i in 1 ... n {
        dist[i][i] = 0
    }

    for k in 1 ... n {
        for i in 1 ... n {
            for j in 1 ... n {
                let cost = dist[i][k] + dist[k][j]
                if dist[i][j] > cost {
                    dist[i][j] = cost
                }
            }
        }
    }

    var ans = 0
    for i in 1 ... n {
        var cnt = 0
        for j in 1 ... n {
            if dist[i][j] <= m {
                cnt += items[j]
            }
        }
        ans = max(ans, cnt)
    }
    print(ans)

}
