func solution_10159() {
    let n = Int(readLine()!)!
    let m = Int(readLine()!)!
    let INF = 101
    var dist = [[Int]](repeating: [Int](repeating: INF, count: n + 1), count: n + 1)

    for _ in 0 ..< m {
        let ab = readLine()!.split(separator: " ").map { Int(String($0))! }
        let a = ab[0], b = ab[1]
        dist[b][a] = 1
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

    for i in 1 ... n {
        var cnt = 0
        for j in 1 ... n {
            if dist[i][j] == INF && dist[j][i] == INF {
                cnt += 1
            }
        }
        print(cnt - 1)
    }
}
