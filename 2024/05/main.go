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

func isUpdateAllowed(update string) bool {
	for _, rule := range rules {
		// rules are in the format "\d+|\d+"
		regex := regexp.MustCompile(rule)
		matches := regex.FindAllString(update, -1)

		if len(matches) == 0 {
			// fmt.Println(rule, "does not apply")
			continue
		}
		if len(matches) == 1 {
			// fmt.Println(rule, "does not apply. Only one part present.")
			continue
		}

		// fmt.Println(rule, "applies")

		parts := strings.Split(rule, "|")
		first, second := parts[0], parts[1]

		// fmt.Println(first, "must come before", second)

		firstIndex := strings.Index(update, first)
		secondIndex := strings.Index(update, second)

		// fmt.Println("Found", first, "at", firstIndex)
		// fmt.Println("Found", second, "at", secondIndex)

		if firstIndex > secondIndex {
			fmt.Println("Rule", rule, "violated by", update)
			return false
		}
	}
	return true
}

var rules = []string{}

func main() {
	file, err := os.Open("input1.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		line := scanner.Text()

		if line == "" {
			break
		}
		rules = append(rules, line)
	}

	updates := []string{}
	for scanner.Scan() {
		line := scanner.Text()
		updates = append(updates, line)
	}

	// fmt.Println("Rules:", rules)
	// fmt.Println("Updates:", updates)

	sum := 0
	for _, u := range updates {
		if isUpdateAllowed(u) {
			// fmt.Println(u, "is allowed")

			// we have to find the middle number
			parts := strings.Split(u, ",")
			middle, _ := strconv.Atoi(parts[len(parts)/2])

			sum += middle
		}
	}

	fmt.Println("Sum:", sum)

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}
}