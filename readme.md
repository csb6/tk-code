TK-CODE EDITOR

Tk-Code is a prototype clone of VS Code written in Ruby/Tk. It aims to replicate the cross platform, intuitive nature of VS Code using far less memory. Tk is a UI toolkit that creates native applications using cross-platform code, resulting in a more efficient use of system resources than an application running in a Chromium framework.

Eventually, the program will replicate VS Code's abilities to the point where even VS Code extensions can be added and used unaltered. However, this feature is not yet implemented.

I plan to increasingly implement the functionality/interface layout of VS Code in native widgets. It may be uglier, but it fits the look-and-feel of the OS better, while using less memory. But the present version is nowhere close to implementing most of VS Code's broad feature set.

As a rough estimate (hardly scientific), tk-code uses around 80 MB of memory, temporarily jumping to 130 MB when opening new files before garbage collection occurs. With the same files open, the various VS Code processes' combined usage hovers around 360 MB. This is a significant reduction, achieved without any code optimization.

Please remember that this is a prototype application. Use with caution; there may be bugs!

Current features:
-Multi-document editing with tabs
-In-window 9term-like terminal
-File tree for working directory with the ability to open files into new tabs
-Line numbers

Planned features:
-Code highlighting
-Support for VS Code extensions
-Support for fancy styling/syntax highlighting