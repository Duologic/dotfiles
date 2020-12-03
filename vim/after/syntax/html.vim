" Fixes bogus less than formatting in vim-markdown
" https://github.com/plasticboy/vim-markdown/issues/138#issuecomment-654345013
syn clear htmlTag
syn region  htmlTag                start=+<[[:alnum:]]+   end=+>+ fold contains=htmlTagN,htmlString,htmlArg,htmlValue,htmlTagError,htmlEvent,htmlCssDefinition,@htmlPreproc,@htmlArgCluster
