fun main() {
    val dp = IntArray(6) {0}
    dp[1] = 1
    dp[2] = 1
    for (i in 3 .. 5) {
        dp[i] = dp[i-1] + dp[i-2]
    }
    print(dp[5])
}