# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#VIM_PLUGIN_VIM_VERSION="7.0"
inherit vim-plugin
inherit git-r3

#S="${WORKDIR}/vim-fish-syntax"

EGIT_REPO_URI="https://github.com/khaveesh/vim-fish-syntax"

DESCRIPTION="vim plugin: syntax for app-shells/fish"
HOMEPAGE="https://github.com/khaveesh/vim-fish-syntax"
LICENSE="MIT"
KEYWORDS="~amd64"

VIM_PLUGIN_HELPFILES=""
VIM_PLUGIN_HELPTEXT=""
VIM_PLUGIN_HELPURI=""
VIM_PLUGIN_MESSAGES=""
