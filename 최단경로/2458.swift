func solution_2458() {
    let nm = readLine()!.split(separator: " ").map { Int(String($0))! }
    let n = nm[0], m = nm[1]
    let INF = 500
    var graph = [[Int]](repeating: [Int](repeating: INF, count: n + 1), count: n + 1)

    for _ in 0 ..< m {
        let ab = readLine()!.split(separator: " ").map { Int(String($0))! }
        let a = ab[0], b = ab[1]
        graph[a][b] = 1
    }

    for k in 1 ... n {
        for i in 1 ... n {
            for j in 1 ... n {
                if graph[i][j] > graph[i][k] + graph[k][j] {
                    graph[i][j] = graph[i][k] + graph[k][j]
                }
            }
        }
    }

    var ans = 0
    for i in 1 ... n {
        var cnt = 0
        for j in 1 ... n {
            if graph[i][j] != INF || graph[j][i] != INF {
                cnt += 1
            }
        }
        
        if cnt == n - 1 { ans += 1 }
    }
    print(ans)
}
