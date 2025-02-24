struct Heap<T : Comparable> {
    private var data : [T] = []
    private let compare : (T, T) -> Bool
    
    init(compare : @escaping (T, T) -> Bool) {
        self.compare = compare
    }
    
    var isEmpty : Bool {
        return data.isEmpty
    }
    
    var count : Int {
        return data.count
    }
    
    mutating func enqueue(_ value : T) {
        data.append(value)
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
            
            if leftChildIndex < count, compare(data[leftChildIndex], data[swapIndex]) {
                swapIndex = leftChildIndex
            }
            
            if rightChildIndex < count, compare(data[rightChildIndex], data[swapIndex]) {
                swapIndex = rightChildIndex
            }
            
            if swapIndex == parentIndex { break }
            data.swapAt(swapIndex, parentIndex)
            parentIndex = swapIndex
        }
    }
}

struct Jam : Comparable {
    let m : Int
    let v : Int
    
    init(_ m : Int, _ v : Int) {
        self.m = m
        self.v = v
    }
    
    static func < (lhs : Jam, rhs : Jam) -> Bool {
        return lhs.v < rhs.v
    }
    
    static func > (lhs : Jam, rhs : Jam) -> Bool {
        return lhs.v > rhs.v
    }
}

extension Heap {
    init() {
        self.compare = (>)
    }
}

func solution_1202() {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let n = input[0], k = input[1]
    let jams : [Jam] = (1 ... n)
        .map { _ in
            let input = readLine()!.split(separator: " ").map { Int(String($0))! }
            let jam = Jam(input[0], input[1])
            return jam
        }
        .sorted { $0.m < $1.m }
    let bags = (1 ... k).map { _ in Int(readLine()!)! }.sorted { $0 < $1 }
    var maxHeap = Heap<Jam>()
    var ans = 0
    var jamIdx = 0
    for bag in bags {
        while jamIdx < jams.count, jams[jamIdx].m <= bag {
            maxHeap.enqueue(jams[jamIdx])
            jamIdx += 1
        }
        guard let jam = maxHeap.dequeue() else { continue }
        ans += jam.v
    }
    print(ans)
}
