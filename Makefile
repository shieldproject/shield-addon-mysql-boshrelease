SHELL := /bin/bash

# Upstream source URLs
MYSQL_MIRROR   := https://dev.mysql.com/get/Downloads
BOOST_MIRROR   := https://archives.boost.io/release
TIRPC_MIRROR   := https://downloads.sourceforge.net/project/libtirpc/libtirpc
PKGCONF_MIRROR := https://pkgconfig.freedesktop.org/releases

# XtraBackup upstream URLs
GNU_MIRROR     := https://ftp.gnu.org/gnu
PERCONA_MIRROR := https://www.percona.com/downloads/Percona-XtraBackup-LATEST/Percona-XtraBackup

.DEFAULT_GOAL := help

.PHONY: help
help: ## Show available targets
	@printf "\n\033[1mSHIELD MySQL Addon - Blob Management\033[0m\n\n"
	@printf "\033[36m%-24s\033[0m %s\n" "Target" "Description"
	@printf "\033[36m%-24s\033[0m %s\n" "------" "-----------"
	@grep -E '^[a-zA-Z0-9._-]+:.*##' $(MAKEFILE_LIST) \
		| sed 's/:.*## /\t/' \
		| awk -F'\t' '{ printf "\033[33m%-24s\033[0m %s\n", $$1, $$2 }'
	@echo

.PHONY: blobs
blobs: blobs-mysql blobs-shared blobs-xtrabackup ## Download all blobs

.PHONY: blobs-mysql
blobs-mysql: blobs/mysql/mysql-5.7.43.tar.gz blobs/mysql/mysql-boost-8.0.45.tar.gz blobs/mysql/mysql-8.4.8.tar.gz ## Download MySQL source blobs

.PHONY: blobs-shared
blobs-shared: blobs/shared/boost_1_59_0.tar.gz blobs/shared/libtirpc_1.3.2.tar.bz2 blobs/shared/pkg-config_0.29.2.tar.gz ## Download shared dependency blobs

.PHONY: blobs-xtrabackup
blobs-xtrabackup: blobs/xtrabackup/autoconf-2.65.tar.gz blobs/xtrabackup/automake-1.14.1.tar.gz blobs/xtrabackup/libaio_0.3.110.orig.tar.gz blobs/xtrabackup/libdbd-mysql-perl_4.025.orig.tar.gz blobs/xtrabackup/libdbi-perl_1.630.orig.tar.gz blobs/xtrabackup/libev-4.23.tar.gz blobs/xtrabackup/libtool-2.4.2.tar.gz blobs/xtrabackup/percona-xtrabackup-2.4.5.tar.gz blobs/xtrabackup/percona-xtrabackup-8.0.5.tar.gz blobs/xtrabackup/socat-1.7.2.4.tar.gz ## Download XtraBackup dependency blobs

# --- MySQL sources ---

blobs/mysql/mysql-5.7.43.tar.gz:
	@mkdir -p blobs/mysql
	@printf "\033[36m>>>\033[0m Downloading \033[33mMySQL 5.7.43\033[0m ...\n"
	@curl -fSL -o "$@" "$(MYSQL_MIRROR)/MySQL-5.7/mysql-5.7.43.tar.gz" \
		|| { rm -f "$@"; printf "\033[31m!!! Download failed\033[0m\n"; exit 1; }
	@printf "\033[32m    ok\033[0m %s\n" "$@"

blobs/mysql/mysql-boost-8.0.45.tar.gz:
	@mkdir -p blobs/mysql
	@printf "\033[36m>>>\033[0m Downloading \033[33mMySQL 8.0.45 (with boost)\033[0m ...\n"
	@curl -fSL -o "$@" "$(MYSQL_MIRROR)/MySQL-8.0/mysql-boost-8.0.45.tar.gz" \
		|| { rm -f "$@"; printf "\033[31m!!! Download failed\033[0m\n"; exit 1; }
	@printf "\033[32m    ok\033[0m %s\n" "$@"

