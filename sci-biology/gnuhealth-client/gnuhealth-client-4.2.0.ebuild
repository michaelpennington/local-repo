# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_11 )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Gnu Health client"
HOMEPAGE="https://www.gnuhealth.org/index.html"
SRC_URI="https://ftp.gnu.org/gnu/health/${P}.tar.gz"

LICENSE=""

SLOT="0"
KEYWORDS="~amd64"

IUSE="test"

DEPEND="
	dev-python/build[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )
"
RDEPEND="${DEPEND}"
BDEPEND=""

RESTRICT="!test? ( test )"

distutils_enable_tests pytest
