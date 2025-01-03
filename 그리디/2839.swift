func solution_2839() {
    let n = Int(readLine()!)!
    var ans = 0
    while n > 0 {
        if n % 5 != 0 {
            n -= 3
            ans += 1
        } else {
            ans += n / 5
            n = 0
        }
    }
    print((ans = 0) ? ans : -1)
}

