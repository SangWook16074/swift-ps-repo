func solution_14502() -> Void {
    
    func spreadVirus(from v: [Int]) -> Void {
        let (x, y) = (v[0], v[1])
        let dx = [0, 1, 0, -1]
        let dy = [1, 0, -1, 0]
        for i in 0 ..< 4 {
            let (nx, ny) = (x + dx[i], y + dy[i])
            if nx < 0 || nx >= n || ny < 0 || ny >= m { continue }
            if temp[nx][ny] == 0 {
                temp[nx][ny] = 2
                spreadVirus(from: [nx, ny])
            }
        }
    }

    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let (n, m) = (input[0], input[1])
    var graph = [[Int]]()
    var temp = [[Int]]()
    for _ in 0 ..< n {
        let row = readLine()!.split(separator: " ").map { Int(String($0))! }
        graph.append(row)
    }
    var walls = [[Int]]()
    var virus = [[Int]]()
    for x in 0 ..< n {
        for y in 0 ..< m {
            if graph[x][y] == 2 { virus.append([x, y]) }
            else if graph[x][y] == 0 { walls.append([x, y]) }
        }
    }
    var ans = 0
    for i in 0 ..< walls.count {
        graph[walls[i][0]][walls[i][1]] = 1
        for j in i+1 ..< walls.count {
            graph[walls[j][0]][walls[j][1]] = 1
            for k in j+1 ..< walls.count {
                graph[walls[k][0]][walls[k][1]] = 1
                temp = graph
                for v in virus {
                    spreadVirus(from: v)
                }
                var cnt = 0
                for x in 0 ..< n {
                    for y in 0 ..< m {
                        if temp[x][y] == 0 { cnt += 1 }
                    }
                }
                ans = max(cnt, ans)
                graph[walls[k][0]][walls[k][1]] = 0
            }
            graph[walls[j][0]][walls[j][1]] = 0
        }
        graph[walls[i][0]][walls[i][1]] = 0
    }
    print(ans)
}


