# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{5,6} )

inherit eutils distutils-r1 systemd user

SRC_URI="https://github.com/kyuupichan/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"
DESCRIPTION="A server for the Electrum wallet"
HOMEPAGE="https://github.com/kyuupichan/electrumx"
LICENSE="MIT"
SLOT="0"
IUSE="doc test"

RDEPEND="dev-python/plyvel[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-1.0[${PYTHON_USEDEP}]
	>=dev-python/pylru-1.0[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

DEPEND="${RDEPEND}"

pkg_setup() {
	enewuser "${PN}" -1 -1 "/var/lib/${PN}"
}

src_prepare() {
	default

	sed -i "s;/usr/local/bin;/usr/bin;" "contrib/systemd/${PN}.service" || die
	sed -i "s;/etc/${PN}.conf;/etc/${PN}/${PN}.conf;" "contrib/systemd/${PN}.service" || die

	printf -- "pytest-expect file v1
(3, 5, 4, 'final', 0)
u'tests/lib/test_util.py::test_LogicalFile': FAIL
u'tests/lib/test_util.py::test_open_fns': FAIL
" > .pytest.expect || die
}

python_test() {
	py.test -v --xfail-file="${S}/.pytest.expect" || \
		die "Tests failed under ${EPYTHON}"
}

src_install() {
	distutils-r1_src_install

	local x
	for x in /var/lib/${PN}; do
		dodir "${x}"
		fperms 700 "${x}"
	done

	systemd_dounit "contrib/systemd/${PN}.service"

	use doc && dodoc -r docs
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} && -d ${ROOT}/var/lib/${PN} ]]; then
		chown 700 "${ROOT}/var/lib/${PN}" || die
	fi
}
