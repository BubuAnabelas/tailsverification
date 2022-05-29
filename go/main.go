package main

import (
	"crypto/sha256"
	"encoding"
	"encoding/hex"
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

func initSHA256(this js.Value, args []js.Value) interface{} {
	h := sha256.New()
	marshaler, _ := h.(encoding.BinaryMarshaler)
	state, _ := marshaler.MarshalBinary()
	encodedStr := hex.EncodeToString(state)
	return encodedStr
}

func update(this js.Value, args []js.Value) interface{} {
	buf := args[1]
	data := make([]uint8, buf.Get("byteLength").Int())
	js.CopyBytesToGo(data, buf)

	h := sha256.New()
	decodedStr, _ := hex.DecodeString(args[0].String())
	unmarshaler, _ := h.(encoding.BinaryUnmarshaler)
	unmarshaler.UnmarshalBinary(decodedStr)

	h.Write(data)

	marshaler, _ := h.(encoding.BinaryMarshaler)
	state, _ := marshaler.MarshalBinary()
	encodedStr := hex.EncodeToString(state)
	return encodedStr
}

func digest(this js.Value, args []js.Value) interface{} {
	h := sha256.New()
	decodedStr, _ := hex.DecodeString(args[0].String())
	unmarshaler, _ := h.(encoding.BinaryUnmarshaler)
	unmarshaler.UnmarshalBinary(decodedStr)

	sum := h.Sum(nil)
	s := fmt.Sprintf("%x", sum)
	return s
}