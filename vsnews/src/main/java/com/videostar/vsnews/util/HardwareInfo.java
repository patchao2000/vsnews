package com.videostar.vsnews.util;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.util.Enumeration;

/**
 * HardwareInfo
 *
 * Created by zhaopeng on 2014/11/25.
 */
public class HardwareInfo
{
    public static String getMacAddr()
    {
        String macAddr = "";
        InetAddress addr;
        try {
            addr = InetAddress.getLocalHost();
            NetworkInterface dir = NetworkInterface.getByInetAddress(addr);
            byte[] dirMac = dir.getHardwareAddress();

            int count = 0;
            for (int b : dirMac) {
                if (b < 0)
                    b = 256 + b;
                if (b == 0) {
                    macAddr = macAddr.concat("00");
                }
                if (b > 0) {

                    int a = b / 16;
                    if (a == 10)
                        macAddr = macAddr.concat("A");
                    else if (a == 11)
                        macAddr = macAddr.concat("B");
                    else if (a == 12)
                        macAddr = macAddr.concat("C");
                    else if (a == 13)
                        macAddr = macAddr.concat("D");
                    else if (a == 14)
                        macAddr = macAddr.concat("E");
                    else if (a == 15)
                        macAddr = macAddr.concat("F");
                    else
                        macAddr = macAddr.concat(String.valueOf(a));
                    a = (b % 16);
                    if (a == 10)
                        macAddr = macAddr.concat("A");
                    else if (a == 11)
                        macAddr = macAddr.concat("B");
                    else if (a == 12)
                        macAddr = macAddr.concat("C");
                    else if (a == 13)
                        macAddr = macAddr.concat("D");
                    else if (a == 14)
                        macAddr = macAddr.concat("E");
                    else if (a == 15)
                        macAddr = macAddr.concat("F");
                    else
                        macAddr = macAddr.concat(String.valueOf(a));
                }
                if (count < dirMac.length - 1)
                    macAddr = macAddr.concat(":");
                count++;
            }

        } catch (Exception e) {
            macAddr = e.getMessage();
        }
//    } catch (UnknownHostException e) {
//        macAddr = e.getMessage();
//    } catch (SocketException e) {
//        macAddr = e.getMessage();
//    }
        return macAddr.toUpperCase();
    }

//    public static boolean checkMacAddr(String macMd5)
//    {
//        String macAddr = "";
//        try {
//            Enumeration<NetworkInterface> nwInterface = NetworkInterface.getNetworkInterfaces();
//            while (nwInterface.hasMoreElements()) {
//                NetworkInterface nis = nwInterface.nextElement();
//                if (nis != null) {
//                    macAddr = "";
//                    byte[] dirMac = nis.getHardwareAddress();
//                    int count = 0;
//                    for (int b : dirMac)
//                    {
//                        if (b < 0)
//                            b = 256 + b;
//                        if (b == 0) {
//                            macAddr = macAddr.concat("00");
//                        }
//                        if (b > 0) {
//
//                            int a = b / 16;
//                            if (a == 10)
//                                macAddr = macAddr.concat("A");
//                            else if (a == 11)
//                                macAddr = macAddr.concat("B");
//                            else if (a == 12)
//                                macAddr = macAddr.concat("C");
//                            else if (a == 13)
//                                macAddr = macAddr.concat("D");
//                            else if (a == 14)
//                                macAddr = macAddr.concat("E");
//                            else if (a == 15)
//                                macAddr = macAddr.concat("F");
//                            else
//                                macAddr = macAddr.concat(String.valueOf(a));
//                            a = (b % 16);
//                            if (a == 10)
//                                macAddr = macAddr.concat("A");
//                            else if (a == 11)
//                                macAddr = macAddr.concat("B");
//                            else if (a == 12)
//                                macAddr = macAddr.concat("C");
//                            else if (a == 13)
//                                macAddr = macAddr.concat("D");
//                            else if (a == 14)
//                                macAddr = macAddr.concat("E");
//                            else if (a == 15)
//                                macAddr = macAddr.concat("F");
//                            else
//                                macAddr = macAddr.concat(String.valueOf(a));
//                        }
//                        if (count < dirMac.length - 1)
//                            macAddr = macAddr.concat(":");
//                        count++;
//                    }
//
//                    System.out.println(String.format("Checking mac: %s", macAddr));
//
//                    if (Md5Encrypt.md5(macAddr.toUpperCase()).equals(macMd5))
//                        return true;
//                }
//            }
//
//        } catch (Exception e) {
//            macAddr = e.getMessage();
//        }
//        return false;
//    }

    public static boolean checkMacAddr(String macMd5)
    {
        try {
            if (Md5Encrypt.md5(getMacAddr()).equals(macMd5))
                return true;
        }
        catch (Exception e) {
            return false;
        }
        return false;
    }
}