blobs/mysql/mysql-8.4.8.tar.gz:
	@mkdir -p blobs/mysql
	@printf "\033[36m>>>\033[0m Downloading \033[33mMySQL 8.4.8\033[0m ...\n"
	@curl -fSL -o "$@" "$(MYSQL_MIRROR)/MySQL-8.4/mysql-8.4.8.tar.gz" \
		|| { rm -f "$@"; printf "\033[31m!!! Download failed\033[0m\n"; exit 1; }
	@printf "\033[32m    ok\033[0m %s\n" "$@"

# --- Shared dependencies ---

blobs/shared/boost_1_59_0.tar.gz:
	@mkdir -p blobs/shared
	@printf "\033[36m>>>\033[0m Downloading \033[33mBoost 1.59.0\033[0m ...\n"
	@curl -fSL -o "$@" "$(BOOST_MIRROR)/1.59.0/source/boost_1_59_0.tar.gz" \
		|| { rm -f "$@"; printf "\033[31m!!! Download failed\033[0m\n"; exit 1; }
	@printf "\033[32m    ok\033[0m %s\n" "$@"

blobs/shared/libtirpc_1.3.2.tar.bz2:
	@mkdir -p blobs/shared
	@printf "\033[36m>>>\033[0m Downloading \033[33mlibtirpc 1.3.2\033[0m ...\n"
	@curl -fSL -o "$@" "$(TIRPC_MIRROR)/1.3.2/libtirpc-1.3.2.tar.bz2" \
		|| { rm -f "$@"; printf "\033[31m!!! Download failed\033[0m\n"; exit 1; }
	@printf "\033[32m    ok\033[0m %s\n" "$@"

blobs/shared/pkg-config_0.29.2.tar.gz:
	@mkdir -p blobs/shared
	@printf "\033[36m>>>\033[0m Downloading \033[33mpkg-config 0.29.2\033[0m ...\n"
	@curl -fSL -o "$@" "$(PKGCONF_MIRROR)/pkg-config-0.29.2.tar.gz" \
		|| { rm -f "$@"; printf "\033[31m!!! Download failed\033[0m\n"; exit 1; }
	@printf "\033[32m    ok\033[0m %s\n" "$@"

# --- XtraBackup dependencies ---

blobs/xtrabackup/autoconf-2.65.tar.gz:
	@mkdir -p blobs/xtrabackup
	@printf "\033[36m>>>\033[0m Downloading \033[33mautoconf 2.65\033[0m ...\n"
	@curl -fSL -o "$@" "$(GNU_MIRROR)/autoconf/autoconf-2.65.tar.gz" \
		|| { rm -f "$@"; printf "\033[31m!!! Download failed\033[0m\n"; exit 1; }
	@printf "\033[32m    ok\033[0m %s\n" "$@"

blobs/xtrabackup/automake-1.14.1.tar.gz:
	@mkdir -p blobs/xtrabackup
	@printf "\033[36m>>>\033[0m Downloading \033[33mautomake 1.14.1\033[0m ...\n"
	@curl -fSL -o "$@" "$(GNU_MIRROR)/automake/automake-1.14.1.tar.gz" \
		|| { rm -f "$@"; printf "\033[31m!!! Download failed\033[0m\n"; exit 1; }
	@printf "\033[32m    ok\033[0m %s\n" "$@"

blobs/xtrabackup/libaio_0.3.110.orig.tar.gz:
	@mkdir -p blobs/xtrabackup
	@printf "\033[36m>>>\033[0m Downloading \033[33mlibaio 0.3.110\033[0m ...\n"
	@curl -fSL -o "$@" "https://ftp.debian.org/debian/pool/main/liba/libaio/libaio_0.3.110.orig.tar.gz" \
		|| { rm -f "$@"; printf "\033[31m!!! Download failed\033[0m\n"; exit 1; }
	@printf "\033[32m    ok\033[0m %s\n" "$@"

blobs/xtrabackup/libdbd-mysql-perl_4.025.orig.tar.gz:
	@mkdir -p blobs/xtrabackup
	@printf "\033[36m>>>\033[0m Downloading \033[33mDBD::mysql 4.025\033[0m ...\n"
	@curl -fSL -o "$@" "https://cpan.metacpan.org/authors/id/C/CA/CAPTTOFU/DBD-mysql-4.025.tar.gz" \
		|| { rm -f "$@"; printf "\033[31m!!! Download failed\033[0m\n"; exit 1; }
	@printf "\033[32m    ok\033[0m %s\n" "$@"

