alias sl='./manage.py shell_plus'

function ,delpyc {
    find . -iname '*.pyc' -delete
}

function ,genctagspy {
    ctags -R --exclude=.git --exclude=assets --languages=python
}

function ,py-block-test-file {
    # move file given as argument to the same path but start name with BLOCKED_
}
