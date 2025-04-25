func solution_7453() {
    var a = [Int](), b = [Int](), c = [Int](), d = [Int]()
    let n = Int(readLine()!)!
    let size = n * n - 1
    for _ in 0 ..< n {
        let input = readLine()!.split(separator: " ").map { Int(String($0))! }
        a.append(input[0])
        b.append(input[1])
        c.append(input[2])
        d.append(input[3])
    }

    var x = [Int](), y = [Int]()

    for i in 0 ..< n {
        for j in 0 ..< n {
            x.append(a[i] + b[j])
            y.append(c[i] + d[j])
        }
    }

    x = x.sorted { $0 < $1 }
    y = y.sorted { $0 < $1 }
    var ans = 0
    var start = 0, end = size
    while start <= size && end >= 0 {
        var inc = 0, dec = 0
        if x[start] + y[end] > 0 {
            end -= 1
        } else if x[start] + y[end] < 0 {
            start += 1
        } else {
            let xValue = x[start], yValue = y[end]
            while start <= size && xValue == x[start] {
                start += 1
                inc += 1
            }
            
            while end >= 0 && yValue == y[end] {
                end -= 1
                dec += 1
            }
            
            ans += inc * dec
        }
    }
    print(ans)
}
