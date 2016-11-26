// avrwrapper.h

#pragma once

#include "..\avrdev\addresses.h"

using namespace System;


namespace avrwrapper {

	public ref class AvrBitStream
	{
    private:
        bool _active;
        bool _pausing;
        bool _paused;
        void* _handle;
        Threading::Thread^ _worker;
        Collections::Generic::List<Boolean>^ _list;

        AvrBitStream(void* handle);

        void workThread();

    public:
        static property int VendorID { int get(); }
        static property int ProductID { int get(); }
        static property String^ VendorName { String^ get(); }
        static property String^ ProductName { String^ get(); }
        static AvrBitStream^ Open();

        ~AvrBitStream();
        !AvrBitStream();

        enum class Morse
        {
            WBK = 0,
            CBK = 1,
            DIT = 2,
            DAH = 3
        };

        enum class Device
        {
            C = RC,
            B = RB
        };

        void SendPlayData(Collections::Generic::IEnumerable<Morse>^ msg);
        void SendPlay(int len);
        void LetTalk(int timeout_s);
        void PauseListening(bool pause);
        void SetDevice(Device dev);
        
        Collections::Generic::List<Boolean>^ Peek();
        Collections::Generic::List<Boolean>^ DequeueAll();

        delegate void NewDataEvent(AvrBitStream^ stream);
        event NewDataEvent^ NewData;
	};
}
