# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby24"

inherit eutils ruby-ng

DESCRIPTION="Arachni is a feature-full web application scanner"
HOMEPAGE="http://arachni-scanner.com/"
SRC_URI="https://github.com/Arachni/arachni/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-libs/libxslt
	dev-libs/openssl
	dev-libs/libxml2
	dev-libs/mpfr
	dev-libs/libyaml
"
ruby_add_rdepend "
	=dev-ruby/addressable-2.3* >=dev-ruby/addressable-2.3.6
	>=dev-ruby/arachni-rpc-0.2.1.3
	dev-ruby/awesome_print
	dev-ruby/bundler
	>=dev-ruby/childprocess-0.5.3
	>=dev-ruby/coderay-1.1.0
	>=dev-ruby/kramdown-1.4.1
	=dev-ruby/loofah-2.0*
	>=dev-ruby/msgpack-0.5.8
	>dev-ruby/nokogiri-1.6.7
	>=dev-ruby/concurrent-ruby-ext-1.0.1
	=dev-ruby/oj-2.14*
	dev-ruby/oj_mimic_json
	>=dev-ruby/pony-1.8
	dev-ruby/rack:*
	>=dev-ruby/rb-readline-0.5.1
	dev-ruby/rubyzip:1
	>=dev-ruby/terminal-table-1.4.5
	dev-ruby/typhoeus:0
	>=dev-ruby/watir-webdriver-0.8.0
	>=dev-ruby/sinatra-contrib-1.4.6
	>=dev-ruby/sinatra-1.4.6
	>=dev-ruby/puma-2.14.0
	dev-ruby/http_parser_rb
"

pkg_setup() {
	ruby-ng_pkg_setup
}

each_ruby_prepare() {
	epatch "${FILESDIR}/${PV}-config.patch"
	epatch "${FILESDIR}/${PV}-easierdep.patch"
	for file in $(ls -1 bin/*); do
		sed "s#/usr/bin/env ruby#${RUBY}#" -i "${file}" || die "Conversion of shebang in '${file}' failed"
	done

	BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
	BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
}

each_ruby_install() {
	dodir /usr/$(get_libdir)/${PN}
	cp -R "${S}"/* "${ED}"/usr/$(get_libdir)/${PN}/ || die "Copy files failed"

	#we write a loader to make sure ${RUBY} is pax marked
#	cat <<-EOF > "${ED}"/usr/$(get_libdir)/${PN}/bin/arachni-loader
#		#!/bin/sh
#		exec ${RUBY} /usr/$(get_libdir)/${PN}/bin/\$(basename \$0)
#	EOF
#	fperms +x /usr/$(get_libdir)/${PN}/bin/arachni-loader

	dosym /usr/$(get_libdir)/arachni/bin/arachni /usr/bin/arachni
	dosym /usr/$(get_libdir)/arachni/bin/arachni_console /usr/bin/arachni_console
}
