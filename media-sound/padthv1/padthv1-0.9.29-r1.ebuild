# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg-utils

DESCRIPTION="Old-school polyphonic additive synthesizer"
HOMEPAGE="http://padthv1.sourceforge.net"
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/rncbc/${PN}.git"
	KEYWORDS=""
else
	MY_PV=$(ver_rs 1- _)
	SRC_URI="https://github.com/rncbc/${PN}/archive/${PN}_${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	RESTRICT="mirror"
	S="${WORKDIR}/${PN}-${PN}_${MY_PV}"
fi
LICENSE="GPL-2+"
SLOT="0"

IUSE="alsa debug lv2 nsm osc standalone wayland"
REQUIRED_USE="
	|| ( standalone lv2 )
	alsa? ( standalone )"

RDEPEND="
	>=sci-libs/fftw-3.3.10
	>=dev-qt/qtcore-5.15.8-r3:5
	>=dev-qt/qtgui-5.15.8-r3:5
	>=dev-qt/qtwidgets-5.15.8-r2:5
	>=dev-qt/qtxml-5.15.8:5
	standalone? ( >=virtual/jack-2 )
	alsa? ( >=media-libs/alsa-lib-1.2.8-r1 )
	lv2? ( >=media-libs/lv2-1.18.10 )
	osc? ( >=media-libs/liblo-0.31 )
	nsm? ( >=media-sound/new-session-manager-1.6.1 )

"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i '/^\s*add_custom_command/d' src/CMakeLists.txt
	sed -i '/^\s*COMMAND strip/d' src/CMakeLists.txt

	cmake_src_prepare
}

src_configure() {
	alsa=$(usex alsa ON OFF)
	jack=$(usex standalone ON OFF)
	nsm=$(usex nsm ON OFF)
	osc=$(usex osc ON OFF)
	lv2=$(usex lv2 ON OFF)
	wayland=$(usex wayland ON OFF)
	local mycmakeargs=(
		-DCONFIG_ALSA_MIDI=$alsa
		-DCONFIG_JACK=$jack
		-DCONFIG_JACK_MIDI=$jack
		-DCONFIG_JACK_SESSION=$jack
		-DCONFIG_LIBLO=$osc
		-DCONFIG_LV2=$lv2
		-DCONFIG_LV2_PATCH=$lv2
		-DCONFIG_LV2_PORT_EVENT=$lv2
		-DCONFIG_LV2_PROGRAMS=$lv2
		-DCONFIG_LV2_UI_EXTERNAL=$lv2
		-DCONFIG_LV2_UI_IDLE=$lv2
		-DCONFIG_LV2_UI_RESIZE=$lv2
		-DCONFIG_LV2_UI_SHOW=$lv2
		-DCONFIG_LV2_UI_X11=$lv2
		-DCONFIG_NSM=$nsm
		-DCONFIG_QT6=OFF
		-DCONFIG_WAYLAND=$wayland
	)

	cmake_src_configure
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}
