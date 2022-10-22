CURRENT_PROJECT_PATH="/tmp/current"

function ww {
    cd $CURRENT_PROJECT_PATH
    activate_nvm  # for nvim LSP

    # other stuff
    . env/bin/activate
}


function edit_current_project {
    nvim ~/.zfunctions/current.zsh
}
