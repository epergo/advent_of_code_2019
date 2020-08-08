package part2

import (
	"fmt"
	"io/ioutil"
	"testing"
)

func TestVerify(t *testing.T) {
	tt := []struct {
		input  string
		width  int
		height int
		want   string
	}{
		{
			input:  "0222112222120000",
			width:  2,
			height: 2,
			want:   "0110",
		},
		{
			input:  "022211210112",
			width:  3,
			height: 2,
			want:   "010111",
		},
		{
			input:  "01011111",
			width:  2,
			height: 2,
			want:   "0101",
		},
		{
			input:  "22221111",
			width:  2,
			height: 2,
			want:   "1111",
		},
		{
			input:  func() string { b, _ := ioutil.ReadFile("../../input.txt"); return string(b) }(),
			width:  25,
			height: 6,
			want:   "who knows",
		},
	}

	for index, example := range tt {
		t.Run(fmt.Sprint("Example:", index), func(t *testing.T) {
			got := Verify(example.input, example.width, example.height)
			if got != example.want {
				t.Errorf("not equal want: %v got: %v", example.want, got)
			}
		})
	}
}
