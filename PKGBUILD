# Maintainer: Eric Vidal <eric@obarun.org>

pkgbase=xdm
_depends=xorg-xdm
pkgname="${pkgbase}"-s6serv
pkgver=0.1
pkgrel=1
pkgdesc="${pkgbase} service for s6"
arch=(x86_64)
license=('ISC')
depends=("${_depends}" 's6' 's6-boot' 's6opts')
makedepends=('util-linux' 'findutils')
conflicts=()
source=("$pkgname::git+https://github.com/obarun-pkgbuild/${pkgname}#branch=master")
md5sums=('SKIP')
validpgpkeys=('6DD4217456569BA711566AC7F06E8FDE7B45DAAC') # Eric Vidal

prepare(){
	cd "${pkgname}"
	
	sed -i "s:base:${pkgbase}:g" Makefile
	
	if [[ -d base ]]; then
		find -type d -name 'base' | rename base "${pkgbase}" * 
		for i in */log/logd */log/run; do
			sed -i "s:base:${pkgbase}:g" $i 
		done
	fi
	# user
	if [[ -d user ]]; then
		find user/classic -type d -name 'base' | rename base "${pkgbase}" user/classic/*
		for i in user/classic/*/log/logd user/classic/*/log/run; do
			sed -i "s:base:${pkgbase}:g" $i 
		done
	fi
}
package(){
	cd "${pkgname}"
	
	make DESTDIR="$pkgdir" install
	
}
