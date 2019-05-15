// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef GEMONEY_QT_GEMONEYADDRESSVALIDATOR_H
#define GEMONEY_QT_GEMONEYADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class GemoneyAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit GemoneyAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** Gemoney address widget validator, checks for a valid gemoney address.
 */
class GemoneyAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit GemoneyAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // GEMONEY_QT_GEMONEYADDRESSVALIDATOR_H
