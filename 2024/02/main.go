package main

import (
	"bufio"
	"errors"
	"fmt"
	"log"
	"math"
	"os"
	"regexp"
	"strconv"
)

type Direction string

const (
	UP   Direction = "UP"
	DOWN Direction = "DOWN"
)

func matchesConditions(one int, two int, dir Direction) bool {
	if dir == UP && one >= two {
		return false
	}
	if dir == DOWN && one <= two {
		return false
	}
	diff := math.Abs(float64(one - two))
	return diff >= 1 && diff <= 3
}

func matchesAllConditions(levels []int) bool {
	if len(levels) == 0 || len(levels) == 1 {
		return true
	}

	var dir = UP
	if levels[0] > levels[1] {
		dir = DOWN
	} else {
		dir = UP
	}

	allGood := true

	for i := 0; i < len(levels)-1; i++ {
		one := levels[i]
		two := levels[i+1]
		if !matchesConditions(one, two, dir) {
			allGood = false
		}
	}

	if allGood {
		fmt.Println(levels, "Safe without removing any level.")
		return true
	}

	// for every index, remove it from the array and check if it matches all conditions now
	for i := 0; i < len(levels); i++ {
		newArray := make([]int, len(levels)-1)
		copy(newArray[:i], levels[:i])
		copy(newArray[i:], levels[i+1:])

		if matchesAllConditions(newArray) {
			fmt.Printf("%v: Safe by removing the %d. level, %d\n", levels, i, levels[i])
			return true
		}
	}

	return false
}

func isSafe(levels []int) bool {
	fmt.Println("levels:", levels)

	// compare 0 and 1

	// if

	matches := matchesAllConditions(levels)

	return matches
}

func handleLine(line string) bool {
	pattern := `\d+`
	re := regexp.MustCompile(pattern)

	matches := re.FindAllString(line, -1)

	levels := make([]int, len(matches))
	for i, str := range matches {
		num, err := strconv.Atoi(str)
		if err != nil {
			panic(errors.New(fmt.Sprintf("Error converting %s to int: %v\n", str, err)))
		}
		levels[i] = num
	}

	return isSafe(levels)
}

func main() {
	file, err := os.Open("/Users/sjulia3/dev/github/julisch94/advent-of-code/2024/02/input.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	var numOfSafe = 0

	scanner := bufio.NewScanner(file)
	// optionally, resize scanner's capacity for lines over 64K, see next example
	for scanner.Scan() {
		line := scanner.Text()
		safe := handleLine(line)

		if safe {
			numOfSafe++
		}
	}

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}

	fmt.Println("Number of safe lines:", numOfSafe)

}
