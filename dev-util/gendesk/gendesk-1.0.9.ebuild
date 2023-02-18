# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Generate .desktop files"
HOMEPAGE="https://gendesk.roboticoverlords.org/"
SRC_URI="https://github.com/xyproto/${PN}/releases/download/${PV}/${P}.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE="pie"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	ego build -v -mod=vendor -trimpath -buildmode=$(usex pie pie exe) -ldflags="-s -w -extldflags \"$LDFLAGS\""
}

src_install() {
	dobin ${PN}
	gunzip ${PN}.1.gz
	doman ${PN}.1
	insinto "${EROOT}/usr/share/pixmaps"
	doins "${FILESDIR}/default.png"
}
