^!g::
InputBox, SearchKey, Enter Password, (search key)
splitText := StrSplit(SearchKey, A_Space)
maxIndex := splitText.MaxIndex()
if ErrorLevel
    MsgBox, CANCEL was pressed.
else
    Run https://www.google.com/search?q=%SearchKey%,
return

^!t::
Sleep, 100
Send !r
Sleep, 300
Send l
Sleep, 300
Send s
;CoordMode, Mouse, Screen
;MouseGetPos , OutputVarX, OutputVarY
Sleep, 2000
MouseClick, left, 1207, 364
Send {Tab}
Send {Tab}
Send {Tab}
Send {Tab}
Send {Tab}
Send {Tab}
Send {enter}
;MouseMove, OutputVarX, OutputVarY, 50
return

^!n::  ; Ctrl+Alt+N
if WinExist("Untitled - Notepad")
    WinActivate
else
    Run "Notepad"
return

^+c::
; null= 
send ^c
sleep,200
clipboard=%clipboard% ;%null%
tooltip,%clipboard%
sleep,500
tooltip,
return

^+v::
myClipboard := clipboard
sendinput %clipboard%
return

^#c::
MouseGetPos, mouseX, mouseY
; �������������꣬������ X ���긳ֵ������ mouseX ��ͬ�� mouseY
PixelGetColor, color, %mouseX%, %mouseY%, RGB
; ���� PixelGetColor ��������������������� RGB ֵ������ֵ�� color
StringRight color,color,6
; ��ȡ color���ڶ��� color���ұߵ�6���ַ�����Ϊ��õ�ֵ�������ģ�#RRGGBB��һ������ֻ��Ҫ RRGGBB ���֡��ѽ�ȡ����ֵ�ٸ��� color����һ�� color����
clipboard = %color%
; �� color ��ֵ���͵�������
tooltip, %clipboard%
sleep,500
tooltip,
return