AutoHotkey GUI using jsoneditor (https://github.com/josdejong/jsoneditor)

# JSONEditor.ahk
![Screenshot](https://github.com/tmplinshi/JSONEditor/blob/master/Screenshot.png?raw=true)

--------

# JsonBox.ahk
(Require Jxon.ahk by CoCo)
```AutoHotkey
JsonBox(ByRef json = "", title = "", mode = "view", gui_option = "w700 h560")
```
- json: Json string or AHK object
- title: Window title
- mode: Value can be tree, view, form, code, text

**Examples:**
```AutoHotkey
obj := { items: ["a", "b"], key1: "value2", key2: "value2" }
JsonBox(obj)
```

```AutoHotkey
whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", "https://httpbin.org/get?key=val")
whr.Send()

JsonBox(whr.ResponseText,, "view") ; Display the data in 'view' mode
JsonBox(whr.ResponseText)
MsgBox % whr.ResponseText
```
