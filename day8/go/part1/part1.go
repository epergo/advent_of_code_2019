package part1

import (
	"strings"
)

func Verify(input string, width, height int) (result int) {
	pixels := strings.Split(input, "")
	rawLayers := extractLayers(pixels, width, height)
	minZeros := -1
	for _, layer := range rawLayers {
		zeroes := countValuesInLayer(layer, "0")
		if minZeros == -1 || zeroes < minZeros {
			result = countValuesInLayer(layer, "1") * countValuesInLayer(layer, "2")
			minZeros = zeroes
		}
	}
	return
}

// extractLayers returns an array of arrays for each layer in the input
// i.e: (["1", "2", "3", "4"], 1, 2) => [["1", "2"], ["3", "4"]]
func extractLayers(input []string, width, height int) (layers [][]string) {
	batchSize := width * height
	for batchSize <= len(input) {
		// https://github.com/golang/go/wiki/SliceTricks#batching-with-minimal-allocation
		input, layers = input[batchSize:], append(layers, input[0:batchSize:batchSize])
	}
	return
}

// countValuesInLayer receives an array and a value by parameters and count the number of occurrences of said value inside the slice
func countValuesInLayer(layer []string, value string) (result int) {
	for _, p := range layer {
		if p == value {
			result++
		}
	}

	return
}
