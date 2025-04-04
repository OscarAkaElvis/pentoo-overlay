# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="A modified pycparser to parse 010 templates"
HOMEPAGE="https://github.com/d0c-s4vage/pfp"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="!test? ( test )"

DEPEND="${PYTHON_DEPS}
	!!dev-python/py010parser
	dev-python/six[${PYTHON_USEDEP}]"

RDEPEND="${DEPEND}"

distutils_enable_tests pytest
