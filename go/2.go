package main

import (
    "hash"
	"crypto/sha256"
	"fmt"
	"syscall/js"
)

func main() {
	done := make(chan struct{}, 0)
	global := js.Global()
	global.Set("initSHA256", js.FuncOf(initSHA256))
	global.Set("update", js.FuncOf(update))
	global.Set("digest", js.FuncOf(digest))

	<-done
}

var h hash.Hash

func initSHA256(this js.Value, args []js.Value) interface{} {
	h = sha256.New()
    return nil
}

func update(this js.Value, args []js.Value) interface{} {
	buf := args[0]
	data := make([]uint8, buf.Get("byteLength").Int())
	js.CopyBytesToGo(data, buf)

	h.Write(data)
    return nil
}

func digest(this js.Value, args []js.Value) interface{} {
	sum := h.Sum(nil)
	s := fmt.Sprintf("%x", sum)
	return s
}