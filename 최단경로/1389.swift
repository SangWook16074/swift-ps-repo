import Foundation
func solution_1389() {
    

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

    let fio = FileIO()
    let n = fio.readInt(), m = fio.readInt()
    let INF = 100
    var graph = [[Int]](repeating: [Int](), count: n + 1)
    var dist = [[Int]](repeating: [Int](repeating: INF, count: n + 1), count: n + 1)
    for _ in 0 ..< m {
        let (a, b) = (fio.readInt(), fio.readInt())
        if !graph[a].contains(b) {
            graph[a].append(b)
        }
        
        if !graph[b].contains(a) {
            graph[b].append(a)
        }
    }

    for i in 1 ... n {
        dist[i][i] = 0
    }

    for i in 1 ... n {
        for j in graph[i] {
            dist[i][j] = 1
        }
    }

    for k in 1 ... n {
        for i in 1 ... n {
            for j in 1 ... n {
                dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j])
            }
        }
    }

    var results = (1 ... n).map { dist[$0].reduce(0, +) }
    let minV = results.min()!
    for i in 1 ... n {
        if results[i - 1] == minV {
            print(i)
            break
        }
    }
}
