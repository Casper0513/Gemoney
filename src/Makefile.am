# Copyright (c) 2013-2016 The Bitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

DIST_SUBDIRS = secp256k1 univalue

AM_LDFLAGS = $(PTHREAD_CFLAGS) $(LIBTOOL_LDFLAGS) $(HARDENED_LDFLAGS) $(GPROF_LDFLAGS) $(SANITIZER_LDFLAGS)
AM_CXXFLAGS = $(DEBUG_CXXFLAGS) $(HARDENED_CXXFLAGS) $(WARN_CXXFLAGS) $(NOWARN_CXXFLAGS) $(ERROR_CXXFLAGS) $(GPROF_CXXFLAGS) $(SANITIZER_CXXFLAGS)
AM_CPPFLAGS = $(DEBUG_CPPFLAGS) $(HARDENED_CPPFLAGS)
AM_LIBTOOLFLAGS = --preserve-dup-deps
EXTRA_LIBRARIES =

if EMBEDDED_UNIVALUE
LIBUNIVALUE = univalue/libunivalue.la

$(LIBUNIVALUE): $(wildcard univalue/lib/*) $(wildcard univalue/include/*)
	$(AM_V_at)$(MAKE) $(AM_MAKEFLAGS) -C $(@D) $(@F)
else
LIBUNIVALUE = $(UNIVALUE_LIBS)
endif

GEMONEY_INCLUDES=-I$(builddir) $(BDB_CPPFLAGS) $(BOOST_CPPFLAGS) $(LEVELDB_CPPFLAGS) $(CRYPTO_CFLAGS) $(SSL_CFLAGS)

GEMONEY_INCLUDES += -I$(srcdir)/secp256k1/include
GEMONEY_INCLUDES += $(UNIVALUE_CFLAGS)

LIBGEMONEY_SERVER=libgemoney_server.a
LIBGEMONEY_COMMON=libgemoney_common.a
LIBGEMONEY_CONSENSUS=libgemoney_consensus.a
LIBGEMONEY_CLI=libgemoney_cli.a
LIBGEMONEY_UTIL=libgemoney_util.a
LIBGEMONEY_CRYPTO_BASE=crypto/libgemoney_crypto_base.a
LIBGEMONEYQT=qt/libgemoneyqt.a
LIBSECP256K1=secp256k1/libsecp256k1.la

if ENABLE_ZMQ
LIBGEMONEY_ZMQ=libgemoney_zmq.a
endif
if BUILD_GEMONEY_LIBS
LIBGEMONEYCONSENSUS=libgemoneyconsensus.la
endif
if ENABLE_WALLET
LIBGEMONEY_WALLET=libgemoney_wallet.a
LIBGEMONEY_WALLET_TOOL=libgemoney_wallet_tool.a
endif

LIBGEMONEY_CRYPTO= $(LIBGEMONEY_CRYPTO_BASE)
if ENABLE_SSE41
LIBGEMONEY_CRYPTO_SSE41 = crypto/libgemoney_crypto_sse41.a
LIBGEMONEY_CRYPTO += $(LIBGEMONEY_CRYPTO_SSE41)
endif
if ENABLE_AVX2
LIBGEMONEY_CRYPTO_AVX2 = crypto/libgemoney_crypto_avx2.a
LIBGEMONEY_CRYPTO += $(LIBGEMONEY_CRYPTO_AVX2)
endif
if ENABLE_SHANI
LIBGEMONEY_CRYPTO_SHANI = crypto/libgemoney_crypto_shani.a
LIBGEMONEY_CRYPTO += $(LIBGEMONEY_CRYPTO_SHANI)
endif

$(LIBSECP256K1): $(wildcard secp256k1/src/*.h) $(wildcard secp256k1/src/*.c) $(wildcard secp256k1/include/*)
	$(AM_V_at)$(MAKE) $(AM_MAKEFLAGS) -C $(@D) $(@F)

# Make is not made aware of per-object dependencies to avoid limiting building parallelization
# But to build the less dependent modules first, we manually select their order here:
EXTRA_LIBRARIES += \
  $(LIBGEMONEY_CRYPTO) \
  $(LIBGEMONEY_UTIL) \
  $(LIBGEMONEY_COMMON) \
  $(LIBGEMONEY_CONSENSUS) \
  $(LIBGEMONEY_SERVER) \
  $(LIBGEMONEY_CLI) \
  $(LIBGEMONEY_WALLET) \
  $(LIBGEMONEY_WALLET_TOOL) \
  $(LIBGEMONEY_ZMQ)

lib_LTLIBRARIES = $(LIBGEMONEYCONSENSUS)

bin_PROGRAMS =
noinst_PROGRAMS =
TESTS =
BENCHMARKS =

if BUILD_GEMONEYD
  bin_PROGRAMS += gemoneyd
endif

if BUILD_GEMONEY_CLI
  bin_PROGRAMS += gemoney-cli
endif
if BUILD_GEMONEY_TX
  bin_PROGRAMS += gemoney-tx
endif
if ENABLE_WALLET
if BUILD_GEMONEY_WALLET
  bin_PROGRAMS += gemoney-wallet
endif
endif

.PHONY: FORCE check-symbols check-security
# gemoney core #
GEMONEY_CORE_H = \
  addrdb.h \
  addrman.h \
  attributes.h \
  banman.h \
  base58.h \
  bech32.h \
  bloom.h \
  blockencodings.h \
  blockfilter.h \
  chain.h \
  chainparams.h \
  chainparamsbase.h \
  chainparamsseeds.h \
  checkqueue.h \
  clientversion.h \
  coins.h \
  compat.h \
  compat/assumptions.h \
  compat/byteswap.h \
  compat/endian.h \
  compat/sanity.h \
  compressor.h \
  consensus/consensus.h \
  consensus/tx_check.h \
  consensus/tx_verify.h \
  core_io.h \
  core_memusage.h \
  cuckoocache.h \
  flatfile.h \
  fs.h \
  httprpc.h \
  httpserver.h \
  index/base.h \
  index/blockfilterindex.h \
  index/txindex.h \
  indirectmap.h \
  init.h \
  interfaces/chain.h \
  interfaces/handler.h \
  interfaces/node.h \
  interfaces/wallet.h \
  key.h \
  key_io.h \
  keystore.h \
  dbwrapper.h \
  limitedmap.h \
  logging.h \
  memusage.h \
  merkleblock.h \
  miner.h \
  net.h \
  net_processing.h \
  netaddress.h \
  netbase.h \
  netmessagemaker.h \
  node/coin.h \
  node/psbt.h \
  node/transaction.h \
  noui.h \
  optional.h \
  outputtype.h \
  policy/feerate.h \
  policy/fees.h \
  policy/policy.h \
  policy/rbf.h \
  policy/settings.h \
  pow.h \
  protocol.h \
  psbt.h \
  random.h \
  reverse_iterator.h \
  reverselock.h \
  rpc/blockchain.h \
  rpc/client.h \
  rpc/protocol.h \
  rpc/server.h \
  rpc/rawtransaction_util.h \
  rpc/register.h \
  rpc/util.h \
  scheduler.h \
  script/descriptor.h \
  script/ismine.h \
  script/sigcache.h \
  script/sign.h \
  script/standard.h \
  shutdown.h \
  streams.h \
  support/allocators/secure.h \
  support/allocators/zeroafterfree.h \
  support/cleanse.h \
  support/events.h \
  support/lockedpool.h \
  sync.h \
  threadsafety.h \
  threadinterrupt.h \
  timedata.h \
  torcontrol.h \
  txdb.h \
  txmempool.h \
  ui_interface.h \
  undo.h \
  util/bip32.h \
  util/bytevectorhash.h \
  util/error.h \
  util/fees.h \
  util/system.h \
  util/memory.h \
  util/moneystr.h \
  util/rbf.h \
  util/threadnames.h \
  util/time.h \
  util/url.h \
  util/validation.h \
  validation.h \
  validationinterface.h \
  versionbits.h \
  versionbitsinfo.h \
  walletinitinterface.h \
  wallet/coincontrol.h \
  wallet/crypter.h \
  wallet/db.h \
  wallet/feebumper.h \
  wallet/fees.h \
  wallet/load.h \
  wallet/psbtwallet.h \
  wallet/rpcwallet.h \
  wallet/wallet.h \
  wallet/walletdb.h \
  wallet/wallettool.h \
  wallet/walletutil.h \
  wallet/coinselection.h \
  warnings.h \
  zmq/zmqabstractnotifier.h \
  zmq/zmqconfig.h\
  zmq/zmqnotificationinterface.h \
  zmq/zmqpublishnotifier.h \
  zmq/zmqrpc.h


obj/build.h: FORCE
	@$(MKDIR_P) $(builddir)/obj
	@$(top_srcdir)/share/genbuild.sh "$(abs_top_builddir)/src/obj/build.h" \
	  "$(abs_top_srcdir)"
libgemoney_util_a-clientversion.$(OBJEXT): obj/build.h

# server: shared between gemoneyd and gemoney-qt
# Contains code accessing mempool and chain state that is meant to be separated
# from wallet and gui code (see node/README.md). Shared code should go in
# libgemoney_common or libgemoney_util libraries, instead.
libgemoney_server_a_CPPFLAGS = $(AM_CPPFLAGS) $(GEMONEY_INCLUDES) $(MINIUPNPC_CPPFLAGS) $(EVENT_CFLAGS) $(EVENT_PTHREADS_CFLAGS)
libgemoney_server_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libgemoney_server_a_SOURCES = \
  addrdb.cpp \
  addrman.cpp \
  banman.cpp \
  blockencodings.cpp \
  blockfilter.cpp \
  chain.cpp \
  consensus/tx_verify.cpp \
  flatfile.cpp \
  httprpc.cpp \
  httpserver.cpp \
  index/base.cpp \
  index/blockfilterindex.cpp \
  index/txindex.cpp \
  interfaces/chain.cpp \
  interfaces/node.cpp \
  init.cpp \
  dbwrapper.cpp \
  miner.cpp \
  net.cpp \
  net_processing.cpp \
  node/coin.cpp \
  node/psbt.cpp \
  node/transaction.cpp \
  noui.cpp \
  policy/fees.cpp \
  policy/rbf.cpp \
  policy/settings.cpp \
  pow.cpp \
  rest.cpp \
  rpc/blockchain.cpp \
  rpc/mining.cpp \
  rpc/misc.cpp \
  rpc/net.cpp \
  rpc/rawtransaction.cpp \
  rpc/server.cpp \
  script/sigcache.cpp \
  shutdown.cpp \
  timedata.cpp \
  torcontrol.cpp \
  txdb.cpp \
  txmempool.cpp \
  ui_interface.cpp \
  validation.cpp \
  validationinterface.cpp \
  versionbits.cpp \
  $(GEMONEY_CORE_H)

if ENABLE_WALLET
libgemoney_server_a_SOURCES += wallet/init.cpp
endif
if !ENABLE_WALLET
libgemoney_server_a_SOURCES += dummywallet.cpp
endif

if ENABLE_ZMQ
libgemoney_zmq_a_CPPFLAGS = $(GEMONEY_INCLUDES) $(ZMQ_CFLAGS)
libgemoney_zmq_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libgemoney_zmq_a_SOURCES = \
  zmq/zmqabstractnotifier.cpp \
  zmq/zmqnotificationinterface.cpp \
  zmq/zmqpublishnotifier.cpp \
  zmq/zmqrpc.cpp
endif


# wallet: shared between gemoneyd and gemoney-qt, but only linked
# when wallet enabled
libgemoney_wallet_a_CPPFLAGS = $(AM_CPPFLAGS) $(GEMONEY_INCLUDES)
libgemoney_wallet_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libgemoney_wallet_a_SOURCES = \
  interfaces/wallet.cpp \
  wallet/coincontrol.cpp \
  wallet/crypter.cpp \
  wallet/db.cpp \
  wallet/feebumper.cpp \
  wallet/fees.cpp \
  wallet/load.cpp \
  wallet/psbtwallet.cpp \
  wallet/rpcdump.cpp \
  wallet/rpcwallet.cpp \
  wallet/wallet.cpp \
  wallet/walletdb.cpp \
  wallet/walletutil.cpp \
  wallet/coinselection.cpp \
  $(GEMONEY_CORE_H)

libgemoney_wallet_tool_a_CPPFLAGS = $(AM_CPPFLAGS) $(GEMONEY_INCLUDES)
libgemoney_wallet_tool_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libgemoney_wallet_tool_a_SOURCES = \
  wallet/wallettool.cpp \
  $(GEMONEY_CORE_H)

# crypto primitives library
crypto_libgemoney_crypto_base_a_CPPFLAGS = $(AM_CPPFLAGS)
crypto_libgemoney_crypto_base_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
crypto_libgemoney_crypto_base_a_SOURCES = \
  crypto/aes.cpp \
  crypto/aes.h \
  crypto/chacha20.h \
  crypto/chacha20.cpp \
  crypto/common.h \
  crypto/hmac_sha256.cpp \
  crypto/hmac_sha256.h \
  crypto/hmac_sha512.cpp \
  crypto/hmac_sha512.h \
  crypto/poly1305.h \
  crypto/poly1305.cpp \
  crypto/ripemd160.cpp \
  crypto/ripemd160.h \
  crypto/sha1.cpp \
  crypto/sha1.h \
  crypto/sha256.cpp \
  crypto/sha256.h \
  crypto/sha512.cpp \
  crypto/sha512.h \
  crypto/siphash.cpp \
  crypto/siphash.h

if USE_ASM
crypto_libgemoney_crypto_base_a_SOURCES += crypto/sha256_sse4.cpp
endif

crypto_libgemoney_crypto_sse41_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
crypto_libgemoney_crypto_sse41_a_CPPFLAGS = $(AM_CPPFLAGS)
crypto_libgemoney_crypto_sse41_a_CXXFLAGS += $(SSE41_CXXFLAGS)
crypto_libgemoney_crypto_sse41_a_CPPFLAGS += -DENABLE_SSE41
crypto_libgemoney_crypto_sse41_a_SOURCES = crypto/sha256_sse41.cpp

crypto_libgemoney_crypto_avx2_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
crypto_libgemoney_crypto_avx2_a_CPPFLAGS = $(AM_CPPFLAGS)
crypto_libgemoney_crypto_avx2_a_CXXFLAGS += $(AVX2_CXXFLAGS)
crypto_libgemoney_crypto_avx2_a_CPPFLAGS += -DENABLE_AVX2
crypto_libgemoney_crypto_avx2_a_SOURCES = crypto/sha256_avx2.cpp

crypto_libgemoney_crypto_shani_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
crypto_libgemoney_crypto_shani_a_CPPFLAGS = $(AM_CPPFLAGS)
crypto_libgemoney_crypto_shani_a_CXXFLAGS += $(SHANI_CXXFLAGS)
crypto_libgemoney_crypto_shani_a_CPPFLAGS += -DENABLE_SHANI
crypto_libgemoney_crypto_shani_a_SOURCES = crypto/sha256_shani.cpp

# consensus: shared between all executables that validate any consensus rules.
libgemoney_consensus_a_CPPFLAGS = $(AM_CPPFLAGS) $(GEMONEY_INCLUDES)
libgemoney_consensus_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libgemoney_consensus_a_SOURCES = \
  amount.h \
  arith_uint256.cpp \
  arith_uint256.h \
  consensus/merkle.cpp \
  consensus/merkle.h \
  consensus/params.h \
  consensus/tx_check.cpp \
  consensus/validation.h \
  hash.cpp \
  hash.h \
  prevector.h \
  primitives/block.cpp \
  primitives/block.h \
  primitives/transaction.cpp \
  primitives/transaction.h \
  pubkey.cpp \
  pubkey.h \
  script/gemoneyconsensus.cpp \
  script/interpreter.cpp \
  script/interpreter.h \
  script/script.cpp \
  script/script.h \
  script/script_error.cpp \
  script/script_error.h \
  serialize.h \
  span.h \
  tinyformat.h \
  uint256.cpp \
  uint256.h \
  util/strencodings.cpp \
  util/strencodings.h \
  version.h

# common: shared between gemoneyd, and gemoney-qt and non-server tools
libgemoney_common_a_CPPFLAGS = $(AM_CPPFLAGS) $(GEMONEY_INCLUDES)
libgemoney_common_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libgemoney_common_a_SOURCES = \
  base58.cpp \
  bech32.cpp \
  bloom.cpp \
  chainparams.cpp \
  coins.cpp \
  compressor.cpp \
  core_read.cpp \
  core_write.cpp \
  key.cpp \
  key_io.cpp \
  keystore.cpp \
  merkleblock.cpp \
  netaddress.cpp \
  netbase.cpp \
  outputtype.cpp \
  policy/feerate.cpp \
  policy/policy.cpp \
  protocol.cpp \
  psbt.cpp \
  rpc/rawtransaction_util.cpp \
  rpc/util.cpp \
  scheduler.cpp \
  script/descriptor.cpp \
  script/ismine.cpp \
  script/sign.cpp \
  script/standard.cpp \
  versionbitsinfo.cpp \
  warnings.cpp \
  $(GEMONEY_CORE_H)

# util: shared between all executables.
# This library *must* be included to make sure that the glibc
# backward-compatibility objects and their sanity checks are linked.
libgemoney_util_a_CPPFLAGS = $(AM_CPPFLAGS) $(GEMONEY_INCLUDES)
libgemoney_util_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libgemoney_util_a_SOURCES = \
  support/lockedpool.cpp \
  chainparamsbase.cpp \
  clientversion.cpp \
  compat/glibc_sanity.cpp \
  compat/glibcxx_sanity.cpp \
  compat/strnlen.cpp \
  fs.cpp \
  interfaces/handler.cpp \
  logging.cpp \
  random.cpp \
  rpc/protocol.cpp \
  support/cleanse.cpp \
  sync.cpp \
  threadinterrupt.cpp \
  util/bip32.cpp \
  util/bytevectorhash.cpp \
  util/error.cpp \
  util/fees.cpp \
  util/system.cpp \
  util/moneystr.cpp \
  util/rbf.cpp \
  util/threadnames.cpp \
  util/strencodings.cpp \
  util/time.cpp \
  util/url.cpp \
  util/validation.cpp \
  $(GEMONEY_CORE_H)

if GLIBC_BACK_COMPAT
libgemoney_util_a_SOURCES += compat/glibc_compat.cpp
AM_LDFLAGS += $(COMPAT_LDFLAGS)
endif

# cli: shared between gemoney-cli and gemoney-qt
libgemoney_cli_a_CPPFLAGS = $(AM_CPPFLAGS) $(GEMONEY_INCLUDES)
libgemoney_cli_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libgemoney_cli_a_SOURCES = \
  rpc/client.cpp \
  $(GEMONEY_CORE_H)

nodist_libgemoney_util_a_SOURCES = $(srcdir)/obj/build.h
#

# gemoneyd binary #
gemoneyd_SOURCES = gemoneyd.cpp
gemoneyd_CPPFLAGS = $(AM_CPPFLAGS) $(GEMONEY_INCLUDES)
gemoneyd_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
gemoneyd_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
gemoneyd_SOURCES += gemoneyd-res.rc
endif

# Libraries below may be listed more than once to resolve circular dependencies (see
# https://eli.thegreenplace.net/2013/07/09/library-order-in-static-linking#circular-dependency)
gemoneyd_LDADD = \
  $(LIBGEMONEY_SERVER) \
  $(LIBGEMONEY_WALLET) \
  $(LIBGEMONEY_SERVER) \
  $(LIBGEMONEY_COMMON) \
  $(LIBUNIVALUE) \
  $(LIBGEMONEY_UTIL) \
  $(LIBGEMONEY_ZMQ) \
  $(LIBGEMONEY_CONSENSUS) \
  $(LIBGEMONEY_CRYPTO) \
  $(LIBLEVELDB) \
  $(LIBLEVELDB_SSE42) \
  $(LIBMEMENV) \
  $(LIBSECP256K1)

gemoneyd_LDADD += $(BOOST_LIBS) $(BDB_LIBS) $(CRYPTO_LIBS) $(MINIUPNPC_LIBS) $(EVENT_PTHREADS_LIBS) $(EVENT_LIBS) $(ZMQ_LIBS)

# gemoney-cli binary #
gemoney_cli_SOURCES = gemoney-cli.cpp
gemoney_cli_CPPFLAGS = $(AM_CPPFLAGS) $(GEMONEY_INCLUDES) $(EVENT_CFLAGS)
gemoney_cli_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
gemoney_cli_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
gemoney_cli_SOURCES += gemoney-cli-res.rc
endif

gemoney_cli_LDADD = \
  $(LIBGEMONEY_CLI) \
  $(LIBUNIVALUE) \
  $(LIBGEMONEY_UTIL) \
  $(LIBGEMONEY_CRYPTO)

gemoney_cli_LDADD += $(BOOST_LIBS) $(CRYPTO_LIBS) $(EVENT_LIBS)
#

# gemoney-tx binary #
gemoney_tx_SOURCES = gemoney-tx.cpp
gemoney_tx_CPPFLAGS = $(AM_CPPFLAGS) $(GEMONEY_INCLUDES)
gemoney_tx_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
gemoney_tx_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
gemoney_tx_SOURCES += gemoney-tx-res.rc
endif

gemoney_tx_LDADD = \
  $(LIBUNIVALUE) \
  $(LIBGEMONEY_COMMON) \
  $(LIBGEMONEY_UTIL) \
  $(LIBGEMONEY_CONSENSUS) \
  $(LIBGEMONEY_CRYPTO) \
  $(LIBSECP256K1)

gemoney_tx_LDADD += $(BOOST_LIBS) $(CRYPTO_LIBS)
#

# gemoney-wallet binary #
gemoney_wallet_SOURCES = gemoney-wallet.cpp
gemoney_wallet_CPPFLAGS = $(AM_CPPFLAGS) $(GEMONEY_INCLUDES)
gemoney_wallet_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
gemoney_wallet_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
gemoney_wallet_SOURCES += gemoney-wallet-res.rc
endif

gemoney_wallet_LDADD = \
  $(LIBGEMONEY_WALLET_TOOL) \
  $(LIBGEMONEY_WALLET) \
  $(LIBGEMONEY_COMMON) \
  $(LIBGEMONEY_CONSENSUS) \
  $(LIBGEMONEY_UTIL) \
  $(LIBGEMONEY_CRYPTO) \
  $(LIBGEMONEY_ZMQ) \
  $(LIBLEVELDB) \
  $(LIBLEVELDB_SSE42) \
  $(LIBMEMENV) \
  $(LIBSECP256K1) \
  $(LIBUNIVALUE)

gemoney_wallet_LDADD += $(BOOST_LIBS) $(BDB_LIBS) $(CRYPTO_LIBS) $(EVENT_PTHREADS_LIBS) $(EVENT_LIBS) $(MINIUPNPC_LIBS) $(ZMQ_LIBS)
#

# gemoneyconsensus library #
if BUILD_GEMONEY_LIBS
include_HEADERS = script/gemoneyconsensus.h
libgemoneyconsensus_la_SOURCES = $(crypto_libgemoney_crypto_base_a_SOURCES) $(libgemoney_consensus_a_SOURCES)

if GLIBC_BACK_COMPAT
  libgemoneyconsensus_la_SOURCES += compat/glibc_compat.cpp
endif

libgemoneyconsensus_la_LDFLAGS = $(AM_LDFLAGS) -no-undefined $(RELDFLAGS)
libgemoneyconsensus_la_LIBADD = $(LIBSECP256K1)
libgemoneyconsensus_la_CPPFLAGS = $(AM_CPPFLAGS) -I$(builddir)/obj -I$(srcdir)/secp256k1/include -DBUILD_GEMONEY_INTERNAL
libgemoneyconsensus_la_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)

endif
#

CTAES_DIST =  crypto/ctaes/bench.c
CTAES_DIST += crypto/ctaes/ctaes.c
CTAES_DIST += crypto/ctaes/ctaes.h
CTAES_DIST += crypto/ctaes/README.md
CTAES_DIST += crypto/ctaes/test.c

CLEANFILES = $(EXTRA_LIBRARIES)

CLEANFILES += *.gcda *.gcno
CLEANFILES += compat/*.gcda compat/*.gcno
CLEANFILES += consensus/*.gcda consensus/*.gcno
CLEANFILES += crypto/*.gcda crypto/*.gcno
CLEANFILES += policy/*.gcda policy/*.gcno
CLEANFILES += primitives/*.gcda primitives/*.gcno
CLEANFILES += script/*.gcda script/*.gcno
CLEANFILES += support/*.gcda support/*.gcno
CLEANFILES += univalue/*.gcda univalue/*.gcno
CLEANFILES += wallet/*.gcda wallet/*.gcno
CLEANFILES += wallet/test/*.gcda wallet/test/*.gcno
CLEANFILES += zmq/*.gcda zmq/*.gcno
CLEANFILES += obj/build.h

EXTRA_DIST = $(CTAES_DIST)


config/gemoney-config.h: config/stamp-h1
	@$(MAKE) -C $(top_builddir) $(subdir)/$(@)
config/stamp-h1: $(top_srcdir)/$(subdir)/config/gemoney-config.h.in $(top_builddir)/config.status
	$(AM_V_at)$(MAKE) -C $(top_builddir) $(subdir)/$(@)
$(top_srcdir)/$(subdir)/config/gemoney-config.h.in:  $(am__configure_deps)
	$(AM_V_at)$(MAKE) -C $(top_srcdir) $(subdir)/config/gemoney-config.h.in

clean-local:
	-$(MAKE) -C secp256k1 clean
	-$(MAKE) -C univalue clean
	-rm -f leveldb/*/*.gcda leveldb/*/*.gcno leveldb/helpers/memenv/*.gcda leveldb/helpers/memenv/*.gcno
	-rm -f config.h
	-rm -rf test/__pycache__

.rc.o:
	@test -f $(WINDRES)
	## FIXME: How to get the appropriate modulename_CPPFLAGS in here?
	$(AM_V_GEN) $(WINDRES) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(CPPFLAGS) -DWINDRES_PREPROC -i $< -o $@

check-symbols: $(bin_PROGRAMS)
if GLIBC_BACK_COMPAT
	@echo "Checking glibc back compat..."
	$(AM_V_at) READELF=$(READELF) CPPFILT=$(CPPFILT) $(PYTHON) $(top_srcdir)/contrib/devtools/symbol-check.py < $(bin_PROGRAMS)
endif

check-security: $(bin_PROGRAMS)
if HARDEN
	@echo "Checking binary security..."
	$(AM_V_at) READELF=$(READELF) OBJDUMP=$(OBJDUMP) $(PYTHON) $(top_srcdir)/contrib/devtools/security-check.py < $(bin_PROGRAMS)
endif

if ENABLE_BIP70
%.pb.cc %.pb.h: %.proto
	@test -f $(PROTOC)
	$(AM_V_GEN) $(PROTOC) --cpp_out=$(@D) --proto_path=$(<D) $<
endif

if EMBEDDED_LEVELDB
include Makefile.leveldb.include
endif

if ENABLE_TESTS
include Makefile.test.include
endif

if ENABLE_BENCH
include Makefile.bench.include
endif

if ENABLE_QT
include Makefile.qt.include
endif

if ENABLE_QT_TESTS
include Makefile.qttest.include
endif
