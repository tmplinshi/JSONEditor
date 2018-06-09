AutoHotkey GUI using jsoneditor (https://github.com/josdejong/jsoneditor)

![Screenshot](https://github.com/tmplinshi/JSONEditor/blob/master/Screenshot.png?raw=true)

--------

The **MsgBox.ahk** includes 2 functions:

```AutoHotkey
MsgBox_Json(ByRef sJson = "", title = "", mode = "view", gui_option = "w700 h560")
```

```AutoHotkey
MsgBox_Obj(obj, title = "", mode = "view", gui_option = "w700 h560")
```

*Available `mode` values: tree, view, form, code, text.*

**Examples:**
```AutoHotkey
obj := { items: ["a", "b"], key1: "value2", key2: "value2" }
MsgBox_Obj(obj)
```

```AutoHotkey
whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", "https://httpbin.org/get?key=val")
whr.Send()

MsgBox_Json(whr.ResponseText)
MsgBox_Json(whr.ResponseText,, "code") ; Display the data using 'code' mode
MsgBox % whr.ResponseText
```
