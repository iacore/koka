extern xxh32( data : vector<int>, seed : int32 ) : int32
  c "kk_xxh32"

struct set<v>
  bins: vector<list<v>>

fun length( self : set<a> ) : int
  self.bins.length

fun add<v>(^self: local-var<h, set<v>>, x: v)
  self.length

fun set<v>(initial: list<v>) : set<v>
  var ret := Set([].vector)
  initial.foreach fn(x)
    ret.add(x)
  ret

fun main()
  val a = [1, 2].vector
  val b = a.xxh32(0.int32)
  println(b.int)
