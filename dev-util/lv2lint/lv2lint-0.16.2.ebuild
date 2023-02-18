# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="An lv2 linter"
HOMEPAGE="https://open-music-kontrollers.ch/lv2/lv2lint"
SRC_URI="https://git.open-music-kontrollers.ch/lv2/${PN}/snapshot/${P}.tar.xz"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="elf online test X"

DEPEND="
	>=media-libs/lv2-1.18.10
	>=media-libs/lilv-0.24.20-r1
	elf? ( >=virtual/libelf-3 )
	online? ( >=net-misc/curl-7.88.0 )
	X? ( >=x11-libs/libX11-1.8.4 )
	test? ( >=dev-util/reuse-1.1.2 )
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local emesonargs=(
		$(meson_feature elf elf-tests)
		$(meson_feature online online-tests)
		$(meson_feature X x11-tests)
	)
	meson_src_configure
}

src_compile() {
	meson_src_compile
}

src_test() {
	meson_src_test
}

src_install() {
	meson_src_install
}
