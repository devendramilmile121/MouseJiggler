using System.Runtime.InteropServices;

class MouseJiggler
{
    // Import Windows API functions
    [DllImport("user32.dll")]
    static extern void keybd_event(byte bVk, byte bScan, uint dwFlags, UIntPtr dwExtraInfo);

    [DllImport("user32.dll")]
    static extern bool GetLastInputInfo(ref LASTINPUTINFO plii);

    [StructLayout(LayoutKind.Sequential)]
    public struct LASTINPUTINFO
    {
        public uint cbSize;
        public uint dwTime;
    }

    // Virtual key codes
    const byte VK_SHIFT = 0x10;
    const byte VK_SCROLL = 0x91; // Scroll Lock (non-intrusive)
    const uint KEYEVENTF_KEYDOWN = 0x0000;
    const uint KEYEVENTF_KEYUP = 0x0002;

    static Random random = new Random();

    static void Main(string[] args)
    {
        Console.WriteLine("Smart Activity Keeper started. Press Ctrl+C to stop.");
        Console.WriteLine("Simulates non-intrusive activity when idle...\n");

        int idleThresholdSeconds = 60; // Start activity after 60 seconds of idle
        int checkIntervalSeconds = 15; // Check every 15 seconds

        while (true)
        {
            try
            {
                int idleTime = GetIdleTimeInSeconds();
                
                if (idleTime >= idleThresholdSeconds)
                {
                    // Simulate non-intrusive key press (Scroll Lock toggle)
                    // This won't affect any applications but registers as activity
                    SimulateKeyPress(VK_SCROLL);
                    
                    Thread.Sleep(random.Next(50, 150));
                    
                    // Occasionally add a Shift key press (also non-intrusive)
                    if (random.Next(0, 3) == 0)
                    {
                        SimulateKeyPress(VK_SHIFT);
                    }

                    Console.WriteLine($"[{DateTime.Now:HH:mm:ss}] Activity simulated (idle: {idleTime}s)");
                }
                else
                {
                    Console.WriteLine($"[{DateTime.Now:HH:mm:ss}] User active (idle: {idleTime}s)");
                }

                // Random interval to appear more natural
                int waitTime = checkIntervalSeconds + random.Next(-3, 4);
                Thread.Sleep(waitTime * 1000);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex.Message}");
                Thread.Sleep(5000);
            }
        }
    }

    static void SimulateKeyPress(byte keyCode)
    {
        // Key down
        keybd_event(keyCode, 0, KEYEVENTF_KEYDOWN, UIntPtr.Zero);
        Thread.Sleep(random.Next(20, 60));
        // Key up
        keybd_event(keyCode, 0, KEYEVENTF_KEYUP, UIntPtr.Zero);
    }

    static int GetIdleTimeInSeconds()
    {
        LASTINPUTINFO lastInputInfo = new LASTINPUTINFO();
        lastInputInfo.cbSize = (uint)Marshal.SizeOf(lastInputInfo);
        
        if (GetLastInputInfo(ref lastInputInfo))
        {
            uint idleTime = (uint)Environment.TickCount - lastInputInfo.dwTime;
            return (int)(idleTime / 1000);
        }
        
        return 0;
    }
}