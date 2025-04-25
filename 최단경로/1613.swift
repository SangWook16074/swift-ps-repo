func solution_1613() {
    let nk = readLine()!.split(separator: " ").map { Int(String($0))! }
    let n = nk[0], k = nk[1]
    let INF = 401
    var dist = [[Int]](repeating: [Int](repeating: INF, count: n + 1), count: n + 1)

    for _ in 0 ..< k {
        let input = readLine()!.split(separator: " ").map { Int(String($0))! }
        let a = input[0], b = input[1]
        dist[a][b] = 1
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

    for _ in 0 ..< Int(readLine()!)! {
        let input = readLine()!.split(separator: " ").map { Int(String($0))! }
        let s = input[0], e = input[1]
        if dist[s][e] == INF && dist[e][s] != INF { print(1) }
        else if dist[s][e] != INF && dist[e][s] == INF { print(-1) }
        else { print(0) }
    }
}
