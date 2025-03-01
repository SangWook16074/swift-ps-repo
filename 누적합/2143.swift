import Foundation
func solution_2143() {
    
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

    let fileIO = FileIO()
    let t = fileIO.readInt(), n = fileIO.readInt()
    let a = (1 ... n).map { _ in fileIO.readInt() }
    let m = fileIO.readInt()
    let b = (1 ... m).map { _ in fileIO.readInt() }

    var aSum = [Int:Int]()
    for i in 0 ..< n {
        var sum = 0
        for j in i ..< n {
            sum += a[j]
            if aSum[sum] == nil {
                aSum[sum] = 1
            } else {
                aSum[sum]! += 1
            }
        }
    }
    var ans = 0
    for i in 0 ..< m {
        var sum = 0
        for j in i ..< m {
            sum += b[j]
            guard let aValue = aSum[t - sum] else {continue}
            ans += aValue
        }
    }
    print(ans)
}
