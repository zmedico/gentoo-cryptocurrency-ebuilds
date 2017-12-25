# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KEYWORDS="~amd64"
DESCRIPTION="A secure bitcoin wallet daemon written in Go (golang)"
HOMEPAGE="https://github.com/btcsuite/btcwallet"
LICENSE="ISC"
SLOT="0"
IUSE="doc"
EGO_PN="${HOMEPAGE#*//}"
EGIT_COMMIT="8e723ea45456fc3e6208a399c849aca54a0d959f"
SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
EGO_VENDOR=(
	"github.com/boltdb/bolt 583e8937c61f1af6513608ccc75c97b6abdf4ff9"
	"github.com/btcsuite/btcd 47885ab8702485be6b6f87a03d4f3be0bc5c982c"
	"github.com/btcsuite/btclog 84c8d2346e9fc8c7b947e243b9c24e6df9fd206a"
	"github.com/btcsuite/btcrpcclient c72658166ae09457e6beb14e9112241e352ebd35"
	"github.com/btcsuite/btcutil 5ffa719c3882fd2ec1e8b9f4978066701c31a343"
	"github.com/btcsuite/go-socks 4720035b7bfd2a9bb130b1c184f8bbe41b6f0d0f"
	"github.com/btcsuite/golangcrypto 53f62d9b43e87a6c56975cf862af7edf33a8d0df"
	"github.com/btcsuite/websocket 31079b6807923eb23992c421b114992b95131b55"
	"github.com/golang/protobuf fec3b39b059c0f88fa6b20f5ed012b1aa203a8b4"
	"github.com/jessevdk/go-flags 1679536dcc895411a9f5848d9a0250be7856448c"
	"github.com/jrick/logrotate a93b200c26cbae3bb09dd0dc2c7c7fe1468a034a"
	"golang.org/x/crypto 84f24dfdf3c414ed893ca1b318d0045ef5a1f607 github.com/golang/crypto"
	"golang.org/x/net 8663ed5da4fd087c3cfb99a996e628b72e2f0948 github.com/golang/net"
	"golang.org/x/sys cd2c276457edda6df7fb04895d3fd6a6add42926 github.com/golang/sys"
	"golang.org/x/text 6353ef0f924300eea566d3438817aa4d3374817e github.com/golang/text"
	"google.golang.org/genproto 411e09b969b1170a9f0c467558eb4c4c110d9c77 github.com/google/go-genproto"
	"google.golang.org/grpc b15215fb911b24a5d61d57feec4233d610530464 github.com/grpc/grpc-go"
	"github.com/davecgh/go-spew 346938d642f2ec3594ed81d874461961cd0faa76"
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
		newbin "${x}" "btc${x#btc}"
	done
}
