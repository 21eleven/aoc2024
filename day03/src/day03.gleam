import gleam/bool
import gleam/int
import gleam/io
import gleam/list
import gleam/option
import gleam/regex
import gleam/result
import gleam/string
import simplifile

fn is_true(b: Bool) {
  b
}

fn multiply(a: Int, b: Int) -> Int {
  a * b
}

fn parse(input: String) -> List(List(Int)) {
  input
  |> string.trim()
  |> string.split("\n")
  [[0]]
}

fn part1(input: String) -> Int {
  io.debug(input)
  let assert Ok(re) = regex.from_string("mul\\((\\d{1,3}),(\\d{1,3})\\)")
  io.debug(re)
  let mat = regex.scan(re, input)
  io.debug(mat)
  let out =
    mat
    |> list.map(fn(match) {
      let groups = match.submatches
      groups
      |> list.map(fn(opt) {
        let assert option.Some(n) = opt
        let assert Ok(x) = int.parse(n)
        x
      })
      |> list.fold(1, int.multiply)
    })
    |> list.fold(0, int.add)
  io.debug(out)
  out
}

fn part2(input: String) -> Int {
  let input =
    string.concat([
      "do()",
      input
        |> string.trim(),
      "don't()",
    ])
  let assert Ok(re) = regex.from_string("do\\(\\)(.*?)don't\\(\\)")
  // (?:do\(\))(?!.*do\(\))(.*?)(?=dont\(\))
  io.debug(input)
  io.debug(re)
  let mat = regex.scan(re, input)
  io.debug(mat)
  let out =
    mat
    |> list.map(fn(match) {
      let groups = match.submatches
      io.debug(list.length(groups))
      let assert Ok(str) =
        groups
        |> list.map(fn(opt) {
          let assert option.Some(str) = opt
          let assert Ok(last) =
            str
            |> string.split("don't()")
            |> list.last()
          // last
          str
        })
        |> list.last()
      str
    })
    |> list.map(part1)
    |> list.fold(0, int.add)
  io.debug(out)
  out
}
fn part3(input: String) -> Int {
  let input =
    string.concat([
      "do()",
      input
        |> string.trim(),
      "don't()",
    ])
  // let assert Ok(re) = regex.from_string("do\\(\\)(.*?)don't\\(\\)")
  let assert Ok(re) = regex.from_string("don't\\(\\)(.*?)do\\(\\)")
  // (?:do\(\))(?!.*do\(\))(.*?)(?=dont\(\))
  io.debug(input)
  io.debug(re)
  let mat = regex.scan(re, input)
  io.debug(mat)
  let out =
    mat
    |> list.map(fn(match) {
      let groups = match.submatches
      io.debug(list.length(groups))
      let assert Ok(str) =
        groups
        |> list.map(fn(opt) {
          let assert option.Some(str) = opt
          let assert Ok(last) =
            str
            |> string.split("don't()")
            |> list.last()
          // last
          str
        })
        |> list.last()
      str
    })
    |> list.map(part1)
    |> list.fold(0, int.add)
  io.debug(out)
  out
}

pub fn main() {
  case simplifile.read("input.txt") {
  // case simplifile.read("example.txt") {
  // case simplifile.read("example2.txt") {
    Ok(str) -> {
      // io.debug(str)
      // io.debug(part1(str))
      io.debug(part2(str))
      // io.debug(part1(str)-part3(str))
      0
    }
    _ -> {
      io.println("could not open file")
      1
    }
  }
}
