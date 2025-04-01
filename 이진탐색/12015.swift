func solution_12015() {
    var ans = [Int]()
    let n = Int(readLine()!)!
    let arr = readLine()!.split(separator: " ").map { Int(String($0))! }

    func binarySearch(_ num : Int, _ nums : [Int]) -> Int {
        var start = 0, end = nums.count - 1
        while start < end {
            let mid = (start + end) / 2
            if nums[mid] < num {
                start = mid + 1
            } else {
                end = mid
            }
        }
        return end
    }

    for num in arr {
        if ans.isEmpty {
            ans.append(num)
            continue
        }
        
        
        if ans.last! < num {
            ans.append(num)
        } else {
            let index = binarySearch(num, ans)
            ans[index] = num
        }
        
    }
    print(ans.count)
}
