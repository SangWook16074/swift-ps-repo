
func solution_1477() {
    let nml = readLine()!.split(separator: " ").map { Int(String($0))! }
    let n = nml[0], m = nml[1], l = nml[2]
    var arr = [Int]()
    if n > 0 { arr = readLine()!.split(separator: " ").map { Int(String($0))! } }
    arr.append(0)
    arr.append(l)
    arr = arr.sorted { $0 < $1 }
    var start = 1, end = l - 1, ans = 9999
    while start <= end {
        var cnt = 0
        let mid = (start + end) / 2
        for i in 1 ..< arr.count {
            let len = arr[i] - arr[i - 1]
            let tmp = len / mid
            if tmp > 0 {
                if len % mid == 0 { cnt += tmp - 1 }
                else { cnt += tmp }
            }
        }
        
        if cnt > m { start = mid + 1 }
        else {
            end = mid - 1
            ans = min(ans, mid)
        }
        
    }
    print(ans)
}
