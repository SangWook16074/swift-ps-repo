import Foundation
func solution_19951() -> Void {
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
    let (n, m) = (fio.readInt(), fio.readInt())
    var arr = [Int]()
    for _ in 0 ..< n {
        arr.append(fio.readInt())
    }
    var command = Array(repeating: 0, count: n)
    var pSum = Array(repeating: 0, count: n + 1)
    for _ in 0 ..< m {
        let (a, b, k) = (fio.readInt(), fio.readInt(), fio.readInt())
        command[a - 1] += k
        if b >= n { continue }
        command[b] -= k
    }
    var ans = ""
    for i in 1 ... n {
        pSum[i] = pSum[i - 1] + command[i - 1]
        arr[i - 1] += pSum[i]
        ans += "\(arr[i - 1]) "
    }
    print(ans)
}
