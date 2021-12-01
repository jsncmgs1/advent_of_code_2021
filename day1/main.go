package main

import "fmt"

func main() {
	fmt.Println(SonarSweep(input, 0, 0))
}

func SonarSweep(input []int, priorSum int, increased int) int {
	if len(input) < 3 {
		return increased
	}

	currentSum := input[0] + input[1] + input[2]

	if currentSum > priorSum && priorSum != 0 {
		increased++
	}

	return SonarSweep(input[1:], currentSum, increased)
}
