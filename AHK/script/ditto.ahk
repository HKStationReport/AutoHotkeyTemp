;-----------------------------

;

;   Juan Zepeda's AHK Ditto

;

;-----------------------------



; Script Instance Global Variables

tempCopy1 =

tempCopy2 =

tempCopy3 =

tempCopy4 =

tempCopy5 =



; Control + ` is pressed. Brings up clipboard selection window

^`::

	;Menu, tray, Icon , dup1.ico, 1, 1

	Gui, +AlwaysOnTop

	Gui, Add, Text,, What text would you like to paste?

	Gui, Add, ListBox, vMyListBox gMyListBox w250 r6

	; add to list

	GuiControl,, MyListBox, %tempCopy1%

	GuiControl,, MyListBox, %tempCopy2%

	GuiControl,, MyListBox, %tempCopy3%

	GuiControl,, MyListBox, %tempCopy4%

	GuiControl,, MyListBox, %tempCopy5%

	;Show window

	Gui, Show, , Juans Zepeda's AHK Ditto

	return

	

	; If Enter is pressed while selecting a item in list

	#IfWinActive, Juans Zepeda's AHK Ditto

		Enter::

			Gosub ButtonOK

			return



MyListBox:

	if A_GuiEvent <> DoubleClick

		return

		; Otherwise, the user double-clicked a list item, so treat that the same as pressing OK.

		; So fall through to the next label.

	ButtonOK:

		GuiControlGet, MyListBox	; Retrieve the ListBox's current selection.

		clipboard = %MyListBox%		; Copy selected item to clipboard

		ClipWait					;Wait for the clipboard to contain text.

		Gui Destroy

		Send ^v ; Send a paste event

		return



	; If User presses Esc or Closes the window

	GuiClose:

	GuiEscape:

		Gui, Destroy

		return



#Persistent

return



;Gets called when clipboard event happens

OnClipboardChange:



if (A_EventInfo = 0)	;Clipboard is empty

{	

	ToolTip Clipboard data type 0: %clipboard%

	Sleep 1000

	ToolTip  						; Turn off the tip.

}

else if (A_EventInfo = 1)			;Clipboard contents can be expressed as text 

{	

	;Save Contents of clipboard in vars, size 5

	;TODO move to a array?

	tempCopy5 = %tempCopy4%

	tempCopy4 = %tempCopy3%

	tempCopy3 = %tempCopy2%

	tempCopy2 = %tempCopy1%

	tempCopy1 = %clipboard%

	

}

else if (A_EventInfo = 2)			;Clipboard contents can be expressed as non text 

{	

	ToolTip Clipboard data type 2: %clipboard%

	Sleep 1000

	ToolTip  ; Turn off the tip.

}

else

{

	ToolTip Clipboard data type %A_EventInfo%: %clipboard%

	Sleep 1000

	ToolTip  ; Turn off the tip.

	return

}

return