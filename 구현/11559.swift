func solution_11559() {
    var graph = (0 ..< 12).map { _ in Array(readLine()!).map { String($0) } }, visited = [[Bool]](repeating: [Bool](repeating: false, count: 6), count: 12)
    func find(_ x: Int, _ y : Int, _ target: String) -> [[Int]] {
        let dx = [0, 1, 0, -1], dy = [1, 0, -1, 0]
        var queue = [[x, y]], ret = [[x, y]]
        visited[x][y] = true
        while let curr = queue.popLast() {
            let x = curr[0], y = curr[1]
            for i in 0 ..< 4 {
                let nx = x + dx[i], ny = y + dy[i]
                if nx < 0 || nx >= 12 || ny < 0 || ny >= 6 { continue }
                if graph[nx][ny] == target && !visited[nx][ny] {
                    visited[nx][ny] = true
                    ret.append([nx, ny])
                    queue.append([nx, ny])
                }
            }
        }
        return ret
    }
    var ans = 0
    while true {
        var tmp = [[Int]]()
        for x in 0 ..< 12 {
            for y in 0 ..< 6 {
                if graph[x][y] != "." {
                    let result = find(x, y, graph[x][y])
                    if result.count >= 4 {
                        tmp += result
                        
                    }
                }
            }
        }
        if tmp.isEmpty { break }
        ans += 1
        for t in tmp {
            let x = t[0], y = t[1]
            graph[x][y] = "."
        }
        
        for y in 0 ..< 6 {
            var line = (0 ..< 12).reversed().map { x in graph[x][y] }.filter { $0 != "." }
            guard !line.isEmpty else { continue }
            while line.count < 12 { line.append(".") }
            (0 ..< 12).forEach { x in graph[12 - 1 - x][y] = line[x] }
        }
        
        visited = [[Bool]](repeating: [Bool](repeating: false, count: 6), count: 12)
        
    }
    print(ans)
}
