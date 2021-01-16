nmap <buffer> <localleader>crr  :!npx ts-node % 2>&1 \| tee $NVIM_LISTEN_ADDRESS <cr>
