#include "tuningstore.h"

#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QSettings>
#include <algorithm>

namespace {

const QString UserKey = QStringLiteral("tuning/user");
const QString CurrentKey = QStringLiteral("tuning/current");

// twelve values from -100 to 100
QVariantList cleanCents(const QVariantList &cents)
{
    QVariantList out;
    for(int i = 0; i < 12; i++) {
        int c = i < cents.size() ? qRound(cents[i].toDouble()) : 0;
        out.append(std::clamp(c, -100, 100));
    }
    return out;
}

QJsonObject toJson(const QString &name, const QVariantList &cents)
{
    QJsonObject o;
    o.insert(QStringLiteral("name"), name);
    o.insert(QStringLiteral("cents"), QJsonArray::fromVariantList(cleanCents(cents)));
    return o;
}

QVariantMap fromJson(const QJsonObject &o)
{
    QVariantMap m;
    m.insert(QStringLiteral("name"), o.value(QStringLiteral("name")).toString());
    m.insert(QStringLiteral("cents"), cleanCents(o.value(QStringLiteral("cents")).toArray().toVariantList()));
    return m;
}

}

TuningStore::TuningStore(QObject *parent) : QObject(parent)
{
    load();
}

QVariantList TuningStore::userTunings() const
{
    return m_userTunings;
}

void TuningStore::saveTuning(const QString &name, const QVariantList &cents)
{
    const QString n = name.trimmed();
    if(n.isEmpty()) {
        return;
    }
    QVariantMap tuning;
    tuning.insert(QStringLiteral("name"), n);
    tuning.insert(QStringLiteral("cents"), cleanCents(cents));

    bool replaced = false;
    for(QVariant &t : m_userTunings) {
        if(t.toMap().value(QStringLiteral("name")).toString() == n) {
            t = tuning;
            replaced = true;
            break;
        }
    }
    if(!replaced) {
        m_userTunings.append(tuning);
    }
    persist();
    emit userTuningsChanged();
}

void TuningStore::deleteTuning(const QString &name)
{
    for(int i = 0; i < m_userTunings.size(); i++) {
        if(m_userTunings[i].toMap().value(QStringLiteral("name")).toString() == name) {
            m_userTunings.removeAt(i);
            persist();
            emit userTuningsChanged();
            return;
        }
    }
}

QVariantMap TuningStore::current() const
{
    QSettings s(QStringLiteral("misuco"), QStringLiteral("misuco3"));
    const QJsonDocument d = QJsonDocument::fromJson(s.value(CurrentKey).toString().toUtf8());
    if(!d.isObject()) {
        return QVariantMap();
    }
    return fromJson(d.object());
}

void TuningStore::setCurrent(const QString &name, const QVariantList &cents)
{
    QSettings s(QStringLiteral("misuco"), QStringLiteral("misuco3"));
    s.setValue(CurrentKey, QString::fromUtf8(QJsonDocument(toJson(name, cents)).toJson(QJsonDocument::Compact)));
}

void TuningStore::load()
{
    QSettings s(QStringLiteral("misuco"), QStringLiteral("misuco3"));
    const QJsonDocument d = QJsonDocument::fromJson(s.value(UserKey).toString().toUtf8());
    m_userTunings.clear();
    const QJsonArray a = d.array();
    for(const QJsonValue &v : a) {
        QVariantMap m = fromJson(v.toObject());
        if(!m.value(QStringLiteral("name")).toString().isEmpty()) {
            m_userTunings.append(m);
        }
    }
}

void TuningStore::persist()
{
    QJsonArray a;
    for(const QVariant &t : std::as_const(m_userTunings)) {
        const QVariantMap m = t.toMap();
        a.append(toJson(m.value(QStringLiteral("name")).toString(), m.value(QStringLiteral("cents")).toList()));
    }
    QSettings s(QStringLiteral("misuco"), QStringLiteral("misuco3"));
    s.setValue(UserKey, QString::fromUtf8(QJsonDocument(a).toJson(QJsonDocument::Compact)));
}
