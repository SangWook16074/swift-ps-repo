func solution_13023() -> Void {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let (n, m) = (input[0], input[1])
    var graph = Array(repeating: [Int](), count: n)
    var visited = Array(repeating: false, count: n)
    for _ in 0 ..< m {
        let input = readLine()!.split(separator: " ").map { Int(String($0))! }
        let (a, b) = (input[0], input[1])
        graph[a].append(b)
        graph[b].append(a)
    }
    
    var ans = 0
    func dfs(_ node : Int, _ depth : Int) -> Void {
        if depth == 4 {
            ans = 1
            return
        }
        for n in graph[node] {
            if !visited[n] {
                visited[n] = true
                dfs(n, depth + 1)
                visited[n] = false
            }
        }
    }
    for i in 0 ..< n {
        visited[i] = true
        dfs(i, 0)
        visited[i] = false
        if ans == 1 { break }
    }
    print(ans)
}
