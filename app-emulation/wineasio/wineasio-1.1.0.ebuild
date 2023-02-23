# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="ASIO driver for WINE"
HOMEPAGE="https://sourceforge.net/projects/wineasio"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/v${PV}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"
LICENSE="GPL-2"
IUSE=""
SLOT="0"

DEPEND="media-libs/asio-sdk
	virtual/wine"
RDEPEND="virtual/jack"

PATCHES="${FILESDIR}/patch_make.patch"

#S="${WORKDIR}/${P}"

pkg_setup() {
	export WINETARGET=`eselect --brief --colour=no wine show | awk '{$1=$1;print}'`
	[[ $WINETARGET == "(unset)" ]] && die "please set wine version (eselect wine)"
}

src_prepare() {
	cp /opt/asiosdk2.3.3/common/asio.h .
	default
}

src_compile() {
	emake 64 || die
	emake 32 || die
}

src_install() {
	exeinto /usr/$(get_libdir)/${WINETARGET}/wine/x86_64-unix
	doexe "build64/${PN}.dll.so"
	exeinto /usr/$(get_libdir)/${WINETARGET}/wine/i386-unix
	doexe "build32/${PN}.dll.so"
	exeinto /usr/$(get_libdir)/${WINETARGET}/wine/x86_64-windows
	doexe "build64/${PN}.dll"
	exeinto /usr/$(get_libdir)/${WINETARGET}/wine/i386-windows
	doexe "build32/${PN}.dll"
}

pkg_postinst() {
	echo
	elog "Finally the dll must be registered in the wineprefix."
	elog "For both 32 and 64 bit wine do:"
	elog "# regsvr32 wineasio.dll"
	elog
	elog "On a 64 bit system with wine supporting both 32 and 64 applications, regsrv32"
	elog "will register the 32 bit driver in a 64 bit prefix, use the following command"
	elog "to register the 64 bit driver in a 64 bit wineprefix:"
	elog
	elog "# wine64 regsvr32 wineaiso.dll"
	elog
	elog "regsvr32 registers the ASIO COM object in the default prefix "~/.wine"."
	elog "To use another prefix specify it explicitly, like:"
	elog "# env WINEPREFIX=~/asioapp regsvr32 wineasio.dll"
	echo
}
