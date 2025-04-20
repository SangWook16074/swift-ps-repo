func solution_1238() {
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
        
        init(v: Int, w: Int) {
            self.v = v
            self.w = w
        }
        
        static func <(_ lhs: Edge, _ rhs: Edge) -> Bool {
            return lhs.w < rhs.w
        }
    }

    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let n = input[0], m = input[1], x = input[2]
    let INF = Int.max
    var graph = [[Edge]](repeating: [Edge](), count: n + 1)
    var dist = [[Int]](repeating: [Int](repeating: INF, count: n + 1), count: n + 1)

    for _ in 0 ..< m {
        let input = readLine()!.split(separator: " ").map { Int(String($0))! }
        let u = input[0], v = input[1], w = input[2]
        let edge = Edge(v: v, w: w)
        graph[u].append(edge)
    }



    func dijkstra() {
        for i in 1 ... n {
            dist[i][i] = 0
            var heap = Heap<Edge>()
            heap.enqueue(Edge(v: i, w: 0))
            while !heap.isEmpty {
                guard let now = heap.dequeue() else { continue }
                if dist[i][now.v] < now.w { continue }
                for next in graph[now.v] {
                    let cost = now.w + next.w
                    if cost < dist[i][next.v] {
                        dist[i][next.v] = cost
                        heap.enqueue(Edge(v: next.v, w: cost))
                    }
                }
            }
        }
    }

    dijkstra()
    var ans = 0
    for i in 1 ... n {
        let total = dist[i][x] + dist[x][i]
        ans = max(ans, total)
    }
    print(ans)

}
