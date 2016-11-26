#pragma once

const char* usbGetLastError();

int usbGetDescriptorString( void* dev,
                            int index,
                            int langid,
                            char* buf,
                            int buflen );

void* usbOpenDevice(int vendor,
                    char* vendorName,
                    int product,
                    char* productName );

int usbControlMessage(  void* dev,
                        int msg,
                        char* buffer,
                        int buflen );

int usbControlMessageParam( void* dev,
                            int msg,
                            int param,
                            char* buffer,
                            int buflen );

int usbControlMessageOut(   void* dev,
                            int msg,
                            char* buffer,
                            int buflen );

void usbCloseHandle( void* dev );
