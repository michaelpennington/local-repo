# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11})

inherit python-any-r1
inherit xdg-utils

DESCRIPTION="Cardinal - Virtual modular synthesizer"

HOMEPAGE="https://github.com/DISTRHO/Cardinal"

SRC_URI="https://github.com/DISTRHO/${PN}/releases/download/${PV}/${P}.tar.xz"

#S="${WORKDIR}/${P}"

LICENSE="GPL-3+"

SLOT="0"

KEYWORDS="~amd64"

IUSE="clap debug +fftw +gui jack lto lv2 test vst vst3"

REQUIRED_USE="
	|| ( clap jack lv2 vst vst3 )
"

RDEPEND="
	>=sys-apps/dbus-1.15.4
	>=sys-apps/file-5.44-r3
	>=dev-libs/jansson-2.14-r1
	jack? ( >=virtual/jack-2 )
	|| (
		>=media-libs/alsa-lib-1.2.8-r1
		>=media-sound/pulseaudio-16.1
		>=media-libs/liblo-0.31
	)
	>=app-arch/libarchive-3.6.1-r1
	!gui? ( >=media-libs/liblo-0.31 )
	>=media-libs/libsamplerate-0.2.2
	>=media-libs/libsndfile-1.2.0
	gui? (
		>=x11-libs/libX11-1.8.4
		>=x11-libs/libXext-1.3.5
		>=x11-libs/libXrandr-1.5.3
		>=x11-libs/libXcursor-1.2.1
		>=media-libs/libglvnd-1.6.0
	)
	fftw? ( >=sci-libs/fftw-3.3.10 )
	lv2? ( >=media-libs/lv2-1.18.10 )
	>=media-libs/speexdsp-1.2.1
	test? (
		>=dev-util/lv2lint-0.16.2
		>=x11-misc/xvfb-run-21.1.4.3
	)
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	${PYTHON_DEPS}
	>=dev-util/cmake-3.25.2
	jack? ( >=dev-util/gendesk-1.0.9 )
"

RESTRICT="!test? ( test )"

src_prepare() {
	if use jack; then
		gendesk \
			-n \
			--exec Cardinal \
			--name Cardinal \
			--pkgname studio.kx.distrho.Cardinal \
			--pkgdesc "Cardinal virtual modular synthesizer - JACK standalone" \
			--icon "${PN}" \
			--genericname "Virtual modular synthesizer" \
			--categories "AudioVideo"
	fi

	eapply_user
}

src_compile() {
	CFLAGS+=" -mno-avx -mno-avx2 -mno-fma -mno-f16c"
	CXXFLAGS+=" -mno-avx -mno-avx2 -mno-fma -mno-f16c"
	emake \
		DEBUG=$(usex debug "true" "false") \
		PREFIX="${EPREFIX}"/usr \
		SKIP_STRIPPING=true \
		SYSDEPS=true \
		WITH_LTO=$(usex lto "true" "false") \
		HEADLESS=$(usex gui "false" "true")
}

src_test() {
	declare -A _links=(
		["Cardinal"]="https://distrho.kx.studio/plugins/cardinal"
		["CardinalFX"]="https://distrho.kx.studio/plugins/cardinal#fx"
		["CardinalSynth"]="https://distrho.kx.studio/plugins/cardinal#synth"
	)

	# NOTE: lvlint fails on Cardinal, as it makes use of non-standard Port Class, which it does not support yet
	for _name in Cardinal{FX,Synth}; do
		xvfb-run lv2lint -s "lv2_generate_ttl" -Mpack -I ${P}/bin/$_name.lv2 "${_links[$_name]}"
	done
}

src_install() {
	emake \
		PREFIX="${EPREFIX}"/usr \
		DESTDIR="${D}" \
		install

	mv "${D}"/usr/lib{,64}
	mv "${D}"/usr/share/doc/{"${PN}","${P}"}

	if use jack; then
		install -vDm644 *.desktop -t "${D}"/usr/share/applications
		install -vDm644 "${FILESDIR}"/"${P}".svg "${D}"/usr/share/icons/hicolor/scalable/apps/"${PN}".svg
	fi

	if ! use lv2 ; then
		rm -rf "${D}"/usr/lib64/lv2
	fi
	if ! use vst ; then
		rm -rf "${D}"/usr/lib64/vst
	fi
	if ! use vst3 ; then
		rm -rf "${D}"/usr/lib64/vst3
	fi
	if ! use clap ; then
		rm -rf "${D}"/usr/lib64/clap
	fi
	if ! use jack ; then
		rm -rf "${D}"/usr/bin
	fi
}

pkg_postinst() {
	if use jack ; then
		xdg_icon_cache_update
		xdg_desktop_database_update
	fi
}

pkg_postrm() {
	if use jack ; then
		xdg_icon_cache_update
		xdg_desktop_database_update
	fi
}
