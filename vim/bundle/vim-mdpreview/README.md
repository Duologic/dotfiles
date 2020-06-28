# vim-mdpreview

This plugin can render Markdown to HTML or a man-page and display them inside Vim. Once called, the render will update on
each save.

    :call MDMan()
    :call MDLynx()

MDMan() depends on Pandoc, GROFF(1) and LESS(1).

MDLynx() depends on Pandoc and Lynx.

Note: requires Vim>=8.1 with terminal window support.
