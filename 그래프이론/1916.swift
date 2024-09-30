func solution_1916() -> Void {
    struct Node {
        let v : Int
        let cost : Int
        init(_ e : Int, _ v : Int) {
            self.v = e
            self.cost = v
        }
    }
    let (n, m) = (Int(readLine()!)!, Int(readLine()!)!)
    var dist = Array(repeating: Int.max, count: n)
    var graph = Array(repeating: [Node](), count: n)
    
    for _ in 0 ..< m {
        let input = readLine()!.split(separator: " ").map { Int(String($0))! - 1 }
        let (s, e, v) = (input[0], input[1], input[2] + 1)
        let node = Node(e, v)
        graph[s].append(node)
    }
    
    for i in 0 ..< n {
        graph[i].sort { $0.cost < $1.cost }
    }
    
    let input = readLine()!.split(separator: " ").map { Int(String($0))! - 1 }
    let (start, end) = (input[0], input[1])
    dist[start] = 0
    
    var queue = [start]
    var idx = 0
    
    while idx < queue.count {
        let curr = queue[idx]
        let cost = dist[curr]
        
        for node in graph[curr] {
            let (next, value) = (node.v, node.cost)
            if dist[next] > cost + value {
                dist[next] = cost + value
                queue.append(next)
            }
        }
        
        idx += 1
    }
    print(dist[end])
}
