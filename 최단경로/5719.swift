func solution_5719() {
    struct Heap<T: Comparable> {
        private var data : [T] = []
        private let compare : (T, T) -> Bool
        
        init(_ compare: @escaping (T, T) -> Bool) {
            self.compare = compare
        }
        
        var isEmpty : Bool {
            return data.isEmpty
        }
        
        var count: Int {
            return data.count
        }
        
        mutating func enqueue(_ element : T) {
            data.append(element)
            siftUp(from: data.count - 1)
        }
        
        mutating func dequeue() -> T? {
            guard !data.isEmpty else { return nil }
            if data.count == 1 { return data.removeLast() }
            let root = data[0]
            data[0] = data.removeLast()
            siftDown(from: 0)
            return root
        }
        
        mutating func siftUp(from index: Int) {
            var childIndex = index
            let child = data[childIndex]
            var parentIndex = (childIndex - 1) / 2
            
            while childIndex > 0 && compare(child, data[parentIndex]) {
                data[childIndex] = data[parentIndex]
                childIndex = parentIndex
                parentIndex = (childIndex - 1) / 2
            }
            
            data[childIndex] = child
        }
        
        mutating func siftDown(from index : Int) {
            var parentIndex = index
            let count = data.count
            while true {
                let leftChildIndex = 2 * parentIndex + 1
                let rightChildIndex = 2 * parentIndex + 2
                var swapIndex = parentIndex
                
                if leftChildIndex < count && compare(data[leftChildIndex], data[swapIndex]) {
                    swapIndex = leftChildIndex
                }
                
                if rightChildIndex < count && compare(data[rightChildIndex], data[swapIndex]) {
                    swapIndex = rightChildIndex
                }
                
                if swapIndex == parentIndex { break }
                
                data.swapAt(swapIndex, parentIndex)
                parentIndex = swapIndex
            }
        }
    }

    extension Heap {
        init() {
            self.compare = (<)
        }
    }

    struct Edge : Comparable {
        
        let v : Int
        let w : Int
        
        init(v : Int, w : Int) {
            self.v = v
            self.w = w
        }
        
        static func < (_ lhs : Edge, _ rhs : Edge) -> Bool {
            return lhs.w < rhs.w
        }
    }

    while true {
        let input = readLine()!.split(separator: " ").map { Int(String($0))! }
        let n = input[0], m = input[1]
        if n == 0 && m == 0 { break }
        let startAndEnd = readLine()!.split(separator: " ").map { Int(String($0))! }
        let start = startAndEnd[0], end = startAndEnd[1]
        var graph = [[Edge]](repeating: [Edge](), count: n)
        var invGraph = [[Edge]](repeating: [Edge](), count: n)
        var isAvail = [[Bool]](repeating: [Bool](repeating: false, count: n), count: n)
        let INF = 499 * 1000 + 1
        var dist : [Int]
        for _ in 0 ..< m {
            let info = readLine()!.split(separator: " ").map { Int(String($0))! }
            let u = info[0], v = info[1], w = info[2]
            let edge = Edge(v: v, w: w)
            let invEdge = Edge(v: u, w: w)
            graph[u].append(edge)
            invGraph[v].append(invEdge)
        }
        
        func dijkstra() {

            dist[start] = 0
            var pq = Heap<Edge>()
            pq.enqueue(Edge(v: start, w: 0))
            
            while !pq.isEmpty {
                guard let now = pq.dequeue() else { break }
                if dist[now.v] < now.w { continue }
                for next in graph[now.v] {
                    if isAvail[now.v][next.v] { continue }
                    let cost = next.w + now.w
                    if cost < dist[next.v] {
                        dist[next.v] = cost
                        pq.enqueue(Edge(v: next.v, w: cost))
                    }
                }
            }
        }
        
        func bfs() {
            var queue = [Int]()
            queue.append(end)
            var index = 0
            while index < queue.count {
                let curr = queue[index]
                if curr == start {
                    index += 1
                    continue
                }
                for prev in invGraph[curr] {
                    if dist[prev.v] + prev.w == dist[curr] && !isAvail[prev.v][curr] {
                        isAvail[prev.v][curr] = true
                        queue.append(prev.v)
                    }
                }
                index += 1
            }
            
        }
        dist = [Int](repeating: INF, count: n)
        dijkstra()
        bfs()
        dist = [Int](repeating: INF, count: n)
        dijkstra()
        print(dist[end] == INF ? -1 : dist[end])
    }
}
