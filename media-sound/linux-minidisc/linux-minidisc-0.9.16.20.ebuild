# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Free software for accessing MiniDisc devices (thp fork)"
HOMEPAGE="https://github.com/thp/linux-minidisc"
SRC_URI="https://github.com/thp/${PN}/archive/refs/tags/${PV}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

IUSE="gui"

DEPEND=">=dev-libs/libusb-1.0.0
	>=dev-libs/libgcrypt-1.0.0
	>=dev-libs/glib-2.0
	>=media-libs/taglib-1.0.0
	gui? ( >=dev-qt/qtcore-5.0.0 )"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local emesonargs=(
		$(meson_use gui with_gui)
	)
	meson_src_configure
}
