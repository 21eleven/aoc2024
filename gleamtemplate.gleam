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
  [[0]]
}

fn part1(input: String) -> Int {
  io.debug(input)
  0
}

fn part2(input: String) -> Int {
  0
}

pub fn main() {
  // case simplifile.read("input.txt") {
  case simplifile.read("example.txt") {
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
