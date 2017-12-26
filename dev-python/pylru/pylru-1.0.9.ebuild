# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="A least recently used (LRU) cache for Python"
HOMEPAGE="https://pypi.python.org/pypi/${PN}"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""

python_prepare_all() {
	distutils-r1_python_prepare_all
	sed -e 's|for i in range(20):|for i in range(1):|' -i test.py || die
}

python_test() {
	PYTHONPATH="${PWD}:${PYTHONPATH}" "${PYTHON}" test.py || \
		die "Tests failed under ${EPYTHON}"
}
