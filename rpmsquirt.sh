#!/bin/sh

RPMSQUIRT=/rpmsquirt.dat
RPMBASE=/root/rpmbuild

createpkg() {
	PKGNAME=$1
	PKGVERS=$2

	if [ -f ${RPMBASE}/SPECS/${PKGNAME}.spec ]; then
		rm -f ${RPMBASE}/SPECS/${PKGNAME}.spec
	fi

	cd /
	mkdir -p ${RPMBASE}/{BUILD,RPMS,SOURCES,SPECS,SRPMS,tmp}

	cd ${RPMBASE}/SPECS
	rpmdev-newspec -t dummy ${PKGNAME}.spec
	mv ${PKGNAME}.spec ${PKGNAME}.spec.pre
	cat ${PKGNAME}.spec.pre | \
		sed -e 's|1%{?dist}|0|g' | \
		sed -e "s|1.0|${PKGVERS}|g" > \
		${PKGNAME}.spec

	cd ${RPMBASE}/SOURCES
	touch ${PKGNAME}
	tar zcf ${PKGNAME}-${PKGVERS}.tar.gz ${PKGNAME}

	cd ${RPMBASE} 
	rpmbuild -ba SPECS/${PKGNAME}.spec
}

installpkg() {
	PKGNAME=$1
	PKGVERS=$2

	rpm -ivh ${RPMBASE}/RPMS/x86_64/${PKGNAME}-${PKGVERS}-0.x86_64.rpm
}

if [ ! -f /rpmsquirt.dat ]; then
	echo Error: /rpmsquirt.dat not found
	exit 1
fi

while read -r line
do
	_pkgname=`echo $line | awk -F ' ' '{print $1}'`
	_pkgvers=`echo $line | awk -F ' ' '{print $2}'`

	createpkg ${_pkgname} ${_pkgvers}
	installpkg ${_pkgname} ${_pkgvers}
done < "${RPMSQUIRT}"

rm -rf /root/rpmbuild /rpmbuild/
