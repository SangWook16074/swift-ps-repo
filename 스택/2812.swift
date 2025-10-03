func solution_2812() {
    let nk = readLine()!.split(separator: " ").compactMap { Int(String($0))! }
    let n = nk[0], k = nk[1]
    let nums = readLine()!.compactMap { Int(String($0))! }
    var stk = [Int](), cnt = 0
    for num in nums {
        while let last = stk.last, last < num, cnt < k {
            stk.removeLast()
            cnt += 1
        }
        
        stk.append(num)
    }

    while cnt < k {
        stk.removeLast()
        cnt += 1
    }

    print(stk.map { String($0) }.joined())
}
