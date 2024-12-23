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

	if getRune(x, y) != "A" {
		return 0
	}

	// M.S
	// .A.
	// M.S
	if getRune(x-1, y-1) == "M" && getRune(x+1, y+1) == "S" && getRune(x-1, y+1) == "M" && getRune(x+1, y-1) == "S" {
		matches++
	}

	// S.M
	// .A.
	// S.M
	if getRune(x-1, y-1) == "S" && getRune(x+1, y+1) == "M" && getRune(x-1, y+1) == "S" && getRune(x+1, y-1) == "M" {
		matches++
	}

	// M.M
	// .A.
	// S.S
	if getRune(x-1, y-1) == "M" && getRune(x+1, y+1) == "S" && getRune(x-1, y+1) == "S" && getRune(x+1, y-1) == "M" {
		matches++
	}

	// S.S
	// .A.
	// M.M
	if getRune(x-1, y-1) == "S" && getRune(x+1, y+1) == "M" && getRune(x-1, y+1) == "M" && getRune(x+1, y-1) == "S" {
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
