// This is the main DLL file.

#include "stdafx.h"
#include <string.h>
#include <msclr\lock.h>
#include "driver.h"
#include <avrdev.h>

#include "avrwrapper.h"

using namespace msclr;
using namespace System::Threading;
using namespace System::Collections;
using namespace System::Collections::Generic;
using namespace System::Linq;


namespace avrwrapper
{
    int AvrBitStream::VendorID::get()
    {
        return AVRDEV_VENDOR_ID;
    }

    int AvrBitStream::ProductID::get()
    {
        return AVRDEV_PROD_ID;
    }

    String^ AvrBitStream::VendorName::get()
    {
        return gcnew String(AVRDEV_VENDOR_NAME);
    }

    String^ AvrBitStream::ProductName::get()
    {
        return gcnew String(AVRDEV_PROD_NAME);
    }

    AvrBitStream^ AvrBitStream::Open()
    {
        void* handle = NULL;

        handle = usbOpenDevice( AVRDEV_VENDOR_ID,
                                AVRDEV_VENDOR_NAME,
                                AVRDEV_PROD_ID,
                                AVRDEV_PROD_NAME );
        if (handle == NULL)
        {
            throw gcnew Exception( gcnew String("Could not find USB device!") );
        }

        return gcnew AvrBitStream(handle);
    }

    AvrBitStream::AvrBitStream(void* handle)
        :   _active(true)
        ,   _pausing(true)
        ,   _paused(true)
        ,   _handle(handle)
    {
        _list = gcnew List<Boolean>();
        _worker = gcnew Thread( gcnew ThreadStart(this, &AvrBitStream::workThread) );
        _worker->Start();
    }

    AvrBitStream::~AvrBitStream()
    {
        this->!AvrBitStream();
    }

    AvrBitStream::!AvrBitStream()
    {
        _active = false;
        _worker->Join();
        //usbCloseHandle(_handle);
    }

    void AvrBitStream::SendPlayData(Generic::IEnumerable<Morse>^ msg)
    {
        int count = Enumerable::Count<Morse>(msg);
		int arrSize = (count + 7) / 4;
        char* arr = new char[arrSize];
        int i;
        for (i = 0; i < count - 3; i += 4)
        {
            char val = (int)Enumerable::ElementAt(msg, i) & 0x3;
            val <<= 2;
            val |= (int)Enumerable::ElementAt(msg, i + 1) & 0x3;
            val <<= 2;
            val |= (int)Enumerable::ElementAt(msg, i + 2) & 0x3;
            val <<= 2;
            val |= (int)Enumerable::ElementAt(msg, i + 3) & 0x3;
            arr[i / 4] = val;
        }
        arr[i / 4] = 0;
        for (; i < count; i++)
        {
            arr[i / 4] <<= 2;
            arr[i / 4] |= (int)Enumerable::ElementAt(msg, i) & 0x3;
        }
        for (; (i / 4) < arrSize - 1; i++)
        {
            arr[i / 4] <<= 2;
        }
        arr[arrSize - 1] = 0;

        usbControlMessageOut(_handle, USB_PLAY_DAT, arr, arrSize);
		delete[] arr;
    }

    void AvrBitStream::SendPlay(int len)
    {
        char buffer[256];
        usbControlMessageParam(_handle, USB_SEND_PLAY, len, (char *)buffer, sizeof(buffer));
    }

    void AvrBitStream::LetTalk(int timeout_s)
    {
        char buffer[256];
        usbControlMessageParam(_handle, USB_LET_TALK, timeout_s, (char *)buffer, sizeof(buffer));
    }

    void AvrBitStream::PauseListening(bool pause)
    {
        if (pause)
        {
            _pausing = true;
            while (!_paused) ;
        }
        else
        {
            _pausing = _paused = false;
        }
    }

    void AvrBitStream::SetDevice(AvrBitStream::Device dev)
    {
        char buffer[256];
        usbControlMessageParam(_handle, USB_SET_ADDR, (int)dev, (char *)buffer, sizeof(buffer));
    }

    List<Boolean>^ AvrBitStream::Peek()
    {
        lock l(_list);
        return gcnew List<Boolean>(_list);
    }

    List<Boolean>^ AvrBitStream::DequeueAll()
    {
        lock l(_list);
        List<Boolean>^ result = gcnew List<Boolean>(_list);
        _list->Clear();
        return result;
    }

    void AvrBitStream::workThread()
    {
        char buffer[256];
        while (_active)
        {
            Thread::Sleep(1000);
            if (_pausing)
                _paused = true;
            if (_paused)
                continue;

            int nBytes = usbControlMessage(_handle, USB_GET_BITS, (char *)buffer, sizeof(buffer));

            if(nBytes > 0)
            {
                array<Byte>^ arr = gcnew array<Byte>(nBytes);
                pin_ptr<Byte> dst = &arr[0];
                memcpy((void*)dst, (void*)buffer, nBytes);
                BitArray^ bits = gcnew BitArray(arr);
                
                {
                    lock l(_list);
                    _list->AddRange(Enumerable::Cast<Boolean>(bits));
                }

                this->NewData(this);
            }
        }

        usbCloseHandle(_handle);
        _handle = NULL;
    }

}
