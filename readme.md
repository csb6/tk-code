TK-CODE EDITOR

[![IMAGE ALT TEXT](http://img.youtube.com/vi/7E6L7qqxqCs/0.jpg)](http://www.youtube.com/watch?v=7E6L7qqxqCs "Video Title")

Tk-Code is a prototype clone of VS Code written in Ruby/Tk. It aims to replicate the cross platform, intuitive nature of VS Code using far less memory. Tk is a UI toolkit that creates cross-platform applications with native-like widgets, resulting in a more efficient use of system resources than an application running essentially a web browser.

I've started work implementing support for VS Code add-ons, so eventually they can be used for this application without modification.

I plan to increasingly implement the functionality/interface layout of VS Code in native widgets. It may be uglier, but it fits the appearance of the OS better, while using less memory. But the present version is nowhere close to implementing VS Code's massive feature set.

As a rough estimate (hardly scientific), tk-code uses around 80 MB of memory, temporarily jumping to 130 MB when opening new files before garbage collection occurs. With the same files open, the various VS Code processes' combined usage hovers around 360 MB. This is a significant reduction, achieved without any code optimization.

Please remember that this is a prototype application. Use with caution; there may be bugs!

Current features:
-Multi-document editing with tabs
-Simple, in-window terminal
-File tree for working directory with the ability to open files into new tabs

Planned features:
-Code highlighting
-Support for VS Code extensions
-Support for fancy styling/syntax highlighting
