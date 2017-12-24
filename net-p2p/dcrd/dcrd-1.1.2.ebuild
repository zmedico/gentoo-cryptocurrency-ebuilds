# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KEYWORDS="~amd64"
DESCRIPTION="Decred daemon in Go (golang)"
HOMEPAGE="https://github.com/decred/dcrd"
LICENSE="ISC"
SLOT="0"
IUSE="doc"
EGO_PN="${HOMEPAGE#*//}"
EGIT_COMMIT="v${PV}"
SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
EGO_VENDOR=(
	"github.com/agl/ed25519 5312a61534124124185d41f09206b9fef1d88403"
	"github.com/btcsuite/btclog 84c8d2346e9fc8c7b947e243b9c24e6df9fd206a"
	"github.com/btcsuite/go-socks 4720035b7bfd2a9bb130b1c184f8bbe41b6f0d0f"
	"github.com/btcsuite/goleveldb 7834afc9e8cd15233b6c3d97e12674a31ca24602"
	"github.com/btcsuite/snappy-go 0bdef8d067237991ddaa1bb6072a740bc40601ba"
	"github.com/btcsuite/websocket 31079b6807923eb23992c421b114992b95131b55"
	"github.com/btcsuite/winsvc f8fb11f83f7e860e3769a08e6811d1b399a43722"
	"github.com/davecgh/go-spew ecdeabc65495df2dec95d7c4a4c3e021903035e5"
	"github.com/dchest/blake256 dee3fe6eb0e98dc774a94fc231f85baf7c29d360"
	"github.com/decred/base58 b3520e187fa8ebe65eb74245408cf4b83e6a65d3"
	"github.com/jessevdk/go-flags 96dc06278ce32a0e9d957d590bb987c81ee66407"
	"github.com/jrick/bitset 06eae37cdf93c699c0503c23f998167ce841974c"
	"github.com/jrick/logrotate a93b200c26cbae3bb09dd0dc2c7c7fe1468a034a"
	"golang.org/x/crypto 9419663f5a44be8b34ca85f08abc5fe1be11f8a3 github.com/golang/crypto"
	"golang.org/x/sys ebfc5b4631820b793c9010c87fd8fef0f39eb082 github.com/golang/sys"
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
