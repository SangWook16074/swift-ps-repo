func solution_2623() {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let n = input[0], m = input[1]
    var graph = [[Int]](repeating: [Int](), count: n + 1)
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: n + 1), count: n + 1)
    var indegree = [Int](repeating: 0, count: n + 1)
    for _ in 0 ..< m {
        let seq = readLine()!.split(separator: " ").map { Int(String($0))! }
        for i in 1 ..< seq.count - 1 {
            let first = seq[i], second = seq[i + 1]
            if !visited[first][second] {
                visited[first][second] = true
                graph[first].append(second)
                indegree[second] += 1
            }
        }
    }

    var ans = [Int]()

    func topologySort() {
        var queue = [Int]()
        var index = 0
        
        for i in 1 ... n {
            if indegree[i] == 0 {
                queue.append(i)
            }
        }
        
        while index < queue.count {
            let curr = queue[index]
            ans.append(curr)
            index += 1
            for next in graph[curr] {
                indegree[next] -= 1
                if indegree[next] == 0 {
                    queue.append(next)
                }
            }
        }
    }
    topologySort()
    print(ans.count == n ? ans.map { String($0) }.joined(separator: "\n") : 0)
}
