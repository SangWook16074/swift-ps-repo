func solution_9466() {
    typealias Edge = (v: Int, e: Int)

    let t = Int(readLine()!)!
    var result = [Int]()
    for _ in 0 ..< t {
        let n = Int(readLine()!)!
        let arr = readLine()!.split(separator: " ").map { Int(String($0))! }
        var edges = [Edge]()
        for i in 1 ... n {
            let edge = (v: i, e: arr[i - 1])
            edges.append(edge)
        }
        
        var visited = [Bool](repeating: false, count: n + 1)
        var complete = [Bool](repeating: false, count: n + 1)
        var cnt = 0
        func dfs(_ start : Int) {
            visited[start] = true
            var curr = arr[start - 1]
            
            if !visited[curr] {
                dfs(curr)
            } else if !complete[curr] {
                while curr != start {
                    cnt += 1
                    curr = arr[curr - 1]
                }
                cnt += 1
            }
            
            complete[start] = true
        }
        
        for i in 1 ... n {
            if !visited[i] {
                dfs(i)
            }
        }
        
        result.append(n - cnt)
    }
    print(result.map { String($0) }.joined(separator: "\n"))
}
