# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KEYWORDS="~amd64"
DESCRIPTION="On-chain atomic swaps for Decred and other cryptocurrencies like Bitcoin"
HOMEPAGE="https://github.com/decred/atomicswap"
LICENSE="ISC"
SLOT="0"
IUSE=""
EGO_PN="${HOMEPAGE#*//}"
EGIT_COMMIT="499950c41c824c22e638c2d9217b81a3d8ce8762"
EGO_VENDOR=(
	"github.com/agl/ed25519 5312a61534124124185d41f09206b9fef1d88403"
	"github.com/btcsuite/btcd 4803a8291c92a1d2d41041b942a9a9e37deab065"
	"github.com/btcsuite/btclog 84c8d2346e9fc8c7b947e243b9c24e6df9fd206a"
	"github.com/btcsuite/btcutil 501929d3d046174c3d39f0ea54ece471aa17238c"
	"github.com/btcsuite/btcwallet 8e723ea45456fc3e6208a399c849aca54a0d959f"
	"github.com/btcsuite/go-socks 4720035b7bfd2a9bb130b1c184f8bbe41b6f0d0f"
	"github.com/btcsuite/golangcrypto 53f62d9b43e87a6c56975cf862af7edf33a8d0df"
	"github.com/btcsuite/websocket 31079b6807923eb23992c421b114992b95131b55"
	"github.com/dchest/blake256 dee3fe6eb0e98dc774a94fc231f85baf7c29d360"
	"github.com/decred/base58 b3520e187fa8ebe65eb74245408cf4b83e6a65d3"
	"github.com/decred/dcrd d27429061b49d400d06505911a1379b8a8246671"
	"github.com/decred/dcrwallet 2df4002bce8c540907c9a3e2980fc3e5deeba8f6"
	"github.com/golang/protobuf ae59567b9aab61b50b2590679a62c3c044030b61"
	"github.com/ltcsuite/ltcd 73924b0a232dfbdc943daf7370e5f46bcf5904a6"
	"github.com/ltcsuite/ltcutil 8e0fd08dd902ef58f5177e041916dd795075871d"
	"github.com/ltcsuite/ltcwallet d2214fcebbf4ae65a0b5a06f9a3cfee02794c565"
	"github.com/particl/partsuite_partd 19ee3c9d208d87a11cad892163b54106af847921"
	"github.com/particl/partsuite_partutil 117d65fa91c030e875ea5698d99b66258c5684d4"
	"github.com/particl/partsuite_partwallet 970e161f293ff12ebbadae51db1f9d47f7414967"
	"github.com/vertcoin/vtcd 15387ac36fe71840d251e71f4c81110c793e3b9e"
	"github.com/vertcoin/vtcutil 264de6df16ae9bcc556487a3ecd06a132224e6ba"
	"github.com/vertcoin/vtcwallet b52e3e2c5f5292992b702d991d0b187223873353"
	"golang.org/x/crypto 7d9177d70076375b9a59c8fde23d52d9c4a7ecd5 github.com/golang/crypto"
	"golang.org/x/net 8351a756f30f1297fe94bbf4b767ec589c6ea6d0 github.com/golang/net"
	"golang.org/x/sys b6e1ae21643682ce023deb8d152024597b0e9bb4 github.com/golang/sys"
	"golang.org/x/text 1cbadb444a806fd9430d14ad08967ed91da4fa0a github.com/golang/text"
	"google.golang.org/genproto 1e559d0a00eef8a9a43151db4665280bd8dd5886 github.com/google/go-genproto"
	"google.golang.org/grpc f92cdcd7dcdc69e81b2d7b338479a19a8723cfa3 github.com/grpc/grpc-go"
)
inherit golang-vcs-snapshot

SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

src_compile() {
	GOPATH="${S}" \
		go install -v -work -x ${EGO_BUILD_FLAGS} \
		"${EGO_PN}"/cmd/... || die
}

src_install() {
	dodoc "${S}/src/${EGO_PN}"/{README.md,workflow.svg}
	dobin "${S}"/bin/*
}