blobs/xtrabackup/libdbi-perl_1.630.orig.tar.gz:
	@mkdir -p blobs/xtrabackup
	@printf "\033[36m>>>\033[0m Downloading \033[33mDBI 1.630\033[0m ...\n"
	@curl -fSL -o "$@" "https://cpan.metacpan.org/authors/id/T/TI/TIMB/DBI-1.630.tar.gz" \
		|| { rm -f "$@"; printf "\033[31m!!! Download failed\033[0m\n"; exit 1; }
	@printf "\033[32m    ok\033[0m %s\n" "$@"

blobs/xtrabackup/libev-4.23.tar.gz:
	@mkdir -p blobs/xtrabackup
	@printf "\033[36m>>>\033[0m Downloading \033[33mlibev 4.23\033[0m ...\n"
	@curl -fSL -o "$@" "http://dist.schmorp.de/libev/libev-4.23.tar.gz" \
		|| { rm -f "$@"; printf "\033[31m!!! Download failed\033[0m\n"; exit 1; }
	@printf "\033[32m    ok\033[0m %s\n" "$@"

blobs/xtrabackup/libtool-2.4.2.tar.gz:
	@mkdir -p blobs/xtrabackup
	@printf "\033[36m>>>\033[0m Downloading \033[33mlibtool 2.4.2\033[0m ...\n"
	@curl -fSL -o "$@" "$(GNU_MIRROR)/libtool/libtool-2.4.2.tar.gz" \
		|| { rm -f "$@"; printf "\033[31m!!! Download failed\033[0m\n"; exit 1; }
	@printf "\033[32m    ok\033[0m %s\n" "$@"

blobs/xtrabackup/percona-xtrabackup-2.4.5.tar.gz:
	@mkdir -p blobs/xtrabackup
	@printf "\033[36m>>>\033[0m Downloading \033[33mPercona XtraBackup 2.4.5\033[0m ...\n"
	@curl -fSL -o "$@" "https://downloads.percona.com/downloads/Percona-XtraBackup-2.4/Percona-XtraBackup-2.4.5/source/tarball/percona-xtrabackup-2.4.5.tar.gz" \
		|| { rm -f "$@"; printf "\033[31m!!! Download failed\033[0m\n"; exit 1; }
	@printf "\033[32m    ok\033[0m %s\n" "$@"

blobs/xtrabackup/percona-xtrabackup-8.0.5.tar.gz:
	@mkdir -p blobs/xtrabackup
	@printf "\033[36m>>>\033[0m Downloading \033[33mPercona XtraBackup 8.0.5\033[0m ...\n"
	@curl -fSL -o "$@" "https://downloads.percona.com/downloads/Percona-XtraBackup-LATEST/Percona-XtraBackup-8.0.5/source/tarball/percona-xtrabackup-8.0.5.tar.gz" \
		|| { rm -f "$@"; printf "\033[31m!!! Download failed\033[0m\n"; exit 1; }
	@printf "\033[32m    ok\033[0m %s\n" "$@"

blobs/xtrabackup/socat-1.7.2.4.tar.gz:
	@mkdir -p blobs/xtrabackup
	@printf "\033[36m>>>\033[0m Downloading \033[33msocat 1.7.2.4\033[0m ...\n"
	@curl -fSL -o "$@" "http://www.dest-unreach.org/socat/download/socat-1.7.2.4.tar.gz" \
		|| { rm -f "$@"; printf "\033[31m!!! Download failed\033[0m\n"; exit 1; }
	@printf "\033[32m    ok\033[0m %s\n" "$@"

# --- Verification ---

