func solution_14003() {
    let n = Int(readLine()!)!
    var arr = readLine()!.split(separator: " ").map { Int(String($0))! }
    arr.insert(0, at: 0)
    let INF = 1_000_000_001
    var result = [Int](repeating: INF, count: n + 1)
    var indexes = [Int]()
    result[1] = arr[1]

    func binarySearch(_ num : Int) {
        var start = 1, end = result.count - 1
        while start <= end {
            let mid = (start + end) / 2
            if result[mid] < num {
                start = mid + 1
            } else {
                end = mid - 1
            }
        }
        result[start] = num
        indexes.append(start)
    }

    for i in 1 ... n {
        binarySearch(arr[i])
    }

    var count = 0
    for i in 1 ... n {
        if result[i] != INF {
            count += 1
        } else {
            break
        }
    }

    print(count)
    var ans = [Int]()
    for i in (0 ..< indexes.count).reversed() {
        if indexes[i] == count {
            count -= 1
            ans.append(arr[i + 1])
        }
    }
    print(ans.map { String($0) }.reversed().joined(separator: " "))
}
