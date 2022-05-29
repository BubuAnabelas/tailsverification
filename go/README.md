# WebAssembly and Go

According to the [Go wiki](https://github.com/golang/go/wiki/WebAssembly):
> To execute main.wasm in a browser, we’ll also need a JavaScript support file, and a HTML page to connect everything together.
> Copy the JavaScript support file:
> `$ cp "$(go env GOROOT)/misc/wasm/wasm_exec.js" .`

## To build:

`go build -i -o wasm_js.wasm main.go`

`go build -i -o wasm_2_go_js.wasm 2.go`