TK-CODE EDITOR

Tk-Code is a prototype clone of VS Code written in Ruby/Tk. It aims to replicate the cross platform, intuitive nature of VS Code using far less memory. Tk is a UI toolkit that creates native applications using cross-platform code, resulting in a more efficient use of system resources than an application running in a Chromium framework.

Eventually, the program will replicate VS Code's abilities to the point where even VS Code extensions can be added and used unaltered. However, this feature is not yet implemented.

I plan to increasingly implement the functionality/interface layout of VS Code in native widgets. It may be uglier, but it fits the look-and-feel of the OS better, while using less memory. But the present version is nowhere close to implementing most of VS Code's broad feature set.

Please remember that this is a prototype application. Use with caution; there may be bugs!

Current features:
-Multi-document editing with tabs
-In-window 9term-like terminal
-File tree for working directory with the ability to open files into new tabs

Planned features:
-Code highlighting
-Support for VS Code extensions
-Support for fancy styling/syntax highlighting