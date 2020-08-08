package main

import "fmt"

func main() {
	black := '0'
	white := '1'
	image := "001100110011110111000110000010100101000010010100100001010010111001001010010000101111010000111001111010010100101000010100100100110010010100001001010010"

	for index, char := range image {
		switch char {
		case black:
			fmt.Print("\u25A0")
		case white:
			fmt.Print("\u25A2")
		}

		if (index+1)%25 == 0 {
			fmt.Println("")
		}
	}
}
