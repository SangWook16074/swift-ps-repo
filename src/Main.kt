import java.io.StreamTokenizer
import kotlin.math.min

fun main() = with(StreamTokenizer(System.`in`.bufferedReader())) {
    fun nextInt() : Int { nextToken(); return nval.toInt() }
    val n = nextInt(); val m = nextInt()
    val INF = 100
    val graph = Array(n + 1) { mutableListOf<Int>() }
    val dist = Array(n + 1) { IntArray(n + 1) {INF} }
    repeat(m) {
        val a = nextInt(); val b = nextInt()
        if (!graph[a].contains(b)) {
            graph[a].add(b)
        }
        if (!graph[b].contains(a)) {
            graph[b].add(a)
        }
    }
    repeat(n) {i ->
        dist[i + 1][i + 1] = 0
    }

    for (i in 1 .. n) {
        for (j in graph[i]) {
            dist[i][j] = 1
        }
    }

    for (k in 1 .. n) {
        for (i in 1 .. n) {
            for (j in 1 ..  n) {
                dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j])
            }
        }
    }
    val result = (1 .. n).map { i -> dist[i].reduce { acc, j -> acc + j } }
    val minV = result.min()
    var ans = 0
    for (i in 0 ..< n) {
        if (result[i] == minV) {
            ans = i + 1
            break
        }
    }
    print(ans)
}