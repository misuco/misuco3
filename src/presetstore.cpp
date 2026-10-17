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
    QFile f(m_factoryFilePath);
    if (!f.exists()) {
        // generate 100 simple factory presets
        QVariantList presets;
        for (int i = 0; i < 100; ++i) {
            QVariantMap p;
            p["name"] = QString("Factory %1").arg(i+1);

            QVariantMap osc1;
            osc1["level"] = 0.6;
            osc1["wave_type"] = i % 5;
            osc1["octave"] = i % 5;
            p["osc1"] = osc1;

            QVariantMap osc2;
            osc2["level"] = 0.4;
            osc2["shift"] = (i % 7) - 3;
            osc2["wave_type"] = (i + 2) % 5;
            osc2["octave"] = (4 - (i % 5));
            p["osc2"] = osc2;

            QVariantMap volEnv;
            volEnv["attack"] = 10 + (i * 50 % 8000);
            volEnv["decay"] = 100 + (i * 30 % 10000);
            volEnv["sustain"] = 0.2 + ((i % 5) / 10.0);
            volEnv["release"] = 200 + (i * 40 % 12000);
            p["volume_envelope"] = volEnv;

            QVariantMap filtEnv = volEnv;
            filtEnv["sustain"] = 0.5;
            p["filter_envelope"] = filtEnv;

            p["filter_cutoff"] = (i % 100) / 100.0;
            p["filter_resonance"] = ((i * 7) % 100) / 100.0;

            p["mod_amount"] = 0.5;
            p["mod_freq"] = 0.5 + (i % 5) * 0.2;

            presets.append(p);
        }

        // persist
        QJsonArray arr;
        for (const QVariant &v : presets) {
            arr.append(QJsonObject::fromVariantMap(v.toMap()));
        }
        QFile out(m_factoryFilePath);
        if (out.open(QIODevice::WriteOnly)) {
            out.write(QJsonDocument(arr).toJson(QJsonDocument::Indented));
            out.close();
        }
        m_factoryPresets = presets;
    } else {
        if (f.open(QIODevice::ReadOnly)) {
            const QByteArray data = f.readAll();
            QJsonDocument doc = QJsonDocument::fromJson(data);
            if (doc.isArray()) {
                m_factoryPresets = doc.array().toVariantList();
            }
            f.close();
        }
    }
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
