import Foundation


func solution_6497() {
    typealias Edge = (x: Int, y : Int, z : Int)

    
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

    while true {
        let m = fio.readInt(), n = fio.readInt()
        if m == 0 && n == 0 { break }
        var parents = Array(0 ... m)
        
        func findParent(_ index : Int) -> Int {
            if parents[index] == index { return index }
            else {
                parents[index] = findParent(parents[index])
                return parents[index]
            }
        }
        
        func unionParent(_ a : Int, _ b : Int) {
            let num1 = findParent(a)
            let num2 = findParent(b)
            if a < b {
                parents[num2] = num1
            } else {
                parents[num1] = num2
            }
        }
        
        var total = 0
        var graph = [Edge]()
        for _ in 0 ..< n {
            let x = fio.readInt(), y = fio.readInt(), z = fio.readInt()
            total += z
            let edge = (x: x, y: y, z: z)
            graph.append(edge)
        }
        
        var ans = 0
        graph = graph.sorted { $0.z < $1.z }
        for edge in graph {
            let x = edge.x, y = edge.y, z = edge.z
            if findParent(x) != findParent(y) {
                unionParent(x, y)
                ans += z
            }
        }
        print(total - ans)
    }

}
