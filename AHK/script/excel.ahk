; DOMʾ��.ahk

; DOM �ĵ�:
; 	http://www.w3school.com.cn/xmldom/xmldom_reference.asp
; 	http://www.w3schools.com/jsref/dom_obj_all.asp
; 	http://www.w3school.com.cn/htmldom/htmldom_reference.asp

#NoEnv
#SingleInstance Force
SetBatchLines -1
ListLines Off
ComObjError(False)

; =================================
;		����
; =================================
Gui, Margin, 0, 0
Gui Add, ActiveX, w800 h500 vWB, Shell.Explorer
Gui, Show

; =================================
;		����ҳ�����ȴ��������
; =================================
OpenLoginPage:
WB.Navigate("http://ahkscript.org/boards/ucp.php?mode=login")
While WB.readystate != 4 or WB.busy
	Sleep 10

; ����Ѿ���¼���˳�
if !InStr(WB.LocationUrl, "login")
{
	Gui, +OwnDialogs
	MsgBox, 36, ȷ���˳���¼, �ű���Ҫ�˳���̳�ĵ�¼���Ƿ���������Ϊ�˽ű����ڵ�¼ҳ�������ʾ�ģ�
	IfMsgBox, No
	{
		MsgBox, �ðɡ����ֹ��˳���¼�������д˽ű����ټ���
		ExitApp
	}

	; �˳���¼
	WB.document.getElementById("menubar").all.tags("a")[0].Click()
	While WB.readystate != 4 or WB.busy
		Sleep 10

	Goto, OpenLoginPage
}

; =================================
;		�޸���ҳ
; =================================
doc := WB.doc
doc.getElementById("username").Disabled := True ; ���á��û��������
doc.getElementById("password").Disabled := True ; ���á����������
doc.getElementById("username").style.backgroundColor := "A0FABF" ; �޸ġ��û�������򡿱���ɫ
doc.getElementById("password").style.backgroundColor := "FDCAAE" ; �޸ġ���������򡿱���ɫ
doc.getElementById("login").value := "�����¼ :)" ; �޸ġ���¼��ť������
doc.getElementById("login").style.Color := "Red"   ; �޸ġ���¼��ť��������ɫ
doc.getElementById("login").style.backgroundColor := "FFFF00" ; �޸ġ���¼��ť��������ɫ
doc.images[0].src := "http://t1.qpic.cn/mblogpic/7d0ba55a04cb2e504246/2000.jpg" ; �޸� logo ͼƬ

; =================================
;		����¼�
; =================================
; ��� doc �¼�
ComObjConnect(doc, doc_events)

; ����¼��ť���� form ���¼�
form := doc.forms[0]
ComObjConnect(form, "LoginForm_")

; ����¼��ť�¼�
LogInBtn := doc.getElementById("login")
ComObjConnect(LogInBtn, "LogInBtn_")

; ����¼��ť�ϼ�<TD>�¼�
LogInBtnPTD := LogInBtn.parentNode
ComObjConnect(LogInBtnPTD, "LogInBtnPTD_")

; =================================
;		���ö�ʱ�ƶ���¼��ť
; =================================
LogInBtn.style.position := "relative" ; ��ťλ����Ϊ���λ��
MoveStep                := -50 ; ��ť�ƶ�����
BtnW                    := LogInBtn.offsetWidth ; ��ť���
BtnPW                   := LogInBtn.parentNode.offsetWidth ; ��ť���ϼ�Ԫ�صĿ��
SetTimer, Move_LogInBtn, 200
Return

; =================================
;		�ƶ���¼��ť
; =================================
Move_LogInBtn:
	x += MoveStep
	LogInBtn.style.left := x

	BtnX := LogInBtn.offsetLeft
	MoveStep := ( BtnX < Abs(MoveStep) || (BtnX + BtnW >= BtnPW) ) ? -MoveStep : MoveStep
Return

; =================================
;		�رս������˳��ű�
; =================================
GuiClose:
ExitApp

; ================================================== �����Ǻ��� ==================================================

; =================================
;		���� wb �ĵ����¼�
; =================================
Class doc_events
{
	oncontextmenu(doc) {
		doc.parentWindow.event.returnvalue := False ; ȡ���¼��Ķ���
		MsgBox, �Ҽ���������
	}

	OnClick(doc) {
	    if doc.parentWindow.event.srcElement.name in username,password
	    	doc.parentWindow.event.srcElement.value := doc.parentWindow.event.srcElement.name
	}

	ondblclick(doc) {
		MsgBox, ��⵽˫��
	}
}

; =================================
;		��¼��ť���� form ���¼�
; =================================
LoginForm_onsubmit(form) {
	form.document.parentWindow.event.returnvalue := False ; ȡ���¼��Ķ���
	form.document.getElementById("login").value := "�����¼ :)" ; ��ť���ֻᱻ��ҳ�ָ������������޸ġ���¼��ť������
	MsgBox, ��¼������ȡ����
}

; =================================
;		��¼��ť�ϼ� <TD> ���¼�
; =================================

; �����ͣ
LogInBtnPTD_onmouseover(LogInBtn) {
	SetTimer, Move_LogInBtn, Off ; ֹͣ�ƶ���ť
}

; ����ƿ�
LogInBtnPTD_onmouseout(LogInBtn) {
	SetTimer, Move_LogInBtn, 200 ; �ָ��ƶ���ť
}

; =================================
;		��¼��ť���¼�
; =================================

; �����ͣ
LogInBtn_onmouseover(LogInBtn) {
	LogInBtn.style.backgroundColor := "FDD0FD"
}

; ����ƿ�
LogInBtn_onmouseout(LogInBtn) {
	LogInBtn.style.backgroundColor := "FFFF00"
}