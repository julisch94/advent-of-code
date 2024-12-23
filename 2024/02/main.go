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

func isArraySafeStrict(levels []int) bool {
	direction := UP
	if levels[0] > levels[1] {
		direction = DOWN
	}

	for i := 0; i < len(levels)-1; i++ {
		one := levels[i]
		two := levels[i+1]

		if !matchesConditions(one, two, direction) {
			return false
		}
	}
	return true
}

func isSafeRecursive(levels []int, changesLeft int) bool {
	if isArraySafeStrict(levels) {
		fmt.Println(levels, "Safe without removing any level.")
		return true
	}

	if changesLeft == 0 {
		fmt.Println(levels, "Unsafe regardless of which level is removed.")
		return false
	}

	// try deleting each element and see if any of the resulting arrays are safe
	for i := 0; i < len(levels); i++ {
		newLevels := make([]int, len(levels)-1)
		copy(newLevels[:i], levels[:i])
		copy(newLevels[i:], levels[i+1:])
		if isSafeRecursive(newLevels, changesLeft-1) {
			fmt.Println(levels, "Safe after removing level", levels[i])
			return true
		}
	}

	return false
}

func isSafe(levels []int) bool {
	return isSafeRecursive(levels, 1)
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
	file, err := os.Open("input2.txt")
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
