import Foundation

let nk = readLine()!.split(separator: " ").compactMap { Int(String($0)) }
let n = nk[0], k = nk[1]
var dp = [Int](repeating: 10001, count: 10001)
dp[0] = 0
let coins = (0 ..< n).compactMap { _ in Int(readLine()!) }
for coin in coins {
    guard coin <= k else { continue }
    for i in coin ... k {
        dp[i] = min(dp[i], dp[i - coin] + 1)
    }
}
if dp[k] == 10001 { print(-1) }
else { print(dp[k]) }
