LightAttackInterval := 300
HeavyAttackInterval := 1600

Enabled := False
ActiveInterval := LightAttackInterval

/*
    Mouse Button 5
    Short press: toggle attack style (light or heavy)
    Long press: toggle auto-fire
*/
XButton2::
{
    Global Enabled
    Global ActiveInterval

    KeyWait "XButton2"
    If (A_TimeSinceThisHotkey <= 500)
    {
        If (ActiveInterval == LightAttackInterval)
        {
            ActiveInterval := HeavyAttackInterval
            SoundBeep 900, 300
        }
        Else
        {
            ActiveInterval := LightAttackInterval
            SoundBeep 900, 150
            SoundBeep 900, 150
        }
    }
    Else
    {
        Enabled := !Enabled
        MouseClick "left",,,,,"U" ; Ensure LButton isn't down
        If Enabled
            SoundBeep 600, 600
        Else
            SoundBeep 300, 600
    }
}

/*
    Auto-fire while LMB is held down
*/
~$LButton::
{
    If (Enabled)
    {
        Sleep 400
        While GetKeyState("LButton", "p")
        {
            If (ActiveInterval == LightAttackInterval)
            {
                Click
                Sleep ActiveInterval
            }
            Else
            {
                MouseClick "left",,,,,"D"
                Sleep ActiveInterval
                MouseClick "left",,,,,"U"
            }
        }
        Return
    }
}
