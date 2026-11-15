#pragma once

#include <QObject>
#include <QString>
#include <QVariantList>
#include <QVariantMap>

// Keeps the tunings of the user and the tuning that is in use in the
// settings of the app. A tuning is a name and the deviation of the notes
// C to B from the equal temperament in cent.
class TuningStore : public QObject {
    Q_OBJECT
public:
    explicit TuningStore(QObject *parent = nullptr);

    // list of {name, cents}
    Q_INVOKABLE QVariantList userTunings() const;
    // a tuning with the same name is replaced
    Q_INVOKABLE void saveTuning(const QString &name, const QVariantList &cents);
    Q_INVOKABLE void deleteTuning(const QString &name);

    // {name, cents} of the tuning in use, the name is empty if it has not
    // been saved. An empty map if there is none.
    Q_INVOKABLE QVariantMap current() const;
    Q_INVOKABLE void setCurrent(const QString &name, const QVariantList &cents);

signals:
    void userTuningsChanged();

private:
    QVariantList m_userTunings;

    void load();
    void persist();
};
