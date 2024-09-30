func solution_6588() -> Void {
    var nums = Array(0 ... 1000000)
    nums[1] = 0
    for i in 0 ... 1000000 {
        if nums[i] != 0 {
            for j in stride(from: i + i, through: 1000000, by: i) {
                nums[j] = 0
            }
        }
    }
    nums[2] = 0
    while true {
        let n = Int(readLine()!)!
        if n != 0 {
            var flag = false
            for i in 3 ..< n {
                if nums[i] != 0 {
                    let j = n - i
                    if nums[j] != 0 {
                        print("\(n) = \(i) + \(j)")
                        flag = true
                        break
                    }
                }
            }
            if !flag { print("\"Goldbach's conjecture is wrong.\"") }
        }
        else { break }
    }
}
