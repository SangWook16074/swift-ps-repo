import java.io.StreamTokenizer
import kotlin.math.min

fun main() = with(StreamTokenizer(System.`in`.bufferedReader())) {
    fun nextInt() : Int { nextToken(); return nval.toInt() }
    val n = nextInt(); val m = nextInt();
    val INF = Long.MAX_VALUE
    val dist = Array(n + 1) { LongArray(n + 1) { INF } }
    repeat(m) {
        val a = nextInt(); val b = nextInt(); val c = nextInt()
        dist[a][b] = min(dist[a][b], c.toLong())
    }

    repeat(n) {i ->
        val idx = i + 1
        dist[idx][idx] = 0
    }

    repeat(n) { k ->
        repeat(n) { i ->
            repeat(n) { j->
                if (dist[i][k] != INF && dist[k][j] != INF && dist[i][k] + dist[k][j] < dist[i][k]) {
                    dist[i][j] = dist[i][k] + dist[k][j]
                }
            }
        }
    }

    for (i in 1 .. n) {
        for (j in 1 .. n) {
            if (dist[i][j] == INF) {
                print("0 ")
            } else {
                print("${dist[i][j]} ")
            }
        }
        println()
    }
}