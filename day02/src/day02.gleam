import gleam/bool
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import simplifile

fn is_true(b: Bool) {
  b
}

fn parse(input: String) -> List(List(Int)) {
  input
  |> string.trim()
  |> string.split("\n")
  |> list.filter(fn(str) { "" != str })
  |> list.map(fn(ln: String) {
    ln
    |> string.split(" ")
    // |> list.map(fn(n: String) {n |> Int.}
    |> list.try_map(int.parse)
  })
  |> list.map(fn(l) {
    l
    |> result.unwrap([])
  })
}

fn part1(input: String) -> Int {
  let x =
    input
    |> parse
    |> list.map(is_safe)
  // io.debug(x)
  x
  |> list.filter(is_true)
  |> list.length()
  // 0
}

fn is_safe(lvl: List(Int)) -> Bool {
  let out: List(Int) =
    lvl
    |> list.window_by_2
    |> list.map(fn(pair) {
      let #(a, b) = pair
      a - b
    })
  let directed =
    bool.or(
      out
        |> list.all(fn(x) { x > 0 }),
      out
        |> list.all(fn(x) { x < 0 }),
    )
  let diffs =
    out
    |> list.map(int.absolute_value)
  let right_size =
    bool.and(
      diffs
        |> list.all(fn(x) { x > 0 }),
      diffs
        |> list.all(fn(x) { x < 4 }),
    )
  // io.debug(directed)
  // io.debug(diffs)
  bool.and(directed, right_size)
}

fn part2(input: String) -> Int {
  let lines =
    input
    |> parse
    |> list.map(is_safe_2)
  // io.debug(x)
  lines
  |> list.filter(is_true)
  |> list.length()
}

fn is_safe_2(ln: List(Int)) -> Bool {
  bool.or(
    ln
      |> is_safe_w_dropped,
    ln
      |> is_safe,
  )
}

fn is_safe_w_dropped(ln: List(Int)) -> Bool {
  let len = list.length(ln)
  let repeated =
    ln
    |> list.index_map(fn(x, i) { #(i, x) })
    |> list.repeat(len)
  let out =
    repeated
    |> list.zip(list.range(0, len+1))
    // |> list.map(fn(ls: List(#(Int, Int)), drop_idx: Int) {
    |> list.map(fn(z) {
      let #(ls, drop_idx) = z
      let x = ls
      |> list.filter(fn(x) {
        let #(idx, _val) = x
        idx != drop_idx
      })
      |> list.map(fn(x) {
        let #(_idx, val) = x
        val
      })
    })
    |> list.map(is_safe)
    |> list.any(is_true)
  out
}

pub fn main() {
  io.println("Hello from day02!")
  case simplifile.read("input.txt") {
  // case simplifile.read("example.txt") {
    Ok(str) -> {
      // io.debug(str)
      io.debug(part1(str))
      io.debug(part2(str))
      0
    }
    _ -> {
      io.println("could not open file")
      1
    }
  }
}
