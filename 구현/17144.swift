func solution_17144() -> Void {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let (r, c, t) = (input[0], input[1], input[2])
    let dx = [0, 1, 0, -1]
    let dy = [1, 0, -1, 0]
    
    var cleaner = [[Int]]()
    var graph = [[Int]]()
    for _ in 0 ..< r {
        let row = readLine()!.split(separator: " ").map { Int(String($0))! }
        graph.append(row)
    }
    
    for x in 0 ..< r {
        for y in 0 ..< c {
            if graph[x][y] == -1 { cleaner.append([x, y]) }
        }
    }
    var time = 0
    while time < t {
        var yellowDust = [[Int]]()
        for x in 0 ..< r {
            for y in 0 ..< c {
                if graph[x][y] > 0 { yellowDust.append([x, y, graph[x][y]])}
            }
        }
        
        for yd in yellowDust {
            let (yx, yy, dust) = (yd[0], yd[1], yd[2])
            for i in 0 ..< 4 {
                let (nx, ny) = (yx + dx[i], yy + dy[i])
                let shareDust = dust / 5
                if shareDust == 0 { continue }
                if nx < 0 || nx >= r || ny < 0 || ny >= c { continue }
                if graph[nx][ny] >= 0 {
                    graph[nx][ny] += shareDust
                    graph[yx][yy] -= shareDust
                }
            }
        }
        
        let (up, down) = (cleaner[0], cleaner[1])
        
        var (curr, prev) = (0, 0)
        
        for i in 0 ..< c - 1 {
            prev = graph[up[0]][i+1]
            graph[up[0]][i+1] = curr
            curr = prev
        }
        
        for i in stride(from: up[0], to: 0, by: -1) {
            prev = graph[i-1][c-1]
            graph[i-1][c-1] = curr
            curr = prev
        }
        
        for i in stride(from: c - 1, to: 0, by: -1) {
            prev = graph[0][i-1]
            graph[0][i-1] = curr
            curr = prev
        }
        
        for i in 0 ..< up[0] - 1 {
            prev = graph[i+1][0]
            graph[i+1][0] = curr
            curr = prev
        }
        
        (curr, prev) = (0, 0)
        
        for i in 0 ..< c - 1 {
            prev = graph[down[0]][i+1]
            graph[down[0]][i+1] = curr
            curr = prev
        }
        
        for i in down[0] ..< r - 1 {
            prev = graph[i+1][c-1]
            graph[i+1][c-1] = curr
            curr = prev
        }
        
        for i in stride(from: c-1, to: 0, by: -1) {
            prev = graph[r-1][i-1]
            graph[r-1][i-1] = curr
            curr = prev
        }
        
        for i in stride(from: r-1, to: down[0] + 1, by: -1) {
            prev = graph[i-1][0]
            graph[i-1][0] = curr
            curr = prev
        }
        
        
        time += 1
    }
    var ans = 0
    for x in 0 ..< r {
        for y in 0 ..< c {
            if graph[x][y] > 0 { ans += graph[x][y] }
        }
    }
    print(ans)
}
