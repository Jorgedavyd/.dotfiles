PROMPT="%(?:%{$fg_bold[blue]%}%1{λ%} :%{$fg_bold[red]%}%1{λ%} ) %{$fg_bold[cyan]%}%c%{$reset_color%}"
PROMPT+=' $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "

