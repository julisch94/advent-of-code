package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"regexp"
	"strconv"
	"strings"
)

func compute(expression string) int {
	// fmt.Println()
	// fmt.Println(expression)

	pattern := `(mul)\((\d{1,3}),(\d{1,3})\)`
	re := regexp.MustCompile(pattern)

	matches := re.FindAllStringSubmatch(expression, -1)[0]

	if matches[1] == "mul" {
		one, _ := strconv.Atoi(matches[2])
		two, _ := strconv.Atoi(matches[3])

		return one * two
	}

	return 0
}

func handleLine(line string) int64 {
	// fmt.Println(line)

	pattern := `mul\(\d{1,3},\d{1,3}\)`
	re := regexp.MustCompile(pattern)

	matches := re.FindAllString(line, -1)

	sum := int64(0)
	for _, match := range matches {
		sum += int64(compute(match))
	}

	return sum
}

func main() {
	file, err := os.Open("input2.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	completeText := ""

	for scanner.Scan() {
		line := scanner.Text()

		completeText += line
	}

	donots := strings.Split(completeText, "don't()")

	importantText := donots[0]

	for _, donot := range donots[1:] {
		if strings.Contains(donot, "do()") {
			importantText += strings.Join(strings.Split(donot, "do()")[1:], "")
		}
	}

	sum := handleLine(importantText)
	fmt.Println("sum:", sum)

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}
}
