# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="Hyper: HTTP/2 Client for Python"
HOMEPAGE="https://pypi.python.org/pypi/h2"
SRC_URI="mirror://pypi/$(echo ${PN} | cut -c 1)/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
#	>=dev-python/enum34-1.0.4[${PYTHON_USEDEP}] <dev-python/enum34-2
RDEPEND="${DEPEND}
	virtual/python-enum34[${PYTHON_USEDEP}]
	>=dev-python/hpack-2.2[${PYTHON_USEDEP}] <dev-python/hpack-3
	>=dev-python/hyperframe-3.1[${PYTHON_USEDEP}] <dev-python/hyperframe-5
	!=dev-python/hyperframe-4.0.0[${PYTHON_USEDEP}]
	"
