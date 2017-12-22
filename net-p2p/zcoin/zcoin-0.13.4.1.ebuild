# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit autotools

DESCRIPTION="The Zerocoin Cryptocurrency"
HOMEPAGE="https://zcoin.io/ https://github.com/zcoinofficial/zcoin/"
SRC_URI="https://github.com/zcoinofficial/zcoin/archive/v${PV}.tar.gz -> ${P}.tar.gz"


LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_prepare() {
	eautoreconf
	default
}

src_install() {
	default
	rm -r \
		"${ED}"usr/$(get_libdir)/libbitcoinconsensus* \
		"${ED}"usr/$(get_libdir)/pkgconfig/libbitcoinconsensus.pc \
		"${ED}"usr/include/bitcoinconsensus.h || die
	find "${ED}" -type d -empty -delete || die
}
