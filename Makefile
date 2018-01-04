# Makefile for base-s6serv

VERSION = $$(git describe --tags| sed 's/-.*//g;s/^v//;')
PKGNAME = base-s6serv

BINDIR_EXECLINE = /usr/local/bin
BINDIR = /usr/bin


DAEMON = $$(find base -type f)
DAEMON_USER = $$(find user/classic/base -type f)
FILES = $$(find base user -mindepth 1 -type f)

LOGD = $$(find base -maxdepth 3 -type f -name logd)
LOGD_USER = $$(find user/classic -maxdepth 3 -type f -name logd)


install: 
	
	for i in $(FILES); do \
		sed -i 's,@BINDIR_EXECLINE@,$(BINDIR_EXECLINE),' $$i; \
		sed -i 's,@BINDIR@,$(BINDIR),' $$i; \
	done 
	if [[ -n $(LOGD) ]]; then \
		install -Dm 0644 $(LOGD) $(DESTDIR)/etc/s6-serv/log.d/base; \
	fi 
	
	if [[ -n $(LOGD_USER) ]]; then \
		install -Dm 0644 $(LOGD_USER) $(DESTDIR)/etc/s6-serv/log.d/user/base; \
	fi 
	
	if [[ -n $(DAEMON) ]]; then \
		for i in $(DAEMON); do \
			if [[ $$i =~ run ]] || [[ $$i =~ finish ]]; then \
				install -Dm 0755 $$i $(DESTDIR)/etc/s6-serv/available/classic/$$i; \
			else \
				install -Dm 0644 $$i $(DESTDIR)/etc/s6-serv/available/classic/$$i; \
			fi \
		done \
	fi
	if [[ -n $(DAEMON_USER) ]]; then \
		for i in $(DAEMON_USER);do \
			if [[ $$i =~ run ]] || [[ $$i =~ finish ]]; then \
				install -Dm 0755 $$i $(DESTDIR)/etc/s6-serv/available/$$i; \
			else \
				install -Dm 0644 $$i $(DESTDIR)/etc/s6-serv/available/$$i; \
			fi \
		done \
	fi 
	if [[ -n $(LOGD) ]]; then \
		rm $(DESTDIR)/etc/s6-serv/available/classic/$(LOGD); \
	fi
	if [[ -n $(LOGD_USER) ]]; then \
		rm $(DESTDIR)/etc/s6-serv/available/$(LOGD_USER); \
	fi
	
	install -Dm644 LICENSE $(DESTDIR)/usr/share/licenses/$(PKGNAME)/LICENSE

version:
	@echo $(VERSION)
	
.PHONY: install version 
