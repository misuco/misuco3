#pragma once

#include <QObject>
#include <QVariantList>

class PresetStore : public QObject {
    Q_OBJECT
public:
    explicit PresetStore(QObject *parent = nullptr);

    Q_INVOKABLE QVariantList presets() const;
    Q_INVOKABLE QVariantList factoryPresets() const;
    Q_INVOKABLE QVariantList userPresets() const;
    Q_INVOKABLE QVariantMap getPreset(int index) const;
    Q_INVOKABLE bool saveUserPreset(const QVariantMap &preset, bool overwrite, int overwriteIndex);

signals:
    void presetsChanged();

private:
    void ensureAppDirs();
    void loadFactoryPresets();
    void loadUserPresets();
    void persistUserPresets();

    QVariantList m_factoryPresets;
    QVariantList m_userPresets;
    QString m_userFilePath;
    QString m_factoryFilePath;
};
