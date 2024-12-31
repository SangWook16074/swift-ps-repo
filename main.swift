var n = 1000 - Int(readLine()!)!
let money = readLine()!.split(separator: " ").map { Int(String($0))! }.sorted { $0 > $1 }
var ans = 0
// 지폐를 내림차순으로 순회하면서
for m in money {
    // 지폐로 전체 돈을 나눈 몫은 정답에 더하고
    ans += n / m
    // 나머지는 n에 할당해서 다음 연산을 수행
    n %= m
}
print(ans)
