# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils

DESCRIPTION="A cross-platform multimedia framework based on Qt and FFmpeg."
HOMEPAGE="http://qtav.org"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/wang-bin/${PN}"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/wang-bin/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="LGPL-2.1+ GPL-3"
SLOT="0"

IUSE=""

DEPEND="
	media-video/ffmpeg
	media-libs/openal
	media-libs/libass
	dev-util/desktop-file-utils
	dev-qt/qtdeclarative:5
	|| ( dev-libs/uchardet app-i18n/uchardet )
	x11-libs/libXv
	"

RDEPEND=""

src_prepare() {
	# fix mkspecs install dir
	sed -e 's|\$\$\[QT_INSTALL_BINS\]\/\.\.\/mkspecs|\$\$\[QT_INSTALL_ARCHDATA\]\/mkspecs|g' -i tools/install_sdk/install_sdk.pro
}

src_configure() {
	myconf=(
		PREFIX=/usr \
		CONFIG+=no_rpath \
	)
	eqmake5 ${myconf[@]} -r ${PN}.pro
}
src_install() {
	emake INSTALL_ROOT="${D}" install
}
