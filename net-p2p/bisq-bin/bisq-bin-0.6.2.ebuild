# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils xdg-utils

MY_PN=Bisq
DESCRIPTION="The decentralized bitcoin exchange"
HOMEPAGE="https://bisq.network/ https://github.com/bisq-network/exchange/"
SRC_URI="https://github.com/bisq-network/exchange/releases/download/v0.6.2/Bisq-64bit-${PV}.deb"

LICENSE="AGPL-3+"
SLOT="0"
KEYWORDS="~amd64"
RDEPEND="x11-misc/xdg-utils"
DEPEND="${RDEPEND}"
S=${WORKDIR}
QA_PREBUILT="opt/Bisq/Bisq opt/Bisq/libpackager.so opt/Bisq/runtime/*"

src_unpack() {
	default
	tar -xf ./data.tar.xz || die
}

src_install() {
	doicon ./opt/Bisq/Bisq.png
	domenu ./opt/Bisq/Bisq.desktop
	mv opt "${ED}" || die
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
