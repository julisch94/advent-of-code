package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"regexp"
	"slices"
	"strconv"
	"strings"
	"time"
)

func convertStringToArray(s string) []string {
	parts := strings.Split(s, ",")
	return parts
}

func fulfillRule(rule string, update string) string {
	// rules are in the format "\d+|\d+"
	// regex := regexp.MustCompile(rule)
	// matches := regex.FindAllString(update, -1)

	uA := convertStringToArray(update)

	parts := strings.Split(rule, "|")
	first, second := parts[0], parts[1]

	firstIndex := slices.Index(uA, first)
	secondIndex := slices.Index(uA, second)

	// fmt.Println("Found", first, "at", firstIndex)
	// fmt.Println("Found", second, "at", secondIndex)

	// now move firstIndex to left of secondIndex
	// e.g. ... , first, second, ...

	// insert update[firstIndex] at secondIndex
	newArray := slices.Delete(uA, firstIndex, firstIndex+1)
	newArray = slices.Insert(newArray, secondIndex, first)

	// newArray := append(uA[:secondIndex], uA[firstIndex], uA[secondIndex])
	// newArray = append(newArray, uA[firstIndex+1:]...)

	// fmt.Println("new array length:", len(newArray))

	return strings.Join(newArray, ",")
}

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
			return false
		}
	}
	return true
}

func reorderUpdate(update string) string {
	for _, rule := range rules {
		parts := strings.Split(rule, "|")
		first, second := parts[0], parts[1]

		// fmt.Println(first, "must come before", second)

		firstIndex := strings.Index(update, first)
		secondIndex := strings.Index(update, second)

		if firstIndex == -1 || secondIndex == -1 {
			// this rule does not apply
			continue
		}

		// fmt.Println("Found", first, "at", firstIndex)
		// fmt.Println("Found", second, "at", secondIndex)

		if firstIndex > secondIndex {
			// fmt.Println("Rule", rule, "violated by", update)
			newUpdate := fulfillRule(rule, update)
			// fmt.Println("Update has been changed to", newUpdate)

			if isUpdateAllowed(newUpdate) {
				return newUpdate
			} else {
				return reorderUpdate(newUpdate)
			}
		}
	}
	return update
}

var rules = []string{}

func main() {
	startTime := time.Now()

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
			// parts := strings.Split(u, ",")
			// middle, _ := strconv.Atoi(parts[len(parts)/2])

			// sum += middle
		} else {
			newU := reorderUpdate(u)

			parts := strings.Split(newU, ",")
			middle, _ := strconv.Atoi(parts[len(parts)/2])

			sum += middle
		}
	}

	fmt.Println("Sum:", sum)

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}

	endTime := time.Now()
	fmt.Println("Execution Time:", endTime.Sub(startTime))
}
