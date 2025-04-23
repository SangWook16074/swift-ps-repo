func solution_1854() {
    struct Heap<T: Comparable> {
        private var data : [T] = []
        private let compare : (T, T) -> Bool
        
        init(_ compare: @escaping (T, T) -> Bool) {
            self.compare = compare
        }
        
        var isEmpty : Bool {
            return data.isEmpty
        }
        
        var top: T? {
            return data.first
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

    struct Edge : Comparable {
        let v : Int
        let w : Int
        
        init(v: Int, w: Int) {
            self.v = v
            self.w = w
        }
        
        static func <(_ lhs: Edge, _ rhs: Edge) -> Bool {
            return lhs.w < rhs.w
        }
    }

    let nmk = readLine()!.split(separator: " ").map { Int(String($0))! }
    let n = nmk[0], m = nmk[1], k = nmk[2]
    var graph = [[Edge]](repeating: [Edge](), count: n + 1)
    var dist = [Heap](repeating: Heap<Int>() { $0 > $1 }, count: n + 1)
    for _ in 0 ..< m {
        let abc = readLine()!.split(separator: " ").map { Int(String($0))! }
        let a = abc[0], b = abc[1], c = abc[2]
        let edge = Edge(v: b, w: c)
        graph[a].append(edge)
    }


    func dijstra(at start : Int) {
        dist[start].enqueue(0)
        var pq = Heap<Edge>() { $0.w < $1.w }
        pq.enqueue(Edge(v: start, w: 0))
        while !pq.isEmpty {
            guard let now = pq.dequeue() else { break }
            for next in graph[now.v] {
                let cost = next.w + now.w
                
                if dist[next.v].count < k || dist[next.v].top! > cost {
                    if dist[next.v].count == k { dist[next.v].dequeue() }
                    dist[next.v].enqueue(cost)
                    pq.enqueue(Edge(v: next.v, w: cost))
                }
            }
        }
    }

    dijstra(at: 1)
    var ans = [String]()
    for i in 1 ... n {
        if dist[i].count < k { ans.append("-1") }
        else {
            ans.append("\(dist[i].top!)")
            
        }
    }
    print(ans.joined(separator: "\n"))
}
