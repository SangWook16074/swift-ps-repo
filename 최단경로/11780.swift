func solution_11780() {
    let n = Int(readLine()!)!
    let m = Int(readLine()!)!
    let INF = 100000 * n + 1
    var dist = [[Int]](repeating: [Int](repeating: INF, count: n + 1), count: n + 1)
    var routes = [[[Int]]](repeating: [[Int]](repeating: [], count: n + 1), count: n + 1)



    for _ in 0 ..< m {
        let abc = readLine()!.split(separator: " ").map { Int(String($0))! }
        let a = abc[0], b = abc[1], c = abc[2]
        if dist[a][b] > c {
            routes[a][b] = [a, b]
            dist[a][b] = c
        }
    }

    for i in 1 ... n {
        dist[i][i] = 0
    }

    for k in 1 ... n {
        for s in 1 ... n {
            for e in 1 ... n {
                if dist[s][e] > dist[s][k] + dist[k][e] {
                    dist[s][e] = dist[s][k] + dist[k][e]
                    routes[s][e] = routes[s][k].dropLast() + routes[k][e]
                }
            }
        }
    }

    var ans = [String]()
    for i in 1 ... n {
        ans.append("\(dist[i][1 ... n].map { $0 == INF ? 0 : $0 }.map { String($0) }.joined(separator: " "))")
    }

    for i in 1 ... n {
        for j in 1 ... n {
            ans.append("\(routes[i][j].count) \(routes[i][j].map { String($0) }.joined(separator: " "))")
        }
    }

    print(ans.joined(separator: "\n"))
}
