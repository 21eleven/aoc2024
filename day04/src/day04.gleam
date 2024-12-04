import gleam/bool
import gleam/int
import gleam/io
import gleam/list
import gleam/option
import gleam/pair
import gleam/result
import gleam/string
import simplifile

fn is_true(b: Bool) {
  b
}

fn parse(input: String) -> List(String) {
  input
  |> string.trim()
  |> string.split("\n")
}

fn part1(input: String) -> Int {
  let input = parse(input)
  io.debug(input)
  let lr_padded =
    list.map(input, fn(ls) { string.concat(["....", ls, "...."]) })
  let assert Ok(x_len) =
    lr_padded
    |> list.first()
    |> result.map(string.length)
  io.debug(lr_padded)
  let buffer = string.concat(list.repeat(".", x_len))
  let grid =
    list.concat([list.repeat(buffer, 4), lr_padded, list.repeat(buffer, 4)])
  grid
  |> list.map(fn(x) {
    io.debug(x)
    x
  })
  let grid = list.map(grid, string.to_graphemes)
  let y_len = list.length(grid)
  io.debug(char_at(grid, 4, 10))
  let out =
    grid
    |> list.fold([], fn(output, row) {
      let y = list.length(output)
      // io.debug(row)
      let new_row =
        list.fold(row, [], fn(state, char) {
          let x = list.length(state)
          let xmasi = case char {
            "X" -> {
              let neibs = char_vecs(grid, y, x)
              io.debug(neibs)
              neibs
              |> list.filter(fn(maybe_xmas) {
                maybe_xmas == ["X", "M", "A", "S"]
              })
              |> list.length()
            }
            _ -> 0
          }
          list.flatten([state, [xmasi]])
        })
      list.append(output, [new_row])
    })
  out
  |> list.map(fn(x) {
    io.debug(x)
    x
  })
  let count =
    out
    |> list.map(fn(row) {
      row
      |> list.fold(0, int.add)
    })
    |> list.fold(0, int.add)
  // io.debug(out)

  count
}

fn char_vecs(grid: List(List(String)), y: Int, x: Int) -> List(List(String)) {
  let up = #(1, 0)
  let rup = #(1, 1)
  let r = #(0, 1)
  let rdn = #(-1, 1)
  let dn = #(-1, 0)
  let ldn = #(-1, -1)
  let l = #(0, -1)
  let lup = #(1, -1)
  let dirs =
    [up, rup, r, rdn, dn, ldn, l, lup]
    |> list.map(fn(d) { list.repeat(d, 3) })
  dirs
  |> list.map(fn(vec) {
    let chars =
      list.scan(vec, #(y, x), fn(pt, dir) {
        let #(y, x) = pt
        let #(dy, dx) = dir
        #(y + dy, x + dx)
      })
      |> list.map(fn(pt) {
        let #(y, x) = pt
        char_at(grid, y, x)
      })
      |> list.prepend("X")
  })
  // [["s"]]
}

fn char_at(grid: List(List(String)), y: Int, x: Int) -> String {
  let assert Ok(row) =
    list.split(grid, y)
    |> pair.second()
    |> list.first()
  let assert Ok(char) =
    list.split(row, x)
    |> pair.second()
    |> list.first()
  char
}

fn part2(input: String) -> Int {
  let input = parse(input)
  io.debug(input)
  let lr_padded =
    list.map(input, fn(ls) { string.concat(["....", ls, "...."]) })
  let assert Ok(x_len) =
    lr_padded
    |> list.first()
    |> result.map(string.length)
  io.debug(lr_padded)
  let buffer = string.concat(list.repeat(".", x_len))
  let grid =
    list.concat([list.repeat(buffer, 4), lr_padded, list.repeat(buffer, 4)])
  grid
  |> list.map(fn(x) {
    io.debug(x)
    x
  })
  let grid = list.map(grid, string.to_graphemes)
  let y_len = list.length(grid)
  io.debug(char_at(grid, 4, 10))
  let out =
    grid
    |> list.fold([], fn(output, row) {
      let y = list.length(output)
      // io.debug(row)
      let new_row =
        list.fold(row, [], fn(state, char) {
          let x = list.length(state)
          let xmasi = case char {
            "A" -> {
                let topdown = [char_at(grid, y + 1, x - 1), char_at(grid, y - 1, x + 1)]
                let bottomup = [char_at(grid, y - 1, x - 1), char_at(grid, y + 1, x + 1)]
                io.debug(#(y,x, topdown, bottomup))
              case
                bool.and(
                  {
                    topdown
                    |> list.sort(string.compare)
                  }
                    == ["M", "S"],
                  {
                    bottomup
                    |> list.sort(string.compare)
                  }
                    == ["M", "S"],
                )
              {
                True -> 1
                False -> 0
              }
            }
            _ -> 0
          }
          list.flatten([state, [xmasi]])
        })
      list.append(output, [new_row])
    })
  out
  |> list.map(fn(x) {
    io.debug(x)
    x
  })
  let count =
    out
    |> list.map(fn(row) {
      row
      |> list.fold(0, int.add)
    })
    |> list.fold(0, int.add)
  // io.debug(out)

  count
}

pub fn main() {
  // case simplifile.read("input.txt") {
    // case simplifile.read("example.txt") {
    case simplifile.read("example2.txt") {
    Ok(str) -> {
      // io.debug(str)
      // io.debug(part1(str))
      io.debug(part2(str))
      0
    }
    _ -> {
      io.println("could not open file")
      1
    }
  }
}
