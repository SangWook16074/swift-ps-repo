func solution_1504() {
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
        
        mutating func enqueue(_ element: T) {
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
        
        private mutating func siftUp(from index : Int) {
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
        
        private mutating func siftDown(from index : Int) {
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

    struct Edge : Comparable {
        let v : Int
        let w : Int
        
        init(v: Int, w: Int) {
            self.v = v
            self.w = w
        }
        
        static func < (_ lhs : Edge, _ rhs : Edge) -> Bool {
            return lhs.w < rhs.w
        }
        
    }

    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let n = input[0], e = input[1]
    var graph = [[Edge]](repeating: [Edge](), count: n + 1)
    let INF = Int.max
    for _ in 0 ..< e {
        let edgeInfo = readLine()!.split(separator: " ").map { Int(String($0))! }
        let u = edgeInfo[0], v = edgeInfo[1], w = edgeInfo[2]
        graph[u].append(Edge(v: v, w: w))
        graph[v].append(Edge(v: u, w: w))
    }
    let two = readLine()!.split(separator: " ").map { Int(String($0))! }
    let v1 = two[0], v2 = two[1]
    func dijkstra(at start : Int, to end : Int) -> Int {
        var dist = [Int](repeating: INF, count: n + 1)
        dist[start] = 0
        var pq = Heap<Edge>() { $0.w < $1.w }
        pq.enqueue(Edge(v: start, w: 0))
        while !pq.isEmpty {
            guard let now = pq.dequeue() else { break }
            if dist[now.v] < now.w { continue }
            for next in graph[now.v] {
                let cost = now.w + next.w
                if cost < dist[next.v] {
                    dist[next.v] = cost
                    pq.enqueue(Edge(v: next.v, w: cost))
                }
            }
        }
        return dist[end]
        
    }
    var ans = INF
    let startv1 = dijkstra(at: 1, to: v1)
    let v1v2 = dijkstra(at: v1, to: v2)
    let v2end = dijkstra(at: v2, to: n)
    if startv1 != INF && v1v2 != INF && v2end != INF {
        ans = min(ans, startv1 + v1v2 + v2end)
    }
    let startv2 = dijkstra(at: 1, to: v2)
    let v2v1 = dijkstra(at: v2, to: v1)
    let v1end = dijkstra(at: v1, to: n)
    if startv2 != INF && v2v1 != INF && v1end != INF {
        ans = min(ans, startv2 + v2v1 + v1end)
    }
    print(ans != INF ? ans : -1)
}
