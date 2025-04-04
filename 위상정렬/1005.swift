import Foundation

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

func solution_1005() {
    let fio = FileIO()
    for _ in 0 ..< fio.readInt() {
        let n = fio.readInt(), k = fio.readInt()
        var graph = [[Int]](repeating: [Int](), count: n + 1)
        var dp = [Int](repeating: 0, count: n + 1)
        var indegree = [Int](repeating: 0, count: n + 1)
        var times = [Int](repeating: 0, count: n + 1)
        for i in 1 ... n {
            let time = fio.readInt()
            dp[i] = time
            times[i] = time
        }
        
        for _ in 0 ..< k {
            let x = fio.readInt(), y = fio.readInt()
            graph[x].append(y)
            indegree[y] += 1
        }
        
        let w = fio.readInt()
        
        var index = 0
        var queue = [Int]()
        
        for i in 1 ... n {
            if indegree[i] == 0 { queue.append(i) }
        }
        
        while index < queue.count {
            let curr = queue[index]
            index += 1
            
            for next in graph[curr] {
                dp[next] = max(dp[next], dp[curr] + times[next])
                indegree[next] -= 1
                if indegree[next] == 0 { queue.append(next) }
            }
        }
        
        print(dp[w])
    }
}
