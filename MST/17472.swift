func solution_17472() {
    
    typealias Edge = (u: Int, v: Int, w: Int)

    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let n = input[0], m = input[1]
    let dx = [0, 1, 0, -1]
    let dy = [1, 0, -1, 0]
    var graph = [[Int]]()
    for _ in 0 ..< n {
        let row = readLine()!.split(separator: " ").map { Int(String($0))! }
        graph.append(row)
    }

    var visited = [[Bool]](repeating: [Bool](repeating: false, count: m), count: n)
    var cnt = 1

    func numbering(_ x : Int, _ y : Int) {

        for i in 0 ..< 4 {
            let nx = x + dx[i], ny = y + dy[i]
            if nx < 0 || nx >= n || ny < 0 || ny >= m { continue }
            if visited[nx][ny] { continue }
            if graph[nx][ny] == 1 && !visited[nx][ny] {
                visited[nx][ny] = true
                graph[nx][ny] = cnt
                numbering(nx, ny)
            }
        }
    }

    for x in 0 ..< n {
        for y in 0 ..< m {
            if graph[x][y] == 1 && !visited[x][y] {
                visited[x][y] = true
                graph[x][y] = cnt
                numbering(x, y)
                cnt += 1
            }
        }
    }
    var edges = [Edge]()
    func findWay(_ x : Int, _ y : Int, _ u : Int, _ v : Int, _ w : Int) {
        let nx = x + dx[v], ny = y + dy[v]
        if nx < 0 || nx >= n || ny < 0 || ny >= m { return }
        if graph[nx][ny] == u { return }
        if graph[nx][ny] != 0 && w <= 2 { return }
        if graph[nx][ny] != 0 && w > 2 {
            let edge = (u: u, v: graph[nx][ny], w: w - 1)
            edges.append(edge)
            return
        } else {
            findWay(nx, ny, u, v, w + 1)
        }
    }
    var parent = Array(0 ... cnt)
    for x in 0 ..< n {
        for y in 0 ..< m {
            if graph[x][y] != 0 {
                for v in 0 ..< 4 {
                    findWay(x, y, graph[x][y], v, 1)
                }
            }
        }
    }

    func findParent(_ index : Int) -> Int {
        if parent[index] == index { return index }
        else {
            parent[index] = findParent(parent[index])
            return parent[index]
        }
    }

    func unionParent(_ a : Int, _ b : Int) {
        let num1 = findParent(a)
        let num2 = findParent(b)
        if a < b {
            parent[num2] = num1
        } else {
            parent[num1] = num2
        }
    }
    edges = edges.sorted { $0.w < $1.w }
    var edgeCount = 0
    var ans = 0

    for edge in edges {
        let u = edge.u, v = edge.v, w = edge.w
        if findParent(u) != findParent(v) {
            edgeCount += 1
            ans += w
            unionParent(u, v)
        }
    }
    print(edgeCount < cnt - 2 ? -1 : ans)
}
