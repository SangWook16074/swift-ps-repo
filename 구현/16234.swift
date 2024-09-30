import Foundation

func solution_16234() -> Void {
    let dx = [1, 0, -1, 0]
    let dy = [0, 1, 0, -1]
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let (n, l, r) = (input[0], input[1], input[2])
    var graph = [[Int]]()
    for _ in 0 ..< n {
        let row = readLine()!.split(separator: " ").map { Int(String($0))! }
        graph.append(row)
    }
    var visited = Array(repeating: Array(repeating: false, count: n), count: n)
    var ans : Int = 0
    
    func check(_ x : Int, _ y : Int) -> Bool {
        var ret = false
        for i in 0 ..< 4 {
            let (nx, ny) = (x + dx[i], y + dy[i])
            if nx < 0 || nx >= n || ny < 0 || ny >= n {
                continue
            }
            if abs(graph[x][y] - graph[nx][ny]) >= l && abs(graph[x][y] - graph[nx][ny]) <= r {
                ret = true
            }
        }
        return ret
    }
    
    func bfs(_ x : Int, _ y : Int) -> Void {
        var total = graph[x][y]
        var queue = [[Int]]()
        var union = [[Int]]()
        visited[x][y] = true
        queue.append([x, y])
        union.append([x, y])
        while !queue.isEmpty {
            let pos = queue.removeFirst()
            let (x, y) = (pos[0], pos[1])
            for i in 0 ..< 4 {
                let (nx, ny) = (x + dx[i], y + dy[i])
                if nx < 0 || nx >= n || ny < 0 || ny >= n { continue }
                if !visited[nx][ny] && (abs(graph[x][y] - graph[nx][ny]) >= l && abs(graph[x][y] - graph[nx][ny]) <= r) {
                    visited[nx][ny] = true
                    union.append([nx, ny])
                    queue.append([nx, ny])
                    total += graph[nx][ny]
                }
            }
        }
        let people = total / union.count
        for u in union {
            let (x, y) = (u[0], u[1])
            graph[x][y] = people
        }
    }
    
    while true {
        var flag = false
        for x in 0 ..< n {
            for y in 0 ..< n {
                if !visited[x][y] && check(x, y) {
                    flag = true
                    bfs(x, y)
                }
            }
        }
        if !flag { break }
        else {
            ans += 1
            for x in 0 ..< n {
                for y in 0 ..< n {
                    visited[x][y] = false
                }
            }
        }
    }
    print(ans)
}
