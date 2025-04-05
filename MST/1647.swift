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


func solution_1647() {
    typealias Edge = (u: Int, v: Int, w: Int)

    let fio = FileIO()
    let n = fio.readInt(), m = fio.readInt()
    var parent = Array(0 ... n)

    func findParent(_ index : Int) -> Int {
        if parent[index] == index { return index }
        else {
            parent[index] = findParent(parent[index])
            return parent[index]
        }
    }

    func unionParent(_ a : Int, _ b : Int) {
        let num1 = findParent(a)
        let num2 = findParent(b)
        if a < b {
            parent[num2] = num1
        } else {
            parent[num1] = num2
        }
    }

    var graph = [Edge]()
    for _ in 0 ..< m {
        let u = fio.readInt(), v = fio.readInt(), w = fio.readInt()
        let edge = (u: u, v: v, w: w)
        graph.append(edge)
    }
    graph = graph.sorted { $0.w < $1.w }
    var costs = 0
    var maxCost = 0
    for edge in graph {
        let u = edge.u, v = edge.v, w = edge.w
        if findParent(u) != findParent(v) {
            unionParent(u, v)
            costs += w
            maxCost = max(maxCost, w)
        }
    }
    print(costs - maxCost)
}
