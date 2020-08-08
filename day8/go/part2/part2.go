package part2

import (
	"strings"
)

func Verify(input string, width, height int) string {
	pixels := strings.Split(input, "")
	batchSize := width * height
	resultBuilder := strings.Builder{}

	layers := extractLayers(pixels, batchSize)

	for i := 0; i < batchSize; i++ {
		for _, layer := range layers {
			value := layer[i]
			if value != "2" {
				resultBuilder.WriteString(value)
				break
			}
		}
	}

	return resultBuilder.String()
}

// extractLayers returns an array of arrays for each layer in the input
// i.e: (["1", "2", "3", "4"], 2) => [["1", "2"], ["3", "4"]]
func extractLayers(input []string, batchSize int) (layers [][]string) {
	for batchSize <= len(input) {
		// https://github.com/golang/go/wiki/SliceTricks#batching-with-minimal-allocation
		input, layers = input[batchSize:], append(layers, input[0:batchSize:batchSize])
	}
	return
}
