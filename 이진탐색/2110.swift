func solution_2110() -> Void {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let (n, c) = (input[0], input[1])
    var house = [Int]()
    for _ in 0 ..< n {
        house.append(Int(readLine()!)!)
    }
    house.sort()
    if c == 2 {
        print(house[n - 1] - house[0])
    } else {
        var result = 0
        var (start, end) = (1, house[n - 1] - house[0])
        while start <= end {
            let mid = (start + end) / 2
            var cnt = 1
            var curr = house[0]
            for i in 1 ..< n {
                if house[i] - curr >= mid {
                    curr = house[i]
                    cnt += 1
                }
            }
            
            if cnt < c {
                end = mid - 1
            } else {
                result = mid
                start = mid + 1
            }
        }
        print(result)
    }
}
