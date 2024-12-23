package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
)

var matrix [][]rune

func hasRune(x, y int) bool {
	if y < 0 || y >= len(matrix) {
		return false
	}

	if x < 0 || x >= len(matrix[y]) {
		return false
	}

	return true
}

func getRune(x, y int) string {
	if !hasRune(x, y) {
		return ""
	}
	return string(matrix[y][x])
}

func searchXmasFromCoordinate(x, y int) int {
	matches := 0

	if getRune(x, y) != "X" {
		return 0
	}

	// upwards
	if getRune(x, y-1) == "M" && getRune(x, y-2) == "A" && getRune(x, y-3) == "S" {
		matches++
	}

	// downwards
	if getRune(x, y+1) == "M" && getRune(x, y+2) == "A" && getRune(x, y+3) == "S" {
		matches++
	}

	// left
	if getRune(x-1, y) == "M" && getRune(x-2, y) == "A" && getRune(x-3, y) == "S" {
		matches++
	}

	// right
	if getRune(x+1, y) == "M" && getRune(x+2, y) == "A" && getRune(x+3, y) == "S" {
		matches++
	}

	// diagonal up left
	if getRune(x-1, y-1) == "M" && getRune(x-2, y-2) == "A" && getRune(x-3, y-3) == "S" {
		matches++
	}

	// diagonal up right
	if getRune(x+1, y-1) == "M" && getRune(x+2, y-2) == "A" && getRune(x+3, y-3) == "S" {
		matches++
	}

	// diagonal down left
	if getRune(x-1, y+1) == "M" && getRune(x-2, y+2) == "A" && getRune(x-3, y+3) == "S" {
		matches++
	}

	// diagonal down right
	if getRune(x+1, y+1) == "M" && getRune(x+2, y+2) == "A" && getRune(x+3, y+3) == "S" {
		matches++
	}

	return matches

}

func main() {
	file, err := os.Open("input1.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		line := scanner.Text()
		row := []rune(line)
		matrix = append(matrix, row)
	}

	// fmt.Println(getRune(0, 0))

	matchesFound := 0
	for col := 0; col < len(matrix[0]); col++ {
		for row := 0; row < len(matrix); row++ {
			// fmt.Println(getRune(col, row))

			matchesFound += searchXmasFromCoordinate(col, row)
		}
	}

	fmt.Println("XMAS found:", matchesFound)

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}
}
