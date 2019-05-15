#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

GEMONEYD=${GEMONEYD:-$BINDIR/gemoneyd}
GEMONEYCLI=${GEMONEYCLI:-$BINDIR/gemoney-cli}
GEMONEYTX=${GEMONEYTX:-$BINDIR/gemoney-tx}
WALLET_TOOL=${WALLET_TOOL:-$BINDIR/gemoney-wallet}
GEMONEYQT=${GEMONEYQT:-$BINDIR/qt/gemoney-qt}

[ ! -x $GEMONEYD ] && echo "$GEMONEYD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
BTCVER=($($GEMONEYCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for gemoneyd if --version-string is not set,
# but has different outcomes for gemoney-qt and gemoney-cli.
echo "[COPYRIGHT]" > footer.h2m
$GEMONEYD --version | sed -n '1!p' >> footer.h2m

for cmd in $GEMONEYD $GEMONEYCLI $GEMONEYTX $WALLET_TOOL $GEMONEYQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${BTCVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${BTCVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
