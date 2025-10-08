func solution_15685() {
    var graph = [[Bool]](repeating: [Bool](repeating: false, count: 101), count: 101)
    let dx = [1, 0, -1, 0], dy = [0, -1, 0, 1]
    for _ in 0 ..< Int(readLine()!)! {
        let xydg = readLine()!.split(separator: " ").compactMap { Int(String($0)) }
        let x = xydg[0], y = xydg[1], d = xydg[2], g = xydg[3]
        graph[x][y] = true
        var vectors = [d], nx = x, ny = y
        
        for _ in 0 ..< g {
            for i in stride(from: vectors.count - 1, to: -1, by: -1) {
                vectors.append((vectors[i] + 1) % 4)
            }
        }
        
        for i in 0 ..< vectors.count {
            nx += dx[vectors[i]]
            ny += dy[vectors[i]]
            graph[nx][ny] = true
        }
    }

    var ans = 0
    for x in 0 ..< 100 {
        for y in 0 ..< 100 {
            if graph[x][y] && graph[x][y + 1] && graph[x + 1][y] && graph[x + 1][y + 1] { ans += 1 }
        }
    }
    print(ans)
}
