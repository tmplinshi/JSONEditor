; Require Internet Explorer 9+

#NoEnv
#NoTrayIcon
#SingleInstance Force
#KeyHistory 0
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
ListLines Off

Gui, +Resize
Gui, Margin, 0, 0
Gui, Add, ActiveX, vWB w700 h560, %A_ScriptDir%\jsoneditor-5.15.0\jsonEditor.html
Gui, Show, w700 h560, JSON Editor
ComObjConnect(WB, "WB_")
OnMessage(WM_KEYDOWN:=0x100, "gui_KeyDown", 2)
Return

GuiSize:
	if (ErrorLevel != 1)
		GuiControl, Move, wb, w%A_GuiWidth% h%A_GuiHeight%
return

GuiClose:
ExitApp

; handle file drop
WB_BeforeNavigate2(pDisp, Url, Flags, TargetFrameName, PostData, Headers, Cancel) {
	cancel[] := true
	FileRead, json, %Url%
	pDisp.document.parentWindow.editor.setText(json)
}

gui_KeyDown(wParam, lParam, nMsg, hWnd) { ; http://www.autohotkey.com/board/topic/83954-problem-with-activex-gui/#entry535202
	global wb
	pipa := ComObjQuery(wb, "{00000117-0000-0000-C000-000000000046}")
	VarSetCapacity(kMsg, 48), NumPut(A_GuiY, NumPut(A_GuiX
	, NumPut(A_EventInfo, NumPut(lParam, NumPut(wParam
	, NumPut(nMsg, NumPut(hWnd, kMsg)))), "uint"), "int"), "int")
	Loop 2
		r := DllCall(NumGet(NumGet(1*pipa)+5*A_PtrSize), "ptr", pipa, "ptr", &kMsg)
	; Loop to work around an odd tabbing issue (it's as if there
	; is a non-existent element at the end of the tab order).
	until wParam != 9 || wb.Document.activeElement != ""
	ObjRelease(pipa)
	if r = 0 ; S_OK: the message was translated to an accelerator.
		return 0
}