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


func solution_10942() {
    let fio = FileIO()
    let n = fio.readInt()
    let arr = (0 ..< n).map { _ in fio.readInt() }
    var dp = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: n + 1)
    let m = fio.readInt()

    for i in 0 ..< n {
        dp[i][i] = 1
    }

    for i in 0 ..< n - 1 {
        if arr[i] == arr[i + 1] {
            dp[i][i + 1] = 1
        }
    }

    for i in (0 ..< n - 2).reversed() {
        for j in (i + 2 ..< n).reversed() {
            let index = j
            
            if arr[i] == arr[index] && dp[i + 1][index - 1] == 1 {
                dp[i][index] = 1
            }
        }
    }

    var ans = [String]()
    for _ in 0 ..< m {
        let s = fio.readInt(), e = fio.readInt()
        ans.append("\(dp[s - 1][e - 1])")
    }
    print(ans.joined(separator: "\n"))
}
