# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KEYWORDS="~amd64"
DESCRIPTION="An alternative full node bitcoin implementation written in Go (golang)"
HOMEPAGE="https://github.com/btcsuite/btcd"
LICENSE="ISC"
SLOT="0"
IUSE="doc"
EGO_PN="${HOMEPAGE#*//}"
EGIT_COMMIT="2e60448ffcc6bf78332d1fe590260095f554dd78"
SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
EGO_VENDOR=(
	"github.com/btcsuite/btclog 84c8d2346e9fc8c7b947e243b9c24e6df9fd206a"
	"github.com/btcsuite/btcutil 501929d3d046174c3d39f0ea54ece471aa17238c"
	"github.com/btcsuite/go-socks 4720035b7bfd2a9bb130b1c184f8bbe41b6f0d0f"
	"github.com/btcsuite/goleveldb 7834afc9e8cd15233b6c3d97e12674a31ca24602"
	"github.com/btcsuite/snappy-go 0bdef8d067237991ddaa1bb6072a740bc40601ba"
	"github.com/btcsuite/websocket 31079b6807923eb23992c421b114992b95131b55"
	"github.com/btcsuite/winsvc f8fb11f83f7e860e3769a08e6811d1b399a43722"
	"github.com/davecgh/go-spew 346938d642f2ec3594ed81d874461961cd0faa76"
	"github.com/jessevdk/go-flags 1679536dcc895411a9f5848d9a0250be7856448c"
	"github.com/jrick/logrotate a93b200c26cbae3bb09dd0dc2c7c7fe1468a034a"
	"golang.org/x/crypto 122d919ec1efcfb58483215da23f815853e24b81 github.com/golang/crypto"
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
