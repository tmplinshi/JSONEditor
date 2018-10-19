﻿/*
	https://github.com/tmplinshi/JSONEditor
	
	Credits: Jxon by CoCo, https://autohotkey.com/boards/viewtopic.php?t=627
*/

; Available mode values: tree, view, form, code, text.

JsonBox(ByRef json = "", title = "", mode = "code", gui_option = "w700 h560")
{
	JsonBox.show(json, title, mode, gui_option)
}

class JsonBox
{
	show(ByRef json = "", title = "", mode = "code", gui_option = "w700 h560") {
		static wb

		Gui, j_v_999_:+Resize +HwndhGUI
		Gui, j_v_999_:Margin, 0, 0
		Gui, j_v_999_:Add, ActiveX, vWB w700 h560 %gui_option% HWNDhWb, %A_LineFile%\..\jsoneditor-5.15.0\jsonEditor.html
		wb.silent := true
		Gui, j_v_999_:Show, %gui_option%, %title%

		this.hGUI := hGUI
		this.wb := wb
		this.hWb := hWb

		OnMessage(WM_KEYDOWN:=0x100, ObjBindMethod(this, "gui_KeyDown"))
		OnMessage(WM_SIZE:=0x05, ObjBindMethod(this, "gui_size"))

		if json {
			while WB.ReadyState != 4
				Sleep 50

			; https://github.com/josdejong/jsoneditor/blob/master/docs/api.md
			wb.document.parentWindow.editor.setText( IsObject(json) ? Jxon_Dump(json) : json )
			wb.document.parentWindow.editor.setMode(mode)
		}
		WinWaitClose, ahk_id %hGUI%
		Gui, j_v_999_:Destroy
		return
	}

	gui_size(wParam, lParam, msg, hwnd) {
		if (this.hGUI != hwnd || wParam=1)
			return

		w := lParam & 0xFFFF
		h := lParam >> 16
		GuiControl, Move, % this.hWb, w%w% h%h%
	}

	gui_KeyDown(wParam, lParam, nMsg, hWnd) { ; http://www.autohotkey.com/board/topic/83954-problem-with-activex-gui/#entry535202
		pipa := ComObjQuery(this.wb, "{00000117-0000-0000-C000-000000000046}")
		VarSetCapacity(kMsg, 48), NumPut(A_GuiY, NumPut(A_GuiX
		, NumPut(A_EventInfo, NumPut(lParam, NumPut(wParam
		, NumPut(nMsg, NumPut(hWnd, kMsg)))), "uint"), "int"), "int")
		Loop 2
			r := DllCall(NumGet(NumGet(1*pipa)+5*A_PtrSize), "ptr", pipa, "ptr", &kMsg)
		; Loop to work around an odd tabbing issue (it's as if there
		; is a non-existent element at the end of the tab order).
		until wParam != 9 || this.wb.Document.activeElement != ""
		ObjRelease(pipa)
		if r = 0 ; S_OK: the message was translated to an accelerator.
			return 0
	}
}