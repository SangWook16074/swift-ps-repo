func solution_2696() {
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
        
        var first : T {
            return data.first!
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
    var result = [String]()
    for _ in 0 ..< Int(readLine()!)! {
        var minHeap = Heap<Int>(compare: <)
        var maxHeap = Heap<Int>(compare: >)
        let m = Int(readLine()!)!
        var arr = [Int]()
        while arr.count < m {
            let input = readLine()!.split(separator: " ").map { Int(String($0))! }
            arr += input
        }
        var cnt = 0
        var ans = [[Int]]()
        var tmp = [Int]()
        for i in 1 ... m {
            if minHeap.count == maxHeap.count {
                maxHeap.enqueue(arr[i - 1])
            } else {
                minHeap.enqueue(arr[i - 1])
            }
            
            if !minHeap.isEmpty && maxHeap.first > minHeap.first {
                let maxValue = maxHeap.dequeue()!, minValue = minHeap.dequeue()!
                minHeap.enqueue(maxValue)
                maxHeap.enqueue(minValue)
            }
            
            
            if i % 2 == 1 {
                cnt += 1
                tmp.append(maxHeap.first)
                if tmp.count == 10 {
                    ans.append(tmp)
                    tmp = []
                }
            }
            
        }
        
        if !tmp.isEmpty { ans.append(tmp) }
        result.append("\(cnt)")
        ans.forEach { result.append("\($0.map { String($0) }.joined(separator: " "))") }
    }
    print(result.joined(separator: "\n"))

}