.PHONY: verify
verify: ## Verify blob checksums against config/blobs.yml
	@printf "\n\033[1mVerifying blob checksums\033[0m\n\n"
	@ok=0; fail=0; skip=0; \
	for blob_file in $$(find blobs -type f 2>/dev/null | sort); do \
		key=$$(echo "$$blob_file" | sed 's|^blobs/||'); \
		expected=$$(awk "/^$$(echo $$key | sed 's|/|\\/|g'):/,/sha:/" config/blobs.yml \
			| grep 'sha:' | head -1 | sed 's/.*sha256://'); \
		if [ -z "$$expected" ]; then \
			sha1=$$(awk "/^$$(echo $$key | sed 's|/|\\/|g'):/,/sha:/" config/blobs.yml \
				| grep 'sha:' | head -1 | awk '{print $$2}'); \
			if [ -n "$$sha1" ]; then \
				actual=$$(shasum "$$blob_file" | awk '{print $$1}'); \
				if [ "$$actual" = "$$sha1" ]; then \
					printf "\033[32m    ok\033[0m %s (sha1)\n" "$$key"; \
					ok=$$((ok + 1)); \
				else \
					printf "\033[31m  FAIL\033[0m %s (sha1)\n" "$$key"; \
					fail=$$((fail + 1)); \
				fi; \
			else \
				printf "\033[33m  SKIP\033[0m %s (no checksum in blobs.yml)\n" "$$key"; \
				skip=$$((skip + 1)); \
			fi; \
			continue; \
		fi; \
		actual=$$(shasum -a 256 "$$blob_file" | awk '{print $$1}'); \
		if [ "$$actual" = "$$expected" ]; then \
			printf "\033[32m    ok\033[0m %s\n" "$$key"; \
			ok=$$((ok + 1)); \
		else \
			printf "\033[31m  FAIL\033[0m %s\n" "$$key"; \
			printf "       expected: %s\n" "$$expected"; \
			printf "         actual: %s\n" "$$actual"; \
			fail=$$((fail + 1)); \
		fi; \
	done; \
	echo; \
	printf "\033[1m%d passed, %d failed, %d skipped\033[0m\n\n" "$$ok" "$$fail" "$$skip"; \
	[ "$$fail" -eq 0 ]

.PHONY: clean
clean: ## Remove all downloaded blobs
	rm -rf blobs/mysql blobs/shared blobs/xtrabackup
	@printf "\033[32mCleaned\033[0m blobs/{mysql,shared,xtrabackup}\n"

.PHONY: list
list: ## List all blobs and download status
	@printf "\n\033[1mMySQL Addon Blobs\033[0m\n\n"
	@printf "\033[36m%-16s %-52s %s\033[0m\n" "Category" "Blob" "Status"
	@printf "\033[36m%-16s %-52s %s\033[0m\n" "--------" "----" "------"
	@for blob in \
		blobs/mysql/mysql-5.7.43.tar.gz \
		blobs/mysql/mysql-boost-8.0.45.tar.gz \
		blobs/mysql/mysql-8.4.8.tar.gz \
		blobs/shared/boost_1_59_0.tar.gz \
		blobs/shared/libtirpc_1.3.2.tar.bz2 \
		blobs/shared/pkg-config_0.29.2.tar.gz \
		blobs/xtrabackup/autoconf-2.65.tar.gz \
		blobs/xtrabackup/automake-1.14.1.tar.gz \
		blobs/xtrabackup/libaio_0.3.110.orig.tar.gz \
		blobs/xtrabackup/libdbd-mysql-perl_4.025.orig.tar.gz \
		blobs/xtrabackup/libdbi-perl_1.630.orig.tar.gz \
		blobs/xtrabackup/libev-4.23.tar.gz \
		blobs/xtrabackup/libtool-2.4.2.tar.gz \
		blobs/xtrabackup/percona-xtrabackup-2.4.5.tar.gz \
		blobs/xtrabackup/percona-xtrabackup-8.0.5.tar.gz \
		blobs/xtrabackup/socat-1.7.2.4.tar.gz; do \
		cat=$$(echo "$$blob" | cut -d/ -f2); \
		if [ -f "$$blob" ]; then \
			printf "\033[33m%-16s\033[0m %-52s \033[32m%s\033[0m\n" "$$cat" "$$blob" "downloaded"; \
		else \
			printf "\033[33m%-16s\033[0m %-52s \033[31m%s\033[0m\n" "$$cat" "$$blob" "missing"; \
		fi; \
	done
	@echo
