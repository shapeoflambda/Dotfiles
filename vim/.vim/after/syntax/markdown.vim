" Make todo-list items look pretty
syntax match ListItem "\%(\t\| \{0,4\}\)[-*+]\%(\s\+\S\)\@=" conceal cchar=◉

highlight! link ListItem Todo
