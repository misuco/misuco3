// /^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\v/^\
// Copyright (C) 2026 c1audio.com / Claudio Zopfi <c1audio@x21.ch>
// SPDX-License-Identifier: GPL-3.0

package org.misuco.misuco3;

import android.content.Context;
import android.net.nsd.NsdManager;
import android.net.nsd.NsdServiceInfo;
import android.net.wifi.WifiManager;
import android.util.Log;

// Announces a DNS-SD (Bonjour) service with the system service discovery,
// used by BonjourAnnouncer (misulib/comm/bonjourannouncer.cpp), and the
// multicast lock for the mDNS search.
public class NsdAnnouncer {
    private static final String TAG = "NsdAnnouncer";
    private static NsdManager manager;
    private static NsdManager.RegistrationListener listener;

    public static synchronized boolean register(Context context, String name, String type, int port) {
        unregister();
        try {
            manager = (NsdManager) context.getSystemService(Context.NSD_SERVICE);
            if (manager == null) {
                return false;
            }
            NsdServiceInfo info = new NsdServiceInfo();
            info.setServiceName(name);
            info.setServiceType(type);
            info.setPort(port);

            listener = new NsdManager.RegistrationListener() {
                @Override
                public void onServiceRegistered(NsdServiceInfo info) {
                    // the name can be changed by the system to be unique
                    Log.i(TAG, "registered " + info.getServiceName());
                }

                @Override
                public void onRegistrationFailed(NsdServiceInfo info, int errorCode) {
                    Log.w(TAG, "registration failed " + errorCode);
                }

                @Override
                public void onServiceUnregistered(NsdServiceInfo info) {
                    Log.i(TAG, "unregistered");
                }

                @Override
                public void onUnregistrationFailed(NsdServiceInfo info, int errorCode) {
                    Log.w(TAG, "unregistration failed " + errorCode);
                }
            };
            manager.registerService(info, NsdManager.PROTOCOL_DNS_SD, listener);
            return true;
        } catch (Exception e) {
            Log.w(TAG, "register", e);
            listener = null;
            return false;
        }
    }

    // android drops multicast packets unless a multicast lock is held,
    // used by the mDNS search (misulib/comm/mdnsbrowser.cpp)
    private static WifiManager.MulticastLock multicastLock;

    public static synchronized void acquireMulticastLock(Context context) {
        try {
            if (multicastLock == null) {
                WifiManager wifi = (WifiManager) context.getApplicationContext().getSystemService(Context.WIFI_SERVICE);
                if (wifi == null) {
                    return;
                }
                multicastLock = wifi.createMulticastLock("misuco3-mdns");
                multicastLock.setReferenceCounted(false);
            }
            multicastLock.acquire();
        } catch (Exception e) {
            Log.w(TAG, "acquireMulticastLock", e);
        }
    }

    public static synchronized void releaseMulticastLock() {
        try {
            if (multicastLock != null && multicastLock.isHeld()) {
                multicastLock.release();
            }
        } catch (Exception e) {
            Log.w(TAG, "releaseMulticastLock", e);
        }
    }

    public static synchronized void unregister() {
        if (manager != null && listener != null) {
            try {
                manager.unregisterService(listener);
            } catch (Exception e) {
                Log.w(TAG, "unregister", e);
            }
        }
        listener = null;
    }
}
