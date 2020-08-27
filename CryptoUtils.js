import { instantiateSha256, instantiateSha256Bytes, binToHex, getEmbeddedSha256Binary } from '@bitauth/libauth'

const CryptoUtils = {
	SHA256: instantiateSha256,
	SHA256WASM: instantiateSha256Bytes,
	WasmSha256: getEmbeddedSha256Binary,
	binToHex
};

export default CryptoUtils