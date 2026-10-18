#include "presetstore.h"

#include <QStandardPaths>
#include <QDir>
#include <QFile>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QVariantMap>
#include <QDebug>

PresetStore::PresetStore(QObject *parent)
    : QObject(parent)
{
    ensureAppDirs();
    loadUserPresets();
    loadFactoryPresets();
}

void PresetStore::ensureAppDirs()
{
    QString base = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    QDir dir(base);
    if (!dir.exists())
        dir.mkpath(".");
    m_userFilePath = dir.filePath("user_presets.json");
    m_factoryFilePath = dir.filePath("factory_presets.json");
}

void PresetStore::loadFactoryPresets()
{
    // Prefer embedded factory presets (resource) if available
    QFile resFile(":/qml/factory_presets.json");
    if (resFile.exists() && resFile.open(QIODevice::ReadOnly)) {
        const QByteArray data = resFile.readAll();
        QJsonDocument doc = QJsonDocument::fromJson(data);
        if (doc.isArray()) {
            m_factoryPresets = doc.array().toVariantList();
            resFile.close();
            return;
        }
        resFile.close();
    }

    // Fallback: try to load factory presets from writable app data location
    QFile f(m_factoryFilePath);
    if (f.open(QIODevice::ReadOnly)) {
        const QByteArray data = f.readAll();
        QJsonDocument doc = QJsonDocument::fromJson(data);
        if (doc.isArray()) {
            m_factoryPresets = doc.array().toVariantList();
        }
        f.close();
        return;
    }

    // If nothing found, leave factory presets empty
    m_factoryPresets = {};
}

void PresetStore::loadUserPresets()
{
    QFile f(m_userFilePath);
    if (f.open(QIODevice::ReadOnly)) {
        const QByteArray data = f.readAll();
        QJsonDocument doc = QJsonDocument::fromJson(data);
        if (doc.isArray()) {
            m_userPresets = doc.array().toVariantList();
        }
        f.close();
    } else {
        m_userPresets = {};
    }
}

QVariantList PresetStore::presets() const
{
    QVariantList all = m_factoryPresets;
    all += m_userPresets;
    return all;
}

QVariantList PresetStore::factoryPresets() const { return m_factoryPresets; }
QVariantList PresetStore::userPresets() const { return m_userPresets; }

QVariantMap PresetStore::getPreset(int index) const
{
    QVariantList all = presets();
    if (index < 0 || index >= all.size()) return {};
    return all.at(index).toMap();
}

bool PresetStore::saveUserPreset(const QVariantMap &preset, bool overwrite, int overwriteIndex)
{
    if (overwrite && overwriteIndex >= 0 && overwriteIndex < m_userPresets.size()) {
        m_userPresets[overwriteIndex] = preset;
    } else {
        m_userPresets.append(preset);
    }
    persistUserPresets();
    emit presetsChanged();
    return true;
}

void PresetStore::persistUserPresets()
{
    QJsonArray arr;
    for (const QVariant &v : m_userPresets) arr.append(QJsonObject::fromVariantMap(v.toMap()));
    QFile f(m_userFilePath);
    if (f.open(QIODevice::WriteOnly)) {
        f.write(QJsonDocument(arr).toJson(QJsonDocument::Indented));
        f.close();
    }
}
