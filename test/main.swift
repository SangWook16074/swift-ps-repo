let input = readLine()!.split(separator: " ").map { Int(String($0))! }
let (n, k) = (input[0], input[1])

var arr = Array(0 ... n)
var cnt = 0
for i in 2 ... n {
    for j in stride(from: i, through: n, by: i) {
        if arr[j] != 0 {
            cnt += 1
            if cnt == k {
                print(arr[j])
            }
            arr[j] = 0
        }
    }
}
