import Foundation

func solution_1753() {
    /**
     made by 라이노
     */

    final class FileIO {
        private let buffer:[UInt8]
        private var index: Int = 0
        
        init(fileHandle: FileHandle = FileHandle.standardInput) {
            
            buffer = Array(try! fileHandle.readToEnd()!)+[UInt8(0)]
            // 인덱스 범위 넘어가는 것 방지
        }
        
        @inline(__always) private func read() -> UInt8 {
            defer { index += 1 }
            
            return buffer[index]
        }
        
        @inline(__always) func readInt() -> Int {
            var sum = 0
            var now = read()
            var isPositive = true
            
            while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
            if now == 45 { isPositive.toggle(); now = read() } // 음수 처리
            while now >= 48, now <= 57 {
                sum = sum * 10 + Int(now-48)
                now = read()
            }
            
            return sum * (isPositive ? 1:-1)
        }
        
        @inline(__always) func readString() -> String {
            var now = read()
            
            while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
            let beginIndex = index-1
            
            while now != 10,
                  now != 32,
                  now != 0 { now = read() }
            
            return String(bytes: Array(buffer[beginIndex..<(index-1)]), encoding: .ascii)!
        }
        
        @inline(__always) func readByteSequenceWithoutSpaceAndLineFeed() -> [UInt8] {
            var now = read()
            
            while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
            let beginIndex = index-1
            
            while now != 10,
                  now != 32,
                  now != 0 { now = read() }
            
            return Array(buffer[beginIndex..<(index-1)])
        }
    }


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

    struct Vector : Comparable {
        let v : Int
        let w : Int
        
        init(v : Int, w: Int) {
            self.v = v
            self.w = w
        }
        
        static func <(lhs: Vector, rhs : Vector) -> Bool {
            return lhs.w < rhs.w
        }
    }

    let fio = FileIO()

    let v = fio.readInt(), e = fio.readInt(), k = fio.readInt()

    var graph = [[Vector]](repeating: [Vector](), count: v + 1)
    let INF = Int.max
    var dist = [Int](repeating: INF, count: v + 1)

    for _ in 0 ..< e {
        let u = fio.readInt(), v = fio.readInt(), w = fio.readInt()
        let vector = Vector(v: v, w: w)
        graph[u].append(vector)
    }

    extension Heap {
        init() {
            compare = (<)
        }
    }

    func dijkstra(at start: Int) {
        dist[start] = 0
        var heap = Heap<Vector>()
        heap.enqueue(Vector(v: start, w: 0))
        
        while !heap.isEmpty {
            guard let now = heap.dequeue() else { break }
            if dist[now.v] < now.w { continue }
            for next in graph[now.v] {
                let cost = next.w + now.w
                if cost < dist[next.v] {
                    dist[next.v] = cost
                    heap.enqueue(Vector(v: next.v, w: cost))
                }
            }
        }
    }
    dijkstra(at: k)
    for i in 1 ... v {
        print(dist[i] == INF ? "INF" : dist[i])
    }
}
