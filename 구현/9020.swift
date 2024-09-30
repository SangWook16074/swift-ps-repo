func solution_9020() -> Void {
    var nums = Array(0 ... 10000)
    nums[1] = 0
    for i in 2 ... 10000 {
        if nums[i] != 0 {
            for j in stride(from: i + i, through: 10000, by: i) {
                nums[j] = 0
            }
        }
    }
    let t = Int(readLine()!)!
    for _ in 0 ..< t {
        let n = Int(readLine()!)!
        var dis = n
        var result = (0, 0)
        for i in 0 ..< n {
            if nums[i] != 0 {
                let j = n - nums[i]
                if nums[j] != 0 {
                    if dis > abs(nums[i] - nums[j]) {
                        dis = abs(nums[i] - nums[j])
                        result = (nums[i], nums[j])
                    }
                }
            }
        }
        print(result.0, result.1)
    }
}
