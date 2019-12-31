package part1

import (
	"io/ioutil"
	"testing"
)

func TestVerify(t *testing.T) {
	t.Run("example 1", func(t *testing.T) {
		got := Verify("123456789012", 3, 2)
		want := 1
		if got != want {
			t.Errorf("not equal want: %d got: %d", want, got)
		}
	})

	t.Run("example 2", func(t *testing.T) {
		b, _ := ioutil.ReadFile("../input.txt")
		got := Verify(string(b), 25, 6)
		want := 1806
		if got != want {
			t.Errorf("not equal want: %d got: %d", want, got)
		}
	})
}
