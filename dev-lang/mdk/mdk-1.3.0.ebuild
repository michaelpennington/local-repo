# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="An emulation of Donald Knuth's mythical MIX computer"
HOMEPAGE="https://www.gnu.org/software/mdk/mdk.html"
SRC_URI="https://ftp.gnu.org/gnu/${PN}/v${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="gui guile +readline"

DEPEND="
	>=dev-libs/glib-2.74.5
	gui? (
		>=x11-libs/gtk+-3.24.36
		>=x11-libs/pango-1.50.12
	)
	readline? ( >=sys-libs/readline-8.2_p1 )
	guile? ( >=dev-scheme/guile-2.2.7-r1 )
"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-lang/perl-5.36.0
	>=sys-libs/ncurses-6.4
	>=sys-devel/flex-2.6.4-r5
"

src_configure() {
	econf \
		$(use_enable gui) \
		$(use_with guile) \
		$(use_with readline)
}

src_install() {
	emake DESTDIR="${ED}" install
}
