#include "liststore.h"

#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QSettings>
#include <algorithm>

namespace {

const QString NameKey = QStringLiteral("name");
const QString ValuesKey = QStringLiteral("values");

}

ListStore::ListStore(const QString &group, const QString &valueKey, int count, int min, int max, QObject *parent)
    : QObject(parent),
      m_userKey(group + QStringLiteral("/user")),
      m_currentKey(group + QStringLiteral("/current")),
      m_valueKey(valueKey),
      m_count(count),
      m_min(min),
      m_max(max)
{
    load();
}

// a list of the right length with values in the range
QVariantList ListStore::clean(const QVariantList &values) const
{
    QVariantList out;
    for(int i = 0; i < m_count; i++) {
        int v = i < values.size() ? qRound(values[i].toDouble()) : 0;
        out.append(std::clamp(v, m_min, m_max));
    }
    return out;
}

QVariantList ListStore::userEntries() const
{
    return m_userEntries;
}

void ListStore::save(const QString &name, const QVariantList &values)
{
    const QString n = name.trimmed();
    if(n.isEmpty()) {
        return;
    }
    QVariantMap entry;
    entry.insert(NameKey, n);
    entry.insert(ValuesKey, clean(values));

    bool replaced = false;
    for(QVariant &e : m_userEntries) {
        if(e.toMap().value(NameKey).toString() == n) {
            e = entry;
            replaced = true;
            break;
        }
    }
    if(!replaced) {
        m_userEntries.append(entry);
    }
    persist();
    emit userEntriesChanged();
}

void ListStore::remove(const QString &name)
{
    for(int i = 0; i < m_userEntries.size(); i++) {
        if(m_userEntries[i].toMap().value(NameKey).toString() == name) {
            m_userEntries.removeAt(i);
            persist();
            emit userEntriesChanged();
            return;
        }
    }
}

QVariantMap ListStore::current() const
{
    QSettings s(QStringLiteral("misuco"), QStringLiteral("misuco3"));
    const QJsonDocument d = QJsonDocument::fromJson(s.value(m_currentKey).toString().toUtf8());
    if(!d.isObject()) {
        return QVariantMap();
    }
    QVariantMap m;
    m.insert(NameKey, d.object().value(NameKey).toString());
    m.insert(ValuesKey, clean(d.object().value(m_valueKey).toArray().toVariantList()));
    return m;
}

void ListStore::setCurrent(const QString &name, const QVariantList &values)
{
    QJsonObject o;
    o.insert(NameKey, name);
    o.insert(m_valueKey, QJsonArray::fromVariantList(clean(values)));
    QSettings s(QStringLiteral("misuco"), QStringLiteral("misuco3"));
    s.setValue(m_currentKey, QString::fromUtf8(QJsonDocument(o).toJson(QJsonDocument::Compact)));
}

void ListStore::load()
{
    QSettings s(QStringLiteral("misuco"), QStringLiteral("misuco3"));
    const QJsonDocument d = QJsonDocument::fromJson(s.value(m_userKey).toString().toUtf8());
    m_userEntries.clear();
    const QJsonArray a = d.array();
    for(const QJsonValue &v : a) {
        const QJsonObject o = v.toObject();
        const QString name = o.value(NameKey).toString();
        if(name.isEmpty()) {
            continue;
        }
        QVariantMap m;
        m.insert(NameKey, name);
        m.insert(ValuesKey, clean(o.value(m_valueKey).toArray().toVariantList()));
        m_userEntries.append(m);
    }
}

void ListStore::persist()
{
    QJsonArray a;
    for(const QVariant &e : std::as_const(m_userEntries)) {
        const QVariantMap m = e.toMap();
        QJsonObject o;
        o.insert(NameKey, m.value(NameKey).toString());
        o.insert(m_valueKey, QJsonArray::fromVariantList(m.value(ValuesKey).toList()));
        a.append(o);
    }
    QSettings s(QStringLiteral("misuco"), QStringLiteral("misuco3"));
    s.setValue(m_userKey, QString::fromUtf8(QJsonDocument(a).toJson(QJsonDocument::Compact)));
}
