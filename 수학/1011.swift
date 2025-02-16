import Foundation
func solution_1011() {
    for _ in 0 ..< Int(readLine()!)! {
        let input = readLine()!.split(separator: " ").map { Int(String($0))! }
        let x = input[0], y = input[1]
        let dist = y - x
        let root = Int(sqrt(Double(dist)))
        var ans = dist <= root * root ? root * 2 - 1 : root * 2
        let mid = Int(((root * root) + (root + 1) * (root + 1)) / 2)
        if dist > mid { ans += 1 }
        print(ans)
    }
}
