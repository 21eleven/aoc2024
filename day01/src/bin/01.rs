use std::collections::HashMap;

advent_of_code::solution!(1);

fn parse(input: &str) -> (Vec<i32>, Vec<i32>) {
    let mut v1 = vec![];
    let mut v2 = vec![];
    for ln in input.lines() {
        let (a, b) = ln.split_once("   ").unwrap();
        v1.push(a.parse::<i32>().unwrap());
        v2.push(b.parse::<i32>().unwrap());
    }
    (v1, v2)
}

pub fn part_one(input: &str) -> Option<i32> {
    let (mut v1, mut v2) = parse(input);
    v1.sort();
    v2.sort();
    Some(
        v1.iter()
            .zip(v2.iter())
            .map(|(a, b)| (a - b).abs())
            .sum::<i32>(),
    )
}

pub fn part_two(input: &str) -> Option<i32> {
    let (v1, v2) = parse(input);
    let mut count = HashMap::new();
    for n in v1 {
        *count.entry(n).or_insert(0) += 1;
    }
    let mut out = 0;
    for n in v2 {
        out += n * count.get(&n).unwrap_or(&0)
    }
    Some(out)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part_one() {
        let result = part_one(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, Some(11));
    }

    #[test]
    fn test_part_two() {
        let result = part_two(&advent_of_code::template::read_file("examples", DAY));
        assert_eq!(result, Some(31));
    }
}
