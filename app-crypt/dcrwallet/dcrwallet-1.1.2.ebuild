# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KEYWORDS="~amd64"
DESCRIPTION="A secure Decred wallet daemon written in Go (golang)"
HOMEPAGE="https://github.com/decred/dcrwallet"
LICENSE="ISC"
SLOT="0"
IUSE="doc"
EGO_PN="${HOMEPAGE#*//}"
EGIT_COMMIT="v${PV}"
SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
EGO_VENDOR=(
	"github.com/agl/ed25519 5312a61534124124185d41f09206b9fef1d88403"
	"github.com/boltdb/bolt 2f1ce7a837dcb8da3ec595b1dac9d0632f0f99e8"
	"github.com/btcsuite/btclog 84c8d2346e9fc8c7b947e243b9c24e6df9fd206a"
	"github.com/btcsuite/go-socks 4720035b7bfd2a9bb130b1c184f8bbe41b6f0d0f"
	"github.com/btcsuite/websocket 31079b6807923eb23992c421b114992b95131b55"
	"github.com/davecgh/go-spew 346938d642f2ec3594ed81d874461961cd0faa76"
	"github.com/dchest/blake256 dee3fe6eb0e98dc774a94fc231f85baf7c29d360"
	"github.com/decred/base58 b3520e187fa8ebe65eb74245408cf4b83e6a65d3"
	"github.com/decred/dcrd 008e80bf8668544de4200a08927e95e5926439a0"
	"github.com/golang/protobuf 130e6b02ab059e7b717a096f397c5b60111cae74"
	"github.com/jessevdk/go-flags 96dc06278ce32a0e9d957d590bb987c81ee66407"
	"github.com/jrick/bitset 06eae37cdf93c699c0503c23f998167ce841974c"
	"github.com/jrick/logrotate a93b200c26cbae3bb09dd0dc2c7c7fe1468a034a"
	"github.com/pmezard/go-difflib 792786c7400a136282c1664665ae0a8db921c6c2"
	"github.com/stretchr/testify 69483b4bd14f5845b5a1e55bca19e954e827f1d0"
	"golang.org/x/crypto 847319b7fc94cab682988f93da778204da164588 github.com/golang/crypto"
	"golang.org/x/net 278c6cf336eb9139d63479da09da0cfb40fdc4c8 github.com/golang/net"
	"golang.org/x/sync f52d1811a62927559de87708c8913c1650ce4f26 github.com/golang/sync"
	"golang.org/x/sys 429f518978ab01db8bb6f44b66785088e7fba58b github.com/golang/sys"
	"golang.org/x/text 1cbadb444a806fd9430d14ad08967ed91da4fa0a github.com/golang/text"
	"google.golang.org/genproto 1e559d0a00eef8a9a43151db4665280bd8dd5886 github.com/google/go-genproto"
	"google.golang.org/grpc f92cdcd7dcdc69e81b2d7b338479a19a8723cfa3 github.com/grpc/grpc-go"
)

inherit golang-vcs-snapshot

SRC_URI+=" ${EGO_VENDOR_URI}"

src_compile() {
	GOPATH="${S}" \
		go install -v -work -x ${EGO_BUILD_FLAGS} \
		"${EGO_PN}"/{.,cmd/...} || die
}

src_install() {
	cd "${S}/src/${EGO_PN}" || die
	einstalldocs
	use doc && dodoc -r docs
	cd "${S}"/bin || die
	local x
	for x in *; do
		newbin "${x}" "dcr${x#dcr}"
	done
}
