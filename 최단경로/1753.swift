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
        private var elements: [T] = []
        private let comparer: (T, T) -> Bool
        
        var isEmpty: Bool {
            return elements.count <= 1
        }
        
        var top: T? {
            return isEmpty ? nil : elements[1]
        }
        
        init(comparer: @escaping (T,T) -> Bool) {
            self.comparer = comparer
        }
        
        mutating func insert(_ element: T) {
            if elements.isEmpty {
                elements.append(element)
                elements.append(element)
                return
            }
            elements.append(element)
            swimUp(index: elements.count - 1)
        }
        
        mutating private func swimUp(index: Int) {
            var index = index
            while index > 1 && comparer(elements[index], elements[index / 2]) {
                elements.swapAt(index, index / 2)
                index /= 2
            }
        }
        
        mutating func pop() -> T? {
            if elements.count < 2 { return nil }
            elements.swapAt(1, elements.count - 1)
            let deletedElement = elements.removeLast()
            diveDown(index: 1)
            return deletedElement
        }
        
        mutating private func diveDown(index: Int) {
            var swapIndex = index
            var isSwap = false
            let leftIndex = index * 2
            let rightIndex = index * 2 + 1

            if leftIndex < elements.endIndex && comparer(elements[leftIndex], elements[swapIndex]) {
                swapIndex = leftIndex
                isSwap = true
            }
            
            if rightIndex < elements.endIndex && comparer(elements[rightIndex], elements[swapIndex]) {
                swapIndex = rightIndex
                isSwap = true
            }

            if isSwap {
                elements.swapAt(swapIndex, index)
                diveDown(index: swapIndex)
            }
        }
    }

    extension Heap {
        init() {
            self.comparer = (<)
        }
    }

    struct Edge : Comparable {
        let v : Int
        let w : Int
        
        static func < (lhs : Edge, rhs : Edge) -> Bool {
            return lhs.w < rhs.w
        }
    }

    let fio = FileIO()
    let v = fio.readInt(), e = fio.readInt()
    let k = fio.readInt()
    var graph = [[(Int, Int)]](repeating: [(Int, Int)](), count: v + 1)
    let INF = Int.max
    var dist = [Int](repeating: INF, count: v + 1)
    for _ in 0 ..< e {
        let u = fio.readInt(), v = fio.readInt(), w = fio.readInt()
        graph[u].append((v, w))
    }

    func dijkstra(at start : Int) {
        dist[start] = 0
        var heapq = Heap<Edge>()
        heapq.insert(Edge(v: start, w: 0))
        while !heapq.isEmpty {
            guard let now = heapq.pop() else { break }
            if dist[now.v] < now.w { continue }
            
            for (v, w) in graph[now.v] {
                let cost = w + now.w
                if cost < dist[v] {
                    dist[v] = cost
                    heapq.insert(Edge(v: v, w: cost))
                }
            }
        }
    }

    dijkstra(at: k)
    for i in 1 ... v {
        print(dist[i] == INF ? "INF" : dist[i])
    }
}
