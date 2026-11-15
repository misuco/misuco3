#pragma once

#include <QObject>
#include <QString>
#include <QVariantList>
#include <QVariantMap>

// Keeps named lists of numbers of the user in the settings of the app,
// and the list that is in use. It stores the tunings (the deviation of
// the notes C to B in cent) and the scales (the steps that are played).
class ListStore : public QObject {
    Q_OBJECT
public:
    // group: the settings group, valueKey: the name of the list in the
    // stored entry, count: the length of a list, min and max: the range
    // of a value
    ListStore(const QString &group, const QString &valueKey, int count, int min, int max,
              QObject *parent = nullptr);

    // list of {name, values}
    Q_INVOKABLE QVariantList userEntries() const;
    // an entry with the same name is replaced
    Q_INVOKABLE void save(const QString &name, const QVariantList &values);
    Q_INVOKABLE void remove(const QString &name);

    // {name, values} of the list in use, the name is empty if it has not
    // been saved. An empty map if there is none.
    Q_INVOKABLE QVariantMap current() const;
    Q_INVOKABLE void setCurrent(const QString &name, const QVariantList &values);

signals:
    void userEntriesChanged();

private:
    const QString m_userKey;
    const QString m_currentKey;
    const QString m_valueKey;
    const int m_count;
    const int m_min;
    const int m_max;

    QVariantList m_userEntries;

    QVariantList clean(const QVariantList &values) const;
    void load();
    void persist();
};
